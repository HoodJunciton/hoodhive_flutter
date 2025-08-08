import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';
import '../models/notification_model.dart';
import 'storage_service.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();
  static final Logger _logger = Logger();

  static Future<void> init() async {
    await _initializeLocalNotifications();
    await _initializeFirebaseMessaging();
  }

  static Future<void> _initializeLocalNotifications() async {
    // Android initialization
    const AndroidInitializationSettings androidSettings = 
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization
    const DarwinInitializationSettings iosSettings = 
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channels
    await _createNotificationChannels();
  }

  static Future<void> _createNotificationChannels() async {
    if (Platform.isAndroid) {
      // Maintenance channel
      const AndroidNotificationChannel maintenanceChannel = 
          AndroidNotificationChannel(
        AppConstants.maintenanceChannelId,
        'Maintenance Bills',
        description: 'Notifications for maintenance bills and payments',
        importance: Importance.high,
        playSound: true,
      );

      // General channel
      const AndroidNotificationChannel generalChannel = 
          AndroidNotificationChannel(
        AppConstants.generalChannelId,
        'General Notifications',
        description: 'General society notifications',
        importance: Importance.defaultImportance,
        playSound: true,
      );

      // Emergency channel
      const AndroidNotificationChannel emergencyChannel = 
          AndroidNotificationChannel(
        AppConstants.emergencyChannelId,
        'Emergency Alerts',
        description: 'Emergency and urgent notifications',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(maintenanceChannel);

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(generalChannel);

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(emergencyChannel);
    }
  }

  static Future<void> _initializeFirebaseMessaging() async {
    // Request permission
    await _requestNotificationPermissions();

    // Get FCM token
    final token = await _firebaseMessaging.getToken();
    if (token != null) {
      await StorageService.saveFcmToken(token);
      _logger.i('FCM Token: $token');
    }

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((token) async {
      await StorageService.saveFcmToken(token);
      _logger.i('FCM Token refreshed: $token');
      // TODO: Send updated token to server
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

    // Handle notification taps when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Handle notification tap when app is terminated
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  static Future<void> _requestNotificationPermissions() async {
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
    } else if (Platform.isAndroid) {
      await Permission.notification.request();
    }
  }

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    _logger.i('Received foreground message: ${message.messageId}');
    
    // Save notification to local storage
    await _saveNotificationFromRemoteMessage(message);
    
    // Show local notification
    await _showLocalNotification(message);
  }

  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    _logger.i('Received background message: ${message.messageId}');
    
    // Save notification to local storage
    await _saveNotificationFromRemoteMessage(message);
  }

  static Future<void> _handleNotificationTap(RemoteMessage message) async {
    _logger.i('Notification tapped: ${message.messageId}');
    
    // Handle navigation based on notification type
    final notificationType = message.data['type'];
    switch (notificationType) {
      case 'MAINTENANCE_BILL':
        // Navigate to maintenance bills screen
        break;
      case 'RESIDENT_APPROVED':
        // Navigate to society details screen
        break;
      case 'PARKING_ASSIGNED':
        // Navigate to parking screen
        break;
      default:
        // Navigate to notifications screen
        break;
    }
  }

  static Future<void> _saveNotificationFromRemoteMessage(RemoteMessage message) async {
    final notification = NotificationModel(
      id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ?? 'New Notification',
      message: message.notification?.body ?? '',
      type: message.data['type'] ?? 'GENERAL',
      isRead: false,
      data: message.data,
      createdAt: DateTime.now(),
    );

    await StorageService.saveNotification(notification);
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    final channelId = _getChannelIdForType(message.data['type']);
    
    final androidDetails = AndroidNotificationDetails(
      channelId,
      _getChannelNameForId(channelId),
      channelDescription: _getChannelDescriptionForId(channelId),
      importance: _getImportanceForType(message.data['type']),
      priority: Priority.high,
      showWhen: true,
      styleInformation: BigTextStyleInformation(
        message.notification?.body ?? '',
        contentTitle: message.notification?.title,
      ),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      message.notification?.title,
      message.notification?.body,
      details,
      payload: jsonEncode(message.data),
    );
  }

  static String _getChannelIdForType(String? type) {
    switch (type) {
      case 'MAINTENANCE_BILL':
      case 'PAYMENT_REMINDER':
        return AppConstants.maintenanceChannelId;
      case 'EMERGENCY':
      case 'URGENT':
        return AppConstants.emergencyChannelId;
      default:
        return AppConstants.generalChannelId;
    }
  }

  static String _getChannelNameForId(String channelId) {
    switch (channelId) {
      case AppConstants.maintenanceChannelId:
        return 'Maintenance Bills';
      case AppConstants.emergencyChannelId:
        return 'Emergency Alerts';
      default:
        return 'General Notifications';
    }
  }

  static String _getChannelDescriptionForId(String channelId) {
    switch (channelId) {
      case AppConstants.maintenanceChannelId:
        return 'Notifications for maintenance bills and payments';
      case AppConstants.emergencyChannelId:
        return 'Emergency and urgent notifications';
      default:
        return 'General society notifications';
    }
  }

  static Importance _getImportanceForType(String? type) {
    switch (type) {
      case 'EMERGENCY':
      case 'URGENT':
        return Importance.max;
      case 'MAINTENANCE_BILL':
      case 'PAYMENT_REMINDER':
        return Importance.high;
      default:
        return Importance.defaultImportance;
    }
  }

  static void _onNotificationTapped(NotificationResponse response) {
    _logger.i('Local notification tapped: ${response.id}');
    
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      final notificationType = data['type'];
      
      // Handle navigation based on notification type
      switch (notificationType) {
        case 'MAINTENANCE_BILL':
          // Navigate to maintenance bills screen
          break;
        case 'RESIDENT_APPROVED':
          // Navigate to society details screen
          break;
        default:
          // Navigate to notifications screen
          break;
      }
    }
  }

  // Public methods
  static Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  static Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    _logger.i('Subscribed to topic: $topic');
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    _logger.i('Unsubscribed from topic: $topic');
  }

  static Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
    String type = 'GENERAL',
  }) async {
    final channelId = _getChannelIdForType(type);
    
    final androidDetails = AndroidNotificationDetails(
      channelId,
      _getChannelNameForId(channelId),
      channelDescription: _getChannelDescriptionForId(channelId),
      importance: _getImportanceForType(type),
      priority: Priority.high,
      showWhen: true,
      styleInformation: BigTextStyleInformation(body, contentTitle: title),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  static Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _localNotifications.pendingNotificationRequests();
  }
}

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  await NotificationService._handleBackgroundMessage(message);
}