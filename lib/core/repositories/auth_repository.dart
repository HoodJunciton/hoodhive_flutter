import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../models/user_model.dart';
import '../models/auth_models.dart';
import '../services/network_service.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';
import '../services/firebase_auth_service.dart';
import '../services/biometric_service.dart';

class AuthRepository {
  static final Logger _logger = Logger();

  // Send OTP to phone number
  Future<OTPResult> sendOTP(String phoneNumber) async {
    try {
      // Format and validate phone number
      final formattedPhone = FirebaseAuthService.formatPhoneNumber(phoneNumber);
      if (!FirebaseAuthService.isValidPhoneNumber(formattedPhone)) {
        return OTPResult.failure('Invalid phone number format');
      }

      String? verificationId;
      String? error;

      await FirebaseAuthService.sendOTP(
        phoneNumber: formattedPhone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification completed
          try {
            final idToken = await FirebaseAuthService.signInWithCredential(credential);
            final authResult = await loginWithFirebaseToken(idToken);
            if (authResult.isSuccess) {
              // Handle auto-verification success
            }
          } catch (e) {
            _logger.e('Auto-verification error: $e');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          error = e.message ?? 'Verification failed';
        },
        codeSent: (String vId, int? resendToken) {
          verificationId = vId;
        },
        codeAutoRetrievalTimeout: (String vId) {
          verificationId = vId;
        },
      );

      if (error != null) {
        return OTPResult.failure(error!);
      }

      if (verificationId != null) {
        return OTPResult.success(verificationId!);
      }

      return OTPResult.failure('Failed to send OTP');
    } catch (e) {
      _logger.e('Error sending OTP: $e');
      return OTPResult.failure(e.toString());
    }
  }

  // Verify OTP and login
  Future<AuthResult> verifyOTPAndLogin({
    required String verificationId,
    required String otp,
  }) async {
    try {
      final idToken = await FirebaseAuthService.verifyOTP(
        verificationId: verificationId,
        smsCode: otp,
      );

      return await loginWithFirebaseToken(idToken);
    } catch (e) {
      _logger.e('Error verifying OTP: $e');
      return AuthResult.failure(e.toString());
    }
  }

  // Login with Firebase token
  Future<AuthResult> loginWithFirebaseToken(String firebaseToken) async {
    try {
      final request = FirebaseLoginRequest(firebaseToken: firebaseToken);
      final response = await NetworkService.post('/auth/login', data: request.toJson());

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(response.data);
        
        // Convert UserData to UserModel for compatibility
        final user = UserModel(
          id: loginResponse.user.id,
          email: loginResponse.user.email,
          phoneNumber: loginResponse.user.phoneNumber,
          role: loginResponse.user.role,
          displayName: loginResponse.user.displayName ?? '',
          profilePicture: loginResponse.user.profilePicture,
          isProfileActive: loginResponse.user.isProfileActive,
        );

        // Save tokens and user data
        await StorageService.saveTokens(
          jwtToken: loginResponse.token,
          refreshToken: loginResponse.refreshToken ?? '',
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
      _logger.e('Login error: $e');
      return AuthResult.failure('An unexpected error occurred');
    }
  }

  // Biometric login
  Future<AuthResult> loginWithBiometric() async {
    try {
      if (!await BiometricService.isBiometricLoginEnabled()) {
        return AuthResult.failure('Biometric login is not enabled');
      }

      final tokens = await BiometricService.authenticateAndGetTokens();
      if (tokens == null) {
        return AuthResult.failure('Biometric authentication failed');
      }

      // Validate stored tokens
      await StorageService.saveTokens(
        jwtToken: tokens['accessToken']!,
        refreshToken: tokens['refreshToken']!,
      );

      // Try to refresh token to ensure it's still valid
      final refreshSuccess = await refreshToken();
      if (!refreshSuccess) {
        await BiometricService.clearBiometricData();
        return AuthResult.failure('Stored credentials are invalid');
      }

      final user = getCurrentUser();
      if (user != null) {
        return AuthResult.success(user);
      } else {
        return AuthResult.failure('User data not found');
      }
    } catch (e) {
      _logger.e('Biometric login error: $e');
      return AuthResult.failure('Biometric login failed');
    }
  }

  // Enable biometric login
  Future<bool> enableBiometricLogin() async {
    try {
      if (!await BiometricService.isBiometricAvailable()) {
        return false;
      }

      final accessToken = await StorageService.getJwtToken();
      final refreshToken = await StorageService.getRefreshToken();

      if (accessToken == null || refreshToken == null) {
        return false;
      }

      await BiometricService.storeBiometricTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
      await BiometricService.enableBiometricLogin();

      return true;
    } catch (e) {
      _logger.e('Error enabling biometric login: $e');
      return false;
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
      _logger.w('Logout API call failed: $e');
    } finally {
      // Clear all local data
      await StorageService.clearAllData();
      await FirebaseAuthService.signOut();
      await BiometricService.clearBiometricData();
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

class OTPResult {
  final bool isSuccess;
  final String? verificationId;
  final String? error;

  OTPResult._({
    required this.isSuccess,
    this.verificationId,
    this.error,
  });

  factory OTPResult.success(String verificationId) {
    return OTPResult._(isSuccess: true, verificationId: verificationId);
  }

  factory OTPResult.failure(String error) {
    return OTPResult._(isSuccess: false, error: error);
  }
}