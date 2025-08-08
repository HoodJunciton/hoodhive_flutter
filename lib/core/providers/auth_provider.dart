import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../models/auth_models.dart';
import '../repositories/auth_repository.dart';
import '../services/biometric_service.dart';

// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Auth State Provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

// Current User Provider
final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.user;
});

// Auth Status Provider
final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isAuthenticated;
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState.initial()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    state = const AuthState.loading();
    
    try {
      final isLoggedIn = await _authRepository.isLoggedIn();
      if (isLoggedIn) {
        final user = _authRepository.getCurrentUser();
        if (user != null) {
          // Convert UserModel to UserData for the new AuthState
          final userData = UserData(
            id: user.id,
            email: user.email,
            phoneNumber: user.phoneNumber,
            role: user.role,
            displayName: user.displayName,
            profilePicture: user.profilePicture,
            isProfileActive: user.isProfileActive,
            createdAt: DateTime.now(), // Fallback
            updatedAt: DateTime.now(), // Fallback
          );
          state = AuthState.authenticated(userData);
        } else {
          state = const AuthState.unauthenticated();
        }
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Send OTP to phone number
  Future<String?> sendOTP(String phoneNumber) async {
    try {
      final result = await _authRepository.sendOTP(phoneNumber);
      if (result.isSuccess) {
        return result.verificationId;
      } else {
        state = AuthState.error(result.error ?? 'Failed to send OTP');
        return null;
      }
    } catch (e) {
      state = AuthState.error(e.toString());
      return null;
    }
  }

  // Verify OTP and login
  Future<void> verifyOTPAndLogin({
    required String verificationId,
    required String otp,
  }) async {
    state = const AuthState.loading();
    
    try {
      final result = await _authRepository.verifyOTPAndLogin(
        verificationId: verificationId,
        otp: otp,
      );
      
      if (result.isSuccess && result.user != null) {
        final userData = UserData(
          id: result.user!.id,
          email: result.user!.email,
          phoneNumber: result.user!.phoneNumber,
          role: result.user!.role,
          displayName: result.user!.displayName,
          profilePicture: result.user!.profilePicture,
          isProfileActive: result.user!.isProfileActive,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        state = AuthState.authenticated(userData);
      } else {
        state = AuthState.error(result.error ?? 'Login failed');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Login with Firebase token (for backward compatibility)
  Future<void> loginWithFirebaseToken(String firebaseToken) async {
    state = const AuthState.loading();
    
    try {
      final result = await _authRepository.loginWithFirebaseToken(firebaseToken);
      
      if (result.isSuccess && result.user != null) {
        final userData = UserData(
          id: result.user!.id,
          email: result.user!.email,
          phoneNumber: result.user!.phoneNumber,
          role: result.user!.role,
          displayName: result.user!.displayName,
          profilePicture: result.user!.profilePicture,
          isProfileActive: result.user!.isProfileActive,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        state = AuthState.authenticated(userData);
      } else {
        state = AuthState.error(result.error ?? 'Login failed');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Biometric login
  Future<void> loginWithBiometric() async {
    state = const AuthState.loading();
    
    try {
      final result = await _authRepository.loginWithBiometric();
      
      if (result.isSuccess && result.user != null) {
        final userData = UserData(
          id: result.user!.id,
          email: result.user!.email,
          phoneNumber: result.user!.phoneNumber,
          role: result.user!.role,
          displayName: result.user!.displayName,
          profilePicture: result.user!.profilePicture,
          isProfileActive: result.user!.isProfileActive,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        state = AuthState.authenticated(userData);
      } else {
        state = AuthState.error(result.error ?? 'Biometric login failed');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Enable biometric login
  Future<bool> enableBiometricLogin() async {
    try {
      return await _authRepository.enableBiometricLogin();
    } catch (e) {
      return false;
    }
  }

  // Check if biometric is available
  Future<bool> isBiometricAvailable() async {
    return await BiometricService.isBiometricAvailable();
  }

  // Check if biometric login is enabled
  Future<bool> isBiometricLoginEnabled() async {
    return await BiometricService.isBiometricLoginEnabled();
  }

  Future<void> updateProfile({
    String? displayName,
    String? firstName,
    String? lastName,
    String? email,
    String? profilePicture,
    String? aadharNumber,
    String? panNumber,
  }) async {
    if (state.user == null) return;

    try {
      final updatedUser = await _authRepository.updateProfile(
        displayName: displayName,
        firstName: firstName,
        lastName: lastName,
        email: email,
        profilePicture: profilePicture,
        aadharNumber: aadharNumber,
        panNumber: panNumber,
      );

      if (updatedUser != null) {
        state = AuthState.authenticated(updatedUser);
      }
    } catch (e) {
      // Handle error but don't change auth state
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      state = const AuthState.unauthenticated();
    } catch (e) {
      // Even if logout fails on server, clear local state
      state = const AuthState.unauthenticated();
    }
  }

  Future<bool> refreshToken() async {
    try {
      return await _authRepository.refreshToken();
    } catch (e) {
      return false;
    }
  }
}

// Additional providers for biometric functionality
final biometricAvailableProvider = FutureProvider<bool>((ref) async {
  return await BiometricService.isBiometricAvailable();
});

final biometricEnabledProvider = FutureProvider<bool>((ref) async {
  return await BiometricService.isBiometricLoginEnabled();
});