import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:hoodhive_flutter/core/repositories/auth_repository.dart';
import 'package:hoodhive_flutter/core/models/user_model.dart';
import 'package:hoodhive_flutter/core/services/network_service.dart';
import 'package:hoodhive_flutter/core/services/storage_service.dart';

// Generate mocks
@GenerateMocks([NetworkService, StorageService])
import 'auth_repository_test.mocks.dart';

void main() {
  group('AuthRepository', () {
    late AuthRepository authRepository;
    late MockNetworkService mockNetworkService;
    late MockStorageService mockStorageService;

    setUp(() {
      mockNetworkService = MockNetworkService();
      mockStorageService = MockStorageService();
      authRepository = AuthRepository();
    });

    group('loginWithFirebaseToken', () {
      test('should return success result when login is successful', () async {
        // Arrange
        const firebaseToken = 'firebase_token';
        final mockUser = UserModel(
          id: 'user_id',
          email: 'test@example.com',
          phoneNumber: '+1234567890',
          role: 'USER',
          displayName: 'Test User',
          isProfileActive: true,
        );
        
        final mockResponse = Response(
          requestOptions: RequestOptions(path: '/auth/login'),
          statusCode: 200,
          data: {
            'user': mockUser.toJson(),
            'token': 'jwt_token',
            'refreshToken': 'refresh_token',
          },
        );

        when(mockNetworkService.post('/auth/login', data: anyNamed('data')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await authRepository.loginWithFirebaseToken(firebaseToken);

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.user, equals(mockUser));
        expect(result.error, isNull);
      });

      test('should return failure result when login fails', () async {
        // Arrange
        const firebaseToken = 'firebase_token';
        
        when(mockNetworkService.post('/auth/login', data: anyNamed('data')))
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: '/auth/login'),
              response: Response(
                requestOptions: RequestOptions(path: '/auth/login'),
                statusCode: 401,
                data: {'message': 'Invalid token'},
              ),
            ));

        // Act
        final result = await authRepository.loginWithFirebaseToken(firebaseToken);

        // Assert
        expect(result.isSuccess, isFalse);
        expect(result.user, isNull);
        expect(result.error, isNotNull);
      });
    });

    group('refreshToken', () {
      test('should return true when token refresh is successful', () async {
        // Arrange
        const refreshToken = 'refresh_token';
        
        when(mockStorageService.getRefreshToken())
            .thenAnswer((_) async => refreshToken);
        
        final mockResponse = Response(
          requestOptions: RequestOptions(path: '/auth/refresh'),
          statusCode: 200,
          data: {
            'token': 'new_jwt_token',
            'refreshToken': 'new_refresh_token',
          },
        );

        when(mockNetworkService.post('/auth/refresh', data: anyNamed('data')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await authRepository.refreshToken();

        // Assert
        expect(result, isTrue);
      });

      test('should return false when refresh token is null', () async {
        // Arrange
        when(mockStorageService.getRefreshToken())
            .thenAnswer((_) async => null);

        // Act
        final result = await authRepository.refreshToken();

        // Assert
        expect(result, isFalse);
      });
    });

    group('updateProfile', () {
      test('should return updated user when profile update is successful', () async {
        // Arrange
        const displayName = 'Updated Name';
        final updatedUser = UserModel(
          id: 'user_id',
          email: 'test@example.com',
          phoneNumber: '+1234567890',
          role: 'USER',
          displayName: displayName,
          isProfileActive: true,
        );
        
        final mockResponse = Response(
          requestOptions: RequestOptions(path: '/auth/profile'),
          statusCode: 200,
          data: updatedUser.toJson(),
        );

        when(mockNetworkService.patch('/auth/profile', data: anyNamed('data')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await authRepository.updateProfile(displayName: displayName);

        // Assert
        expect(result, equals(updatedUser));
      });

      test('should return null when profile update fails', () async {
        // Arrange
        when(mockNetworkService.patch('/auth/profile', data: anyNamed('data')))
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: '/auth/profile'),
            ));

        // Act
        final result = await authRepository.updateProfile(displayName: 'Updated Name');

        // Assert
        expect(result, isNull);
      });
    });
  });
}