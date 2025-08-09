import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';

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
          state = AuthState.authenticated(user);
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

  Future<void> loginWithFirebaseToken(String firebaseToken) async {
    state = const AuthState.loading();
    
    try {
      final result = await _authRepository.loginWithFirebaseToken(firebaseToken);
      
      if (result.isSuccess && result.user != null) {
        state = AuthState.authenticated(result.user!);
      } else {
        state = AuthState.error(result.error ?? 'Login failed');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
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

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final UserModel? user;
  final String? error;

  const AuthState._({
    required this.isAuthenticated,
    required this.isLoading,
    this.error,
    this.user
  });

  const AuthState.initial()
      : isAuthenticated = false,
        isLoading = true,
        user = null,
        error = null;

  const AuthState.loading()
      : isAuthenticated = false,
        isLoading = true,
        user = null,
        error = null;

  const AuthState.authenticated(UserModel user)
      : isAuthenticated = true,
        isLoading = false,
        user = user,
        error = null;

  const AuthState.unauthenticated()
      : isAuthenticated = false,
        isLoading = false,
        user = null,
        error = null;

  const AuthState.error(String error)
      : isAuthenticated = false,
        isLoading = false,
        user = null,
        error = error;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState &&
        other.isAuthenticated == isAuthenticated &&
        other.isLoading == isLoading &&
        other.user == user &&
        other.error == error;
  }

  @override
  int get hashCode {
    return isAuthenticated.hashCode ^
        isLoading.hashCode ^
        user.hashCode ^
        error.hashCode;
  }
}