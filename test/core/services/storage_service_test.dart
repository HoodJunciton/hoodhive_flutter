import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hoodhive_flutter/core/services/storage_service.dart';
import 'package:hoodhive_flutter/core/models/user_model.dart';

void main() {
  group('StorageService', () {
    setUpAll(() async {
      // Initialize Hive for testing
      await Hive.initFlutter();
      
      // Register adapters
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(UserModelAdapter());
      }
      
      // Mock SharedPreferences
      SharedPreferences.setMockInitialValues({});
    });

    tearDownAll(() async {
      await Hive.deleteFromDisk();
    });

    group('Token Management', () {
      test('should save and retrieve JWT token', () async {
        const testToken = 'test_jwt_token';
        
        await StorageService.saveTokens(
          jwtToken: testToken,
          refreshToken: 'refresh_token',
        );
        
        final retrievedToken = await StorageService.getJwtToken();
        expect(retrievedToken, equals(testToken));
      });

      test('should save and retrieve refresh token', () async {
        const testRefreshToken = 'test_refresh_token';
        
        await StorageService.saveTokens(
          jwtToken: 'jwt_token',
          refreshToken: testRefreshToken,
        );
        
        final retrievedToken = await StorageService.getRefreshToken();
        expect(retrievedToken, equals(testRefreshToken));
      });

      test('should clear tokens', () async {
        await StorageService.saveTokens(
          jwtToken: 'jwt_token',
          refreshToken: 'refresh_token',
        );
        
        await StorageService.clearTokens();
        
        final jwtToken = await StorageService.getJwtToken();
        final refreshToken = await StorageService.getRefreshToken();
        
        expect(jwtToken, isNull);
        expect(refreshToken, isNull);
      });
    });

    group('User Data', () {
      test('should save and retrieve user', () async {
        final testUser = UserModel(
          id: 'test_id',
          email: 'test@example.com',
          phoneNumber: '+1234567890',
          role: 'USER',
          displayName: 'Test User',
          isProfileActive: true,
        );
        
        await StorageService.saveUser(testUser);
        final retrievedUser = StorageService.getCurrentUser();
        
        expect(retrievedUser, equals(testUser));
      });

      test('should clear user data', () async {
        final testUser = UserModel(
          id: 'test_id',
          email: 'test@example.com',
          phoneNumber: '+1234567890',
          role: 'USER',
          displayName: 'Test User',
          isProfileActive: true,
        );
        
        await StorageService.saveUser(testUser);
        await StorageService.clearUser();
        
        final retrievedUser = StorageService.getCurrentUser();
        expect(retrievedUser, isNull);
      });
    });

    group('Preferences', () {
      test('should save and retrieve boolean preference', () async {
        const key = 'test_bool';
        const value = true;
        
        await StorageService.setBool(key, value);
        final retrieved = StorageService.getBool(key);
        
        expect(retrieved, equals(value));
      });

      test('should save and retrieve string preference', () async {
        const key = 'test_string';
        const value = 'test_value';
        
        await StorageService.setString(key, value);
        final retrieved = StorageService.getString(key);
        
        expect(retrieved, equals(value));
      });

      test('should save and retrieve integer preference', () async {
        const key = 'test_int';
        const value = 42;
        
        await StorageService.setInt(key, value);
        final retrieved = StorageService.getInt(key);
        
        expect(retrieved, equals(value));
      });
    });

    group('Sync Times', () {
      test('should save and retrieve last sync time', () async {
        const key = 'test_sync';
        final testTime = DateTime.now();
        
        await StorageService.setLastSyncTime(key, testTime);
        final retrieved = StorageService.getLastSyncTime(key);
        
        expect(retrieved?.millisecondsSinceEpoch, 
               equals(testTime.millisecondsSinceEpoch));
      });
    });
  });
}