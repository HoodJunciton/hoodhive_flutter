class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://api.hoodjunction.com/v1';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String jwtTokenKey = 'jwt_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String fcmTokenKey = 'fcm_token';
  
  // Database
  static const String databaseName = 'hoodjunction.db';
  static const int databaseVersion = 1;
  
  // Hive Boxes
  static const String userBox = 'user_box';
  static const String maintenanceBox = 'maintenance_box';
  static const String societyBox = 'society_box';
  static const String notificationBox = 'notification_box';
  static const String parkingBox = 'parking_box';
  
  // Notification Channels
  static const String maintenanceChannelId = 'maintenance_channel';
  static const String generalChannelId = 'general_channel';
  static const String emergencyChannelId = 'emergency_channel';
  
  // Sync Intervals
  static const Duration syncInterval = Duration(minutes: 15);
  static const Duration backgroundSyncInterval = Duration(hours: 1);
}