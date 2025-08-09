import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../services/network_service.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';

class AuthRepository {
  // Login with Firebase token
  Future<AuthResult> loginWithFirebaseToken(String firebaseToken) async {
    try {
      final response = await NetworkService.post('/auth/login', data: {
        'firebaseToken': firebaseToken,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        final user = UserModel.fromJson(data['user']);
        final jwtToken = data['token'] as String;
        final refreshToken = data['refreshToken'] as String;

        // Save tokens and user data
        await StorageService.saveTokens(
          jwtToken: jwtToken,
          refreshToken: refreshToken,
        );
        await StorageService.saveUser(user);

        // Update FCM token on server
        final fcmToken = await NotificationService.getFCMToken();
        if (fcmToken != null) {
          await updateFCMToken(fcmToken);
        }

        return AuthResult.success(user);
      } else {
        return AuthResult.failure('Login failed');
      }
    } on DioException catch (e) {
      return AuthResult.failure(_handleDioError(e));
    } catch (e) {
      return AuthResult.failure('An unexpected error occurred');
    }
  }

  // Refresh token
  Future<bool> refreshToken() async {
    try {
      final refreshToken = await StorageService.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await NetworkService.post('/auth/refresh', data: {
        'refreshToken': refreshToken,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        final newJwtToken = data['token'] as String;
        final newRefreshToken = data['refreshToken'] as String;

        await StorageService.saveTokens(
          jwtToken: newJwtToken,
          refreshToken: newRefreshToken,
        );

        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Update profile
  Future<UserModel?> updateProfile({
    String? displayName,
    String? firstName,
    String? lastName,
    String? email,
    String? profilePicture,
    String? aadharNumber,
    String? panNumber,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (displayName != null) data['displayName'] = displayName;
      if (firstName != null) data['firstName'] = firstName;
      if (lastName != null) data['lastName'] = lastName;
      if (email != null) data['email'] = email;
      if (profilePicture != null) data['profilePicture'] = profilePicture;
      if (aadharNumber != null) data['aadharNumber'] = aadharNumber;
      if (panNumber != null) data['panNumber'] = panNumber;

      final response = await NetworkService.patch('/auth/profile', data: data);

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data);
        await StorageService.saveUser(user);
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Update FCM token
  Future<bool> updateFCMToken(String fcmToken) async {
    try {
      await StorageService.saveFcmToken(fcmToken);
      
      final response = await NetworkService.patch('/auth/profile', data: {
        'fcmToken': fcmToken,
      });

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      final refreshToken = await StorageService.getRefreshToken();
      if (refreshToken != null) {
        await NetworkService.post('/auth/logout', data: {
          'refreshToken': refreshToken,
        });
      }
    } catch (e) {
      // Ignore logout errors
    } finally {
      await StorageService.clearAllData();
    }
  }

  // Get current user (offline-first)
  UserModel? getCurrentUser() {
    return StorageService.getCurrentUser();
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await StorageService.getJwtToken();
    final user = StorageService.getCurrentUser();
    return token != null && user != null;
  }

  String _handleDioError(DioException e) {
    if (e.response != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'];
      }
      return 'Server error: ${e.response!.statusCode}';
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Receive timeout';
    } else if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection';
    } else {
      return 'Network error occurred';
    }
  }
}

class AuthResult {
  final bool isSuccess;
  final UserModel? user;
  final String? error;

  AuthResult._({
    required this.isSuccess,
    this.user,
    this.error,
  });

  factory AuthResult.success(UserModel user) {
    return AuthResult._(isSuccess: true, user: user);
  }

  factory AuthResult.failure(String error) {
    return AuthResult._(isSuccess: false, error: error);
  }
}