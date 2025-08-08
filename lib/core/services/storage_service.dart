import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';
import '../models/user_model.dart';
import '../models/maintenance_bill_model.dart';
import '../models/notification_model.dart';

class StorageService {
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static late SharedPreferences _prefs;
  static late Box<UserModel> _userBox;
  static late Box<MaintenanceBillModel> _maintenanceBox;
  static late Box<NotificationModel> _notificationBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(MaintenanceBillModelAdapter());
    Hive.registerAdapter(RoomInfoAdapter());
    Hive.registerAdapter(SocietyInfoAdapter());
    Hive.registerAdapter(BillComponentAdapter());
    Hive.registerAdapter(NotificationModelAdapter());

    // Open boxes
    _userBox = await Hive.openBox<UserModel>(AppConstants.userBox);
    _maintenanceBox = await Hive.openBox<MaintenanceBillModel>(AppConstants.maintenanceBox);
    _notificationBox = await Hive.openBox<NotificationModel>(AppConstants.notificationBox);

    _prefs = await SharedPreferences.getInstance();
  }

  // Secure Storage Methods
  static Future<void> saveSecureData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String?> getSecureData(String key) async {
    return await _secureStorage.read(key: key);
  }

  static Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key);
  }

  static Future<void> clearSecureStorage() async {
    await _secureStorage.deleteAll();
  }

  // Token Management
  static Future<void> saveTokens({
    required String jwtToken,
    required String refreshToken,
  }) async {
    await saveSecureData(AppConstants.jwtTokenKey, jwtToken);
    await saveSecureData(AppConstants.refreshTokenKey, refreshToken);
  }

  static Future<String?> getJwtToken() async {
    return await getSecureData(AppConstants.jwtTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return await getSecureData(AppConstants.refreshTokenKey);
  }

  static Future<void> clearTokens() async {
    await deleteSecureData(AppConstants.jwtTokenKey);
    await deleteSecureData(AppConstants.refreshTokenKey);
  }

  // User Data
  static Future<void> saveUser(UserModel user) async {
    await _userBox.put('current_user', user);
  }

  static UserModel? getCurrentUser() {
    return _userBox.get('current_user');
  }

  static Future<void> clearUser() async {
    await _userBox.delete('current_user');
  }

  // Maintenance Bills
  static Future<void> saveMaintenanceBills(List<MaintenanceBillModel> bills) async {
    final Map<String, MaintenanceBillModel> billsMap = {
      for (var bill in bills) bill.id: bill
    };
    await _maintenanceBox.putAll(billsMap);
  }

  static Future<void> saveMaintenanceBill(MaintenanceBillModel bill) async {
    await _maintenanceBox.put(bill.id, bill);
  }

  static List<MaintenanceBillModel> getMaintenanceBills() {
    return _maintenanceBox.values.toList();
  }

  static MaintenanceBillModel? getMaintenanceBill(String id) {
    return _maintenanceBox.get(id);
  }

  static Future<void> deleteMaintenanceBill(String id) async {
    await _maintenanceBox.delete(id);
  }

  // Notifications
  static Future<void> saveNotifications(List<NotificationModel> notifications) async {
    final Map<String, NotificationModel> notificationsMap = {
      for (var notification in notifications) notification.id: notification
    };
    await _notificationBox.putAll(notificationsMap);
  }

  static Future<void> saveNotification(NotificationModel notification) async {
    await _notificationBox.put(notification.id, notification);
  }

  static List<NotificationModel> getNotifications() {
    return _notificationBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  static NotificationModel? getNotification(String id) {
    return _notificationBox.get(id);
  }

  static Future<void> deleteNotification(String id) async {
    await _notificationBox.delete(id);
  }

  static Future<void> markNotificationAsRead(String id) async {
    final notification = _notificationBox.get(id);
    if (notification != null) {
      final updatedNotification = notification.copyWith(
        isRead: true,
        readAt: DateTime.now(),
      );
      await _notificationBox.put(id, updatedNotification);
    }
  }

  // Preferences
  static Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  static Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  // FCM Token
  static Future<void> saveFcmToken(String token) async {
    await saveSecureData(AppConstants.fcmTokenKey, token);
  }

  static Future<String?> getFcmToken() async {
    return await getSecureData(AppConstants.fcmTokenKey);
  }

  // Last Sync Times
  static Future<void> setLastSyncTime(String key, DateTime time) async {
    await _prefs.setString('${key}_last_sync', time.toIso8601String());
  }

  static DateTime? getLastSyncTime(String key) {
    final timeString = _prefs.getString('${key}_last_sync');
    return timeString != null ? DateTime.parse(timeString) : null;
  }

  // Clear all data
  static Future<void> clearAllData() async {
    await clearSecureStorage();
    await _userBox.clear();
    await _maintenanceBox.clear();
    await _notificationBox.clear();
    await _prefs.clear();
  }
}