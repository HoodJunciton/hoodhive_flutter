import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';
import 'storage_service.dart';

class NetworkService {
  static final Dio _dio = Dio();
  static final Logger _logger = Logger();
  static final Connectivity _connectivity = Connectivity();
  static final InternetConnectionChecker _connectionChecker = InternetConnectionChecker();

  static Future<void> init() async {
    _dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors
    _dio.interceptors.add(_AuthInterceptor());
    _dio.interceptors.add(_LoggingInterceptor());
    _dio.interceptors.add(_RetryInterceptor());
  }

  static Dio get dio => _dio;

  // Network connectivity checks
  static Future<bool> isConnected() async {
    try {
      final connectivityResults = await _connectivity.checkConnectivity();
      if (connectivityResults.contains(ConnectivityResult.none)) {
        return false;
      }
      return await _connectionChecker.hasConnection;
    } catch (e) {
      _logger.e('Error checking connectivity: $e');
      return false;
    }
  }

  static Stream<bool> get connectivityStream {
    return _connectivity.onConnectivityChanged.asyncMap((_) async {
      return await isConnected();
    });
  }

  // HTTP Methods with offline handling
  static Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
  }) async {
    if (!await isConnected()) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        type: DioExceptionType.connectionError,
        message: 'No internet connection',
      );
    }

    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  static Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
  }) async {
    if (!await isConnected()) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        type: DioExceptionType.connectionError,
        message: 'No internet connection',
      );
    }

    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  static Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
  }) async {
    if (!await isConnected()) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        type: DioExceptionType.connectionError,
        message: 'No internet connection',
      );
    }

    return await _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  static Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
  }) async {
    if (!await isConnected()) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        type: DioExceptionType.connectionError,
        message: 'No internet connection',
      );
    }

    return await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await StorageService.getJwtToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired, try to refresh
      final refreshToken = await StorageService.getRefreshToken();
      if (refreshToken != null) {
        try {
          final response = await NetworkService._dio.post('/auth/refresh', data: {
            'refreshToken': refreshToken,
          });

          final newToken = response.data['token'];
          final newRefreshToken = response.data['refreshToken'];

          await StorageService.saveTokens(
            jwtToken: newToken,
            refreshToken: newRefreshToken,
          );

          // Retry the original request
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $newToken';
          final cloneReq = await NetworkService._dio.fetch(opts);
          handler.resolve(cloneReq);
          return;
        } catch (e) {
          // Refresh failed, clear tokens and redirect to login
          await StorageService.clearTokens();
          await StorageService.clearUser();
        }
      }
    }
    handler.next(err);
  }
}

class _LoggingInterceptor extends Interceptor {
  final Logger _logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
    _logger.d('Headers: ${options.headers}');
    _logger.d('Data: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    _logger.d('Data: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    _logger.e('Message: ${err.message}');
    _logger.e('Data: ${err.response?.data}');
    handler.next(err);
  }
}

class _RetryInterceptor extends Interceptor {
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      final retryCount = err.requestOptions.extra['retryCount'] ?? 0;
      if (retryCount < maxRetries) {
        err.requestOptions.extra['retryCount'] = retryCount + 1;
        
        await Future.delayed(retryDelay * (retryCount + 1));
        
        try {
          final response = await NetworkService._dio.fetch(err.requestOptions);
          handler.resolve(response);
          return;
        } catch (e) {
          // Continue with error handling
        }
      }
    }
    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           err.type == DioExceptionType.sendTimeout ||
           (err.response?.statusCode != null && err.response!.statusCode! >= 500);
  }
}