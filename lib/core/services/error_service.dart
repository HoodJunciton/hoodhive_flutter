import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

class ErrorService {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  // Log different types of errors
  static void logError(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
  }) {
    _logger.e(
      message,
      error: error,
      stackTrace: stackTrace,
    );

    // In production, send to crash reporting service
    if (kReleaseMode) {
      _sendToCrashlytics(message, error, stackTrace, extra);
    }
  }

  static void logWarning(
    String message, {
    Map<String, dynamic>? extra,
  }) {
    _logger.w(message);
  }

  static void logInfo(
    String message, {
    Map<String, dynamic>? extra,
  }) {
    _logger.i(message);
  }

  static void logDebug(
    String message, {
    Map<String, dynamic>? extra,
  }) {
    _logger.d(message);
  }

  // Handle different types of exceptions
  static AppError handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is AppError) {
      return error;
    } else {
      return AppError(
        type: ErrorType.unknown,
        message: error.toString(),
        originalError: error,
      );
    }
  }

  static AppError _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError(
          type: ErrorType.network,
          message: 'Connection timeout. Please check your internet connection.',
          originalError: error,
        );

      case DioExceptionType.connectionError:
        return AppError(
          type: ErrorType.network,
          message: 'No internet connection. Please check your network settings.',
          originalError: error,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;

        switch (statusCode) {
          case 400:
            return AppError(
              type: ErrorType.validation,
              message: _extractErrorMessage(data) ?? 'Invalid request data.',
              originalError: error,
            );

          case 401:
            return AppError(
              type: ErrorType.authentication,
              message: 'Authentication failed. Please login again.',
              originalError: error,
            );

          case 403:
            return AppError(
              type: ErrorType.authorization,
              message: 'You don\'t have permission to perform this action.',
              originalError: error,
            );

          case 404:
            return AppError(
              type: ErrorType.notFound,
              message: 'The requested resource was not found.',
              originalError: error,
            );

          case 409:
            return AppError(
              type: ErrorType.conflict,
              message: _extractErrorMessage(data) ?? 'Data conflict occurred.',
              originalError: error,
            );

          case 422:
            return AppError(
              type: ErrorType.validation,
              message: _extractErrorMessage(data) ?? 'Validation failed.',
              originalError: error,
            );

          case 429:
            return AppError(
              type: ErrorType.rateLimit,
              message: 'Too many requests. Please try again later.',
              originalError: error,
            );

          case 500:
          case 502:
          case 503:
          case 504:
            return AppError(
              type: ErrorType.server,
              message: 'Server error occurred. Please try again later.',
              originalError: error,
            );

          default:
            return AppError(
              type: ErrorType.server,
              message: _extractErrorMessage(data) ?? 'An unexpected error occurred.',
              originalError: error,
            );
        }

      case DioExceptionType.cancel:
        return AppError(
          type: ErrorType.cancelled,
          message: 'Request was cancelled.',
          originalError: error,
        );

      default:
        return AppError(
          type: ErrorType.unknown,
          message: 'An unexpected error occurred.',
          originalError: error,
        );
    }
  }

  static String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] ?? data['error'] ?? data['detail'];
    }
    return null;
  }

  static void _sendToCrashlytics(
    String message,
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
  ) {
    // TODO: Implement Firebase Crashlytics
    // FirebaseCrashlytics.instance.recordError(
    //   error,
    //   stackTrace,
    //   reason: message,
    //   information: extra?.entries.map((e) => DiagnosticsProperty(e.key, e.value)).toList(),
    // );
  }

  // User-friendly error messages
  static String getUserFriendlyMessage(AppError error) {
    switch (error.type) {
      case ErrorType.network:
        return 'Please check your internet connection and try again.';
      case ErrorType.authentication:
        return 'Please login again to continue.';
      case ErrorType.authorization:
        return 'You don\'t have permission to access this feature.';
      case ErrorType.validation:
        return error.message;
      case ErrorType.notFound:
        return 'The requested information could not be found.';
      case ErrorType.server:
        return 'Something went wrong on our end. Please try again later.';
      case ErrorType.rateLimit:
        return 'You\'re doing that too often. Please wait a moment and try again.';
      case ErrorType.conflict:
        return 'There was a conflict with your request. Please refresh and try again.';
      case ErrorType.cancelled:
        return 'The operation was cancelled.';
      case ErrorType.unknown:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}

enum ErrorType {
  network,
  authentication,
  authorization,
  validation,
  notFound,
  server,
  rateLimit,
  conflict,
  cancelled,
  unknown,
}

class AppError {
  final ErrorType type;
  final String message;
  final dynamic originalError;
  final Map<String, dynamic>? extra;

  AppError({
    required this.type,
    required this.message,
    this.originalError,
    this.extra,
  });

  @override
  String toString() {
    return 'AppError(type: $type, message: $message)';
  }
}

// Extension for easy error handling in widgets
extension ErrorHandling on Object {
  AppError toAppError() {
    return ErrorService.handleError(this);
  }
}

// Mixin for consistent error handling in providers
mixin ErrorHandlerMixin {
  void handleError(dynamic error, {String? context}) {
    final appError = ErrorService.handleError(error);
    ErrorService.logError(
      context ?? 'Error occurred',
      error: appError.originalError,
      extra: appError.extra,
    );
  }

  String getErrorMessage(dynamic error) {
    final appError = ErrorService.handleError(error);
    return ErrorService.getUserFriendlyMessage(appError);
  }
}