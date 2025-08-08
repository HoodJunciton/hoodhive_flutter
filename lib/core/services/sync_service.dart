import 'dart:async';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';
import '../models/user_model.dart';
import '../models/maintenance_bill_model.dart';
import '../models/notification_model.dart';
import 'network_service.dart';
import 'storage_service.dart';

class SyncService {
  static final Logger _logger = Logger();
  static Timer? _syncTimer;
  static bool _isSyncing = false;

  static Future<void> init() async {
    // Start periodic sync
    _startPeriodicSync();
    
    // Listen to network connectivity changes
    NetworkService.connectivityStream.listen((isConnected) {
      if (isConnected && !_isSyncing) {
        syncAll();
      }
    });
  }

  static void _startPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(AppConstants.syncInterval, (_) {
      if (!_isSyncing) {
        syncAll();
      }
    });
  }

  static Future<void> syncAll() async {
    if (_isSyncing) return;
    
    _isSyncing = true;
    _logger.i('Starting sync process...');

    try {
      if (!await NetworkService.isConnected()) {
        _logger.w('No internet connection, skipping sync');
        return;
      }

      await Future.wait([
        syncUserProfile(),
        syncMaintenanceBills(),
        syncNotifications(),
      ]);

      _logger.i('Sync completed successfully');
    } catch (e) {
      _logger.e('Sync failed: $e');
    } finally {
      _isSyncing = false;
    }
  }

  static Future<void> syncUserProfile() async {
    try {
      _logger.d('Syncing user profile...');
      
      final response = await NetworkService.get('/auth/profile');
      if (response.statusCode == 200) {
        final userData = response.data;
        final user = UserModel.fromJson(userData).copyWith(
          lastSyncAt: DateTime.now(),
        );
        
        await StorageService.saveUser(user);
        await StorageService.setLastSyncTime('user_profile', DateTime.now());
        
        _logger.d('User profile synced successfully');
      }
    } catch (e) {
      _logger.e('Failed to sync user profile: $e');
    }
  }

  static Future<void> syncMaintenanceBills() async {
    try {
      _logger.d('Syncing maintenance bills...');
      
      final lastSync = StorageService.getLastSyncTime('maintenance_bills');
      final queryParams = <String, dynamic>{};
      
      if (lastSync != null) {
        queryParams['fromDate'] = lastSync.toIso8601String();
      }

      final response = await NetworkService.get(
        '/maintenance/bills',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final billsData = response.data as List;
        final bills = billsData
            .map((json) => MaintenanceBillModel.fromJson(json))
            .toList();

        // Update bills with sync timestamp
        final updatedBills = bills
            .map((bill) => MaintenanceBillModel(
                  id: bill.id,
                  amount: bill.amount,
                  dueDate: bill.dueDate,
                  status: bill.status,
                  billType: bill.billType,
                  billMonth: bill.billMonth,
                  billYear: bill.billYear,
                  paymentDate: bill.paymentDate,
                  paymentMethod: bill.paymentMethod,
                  transactionId: bill.transactionId,
                  room: bill.room,
                  society: bill.society,
                  components: bill.components,
                  notes: bill.notes,
                  createdAt: bill.createdAt,
                  lastSyncAt: DateTime.now(),
                  isLocalOnly: false,
                ))
            .toList();

        await StorageService.saveMaintenanceBills(updatedBills);
        await StorageService.setLastSyncTime('maintenance_bills', DateTime.now());
        
        _logger.d('Maintenance bills synced successfully: ${bills.length} bills');
      }
    } catch (e) {
      _logger.e('Failed to sync maintenance bills: $e');
    }
  }

  static Future<void> syncNotifications() async {
    try {
      _logger.d('Syncing notifications...');
      
      final lastSync = StorageService.getLastSyncTime('notifications');
      final queryParams = <String, dynamic>{
        'limit': 50,
      };
      
      if (lastSync != null) {
        queryParams['fromDate'] = lastSync.toIso8601String();
      }

      final response = await NetworkService.get(
        '/notifications',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final notificationsData = responseData['data'] as List;
        final notifications = notificationsData
            .map((json) => NotificationModel.fromJson(json))
            .toList();

        // Update notifications with sync timestamp
        final updatedNotifications = notifications
            .map((notification) => notification.copyWith(
                  lastSyncAt: DateTime.now(),
                  isLocalOnly: false,
                ))
            .toList();

        await StorageService.saveNotifications(updatedNotifications);
        await StorageService.setLastSyncTime('notifications', DateTime.now());
        
        _logger.d('Notifications synced successfully: ${notifications.length} notifications');
      }
    } catch (e) {
      _logger.e('Failed to sync notifications: $e');
    }
  }

  static Future<void> syncPendingActions() async {
    try {
      _logger.d('Syncing pending actions...');
      
      // Sync read notifications
      await _syncReadNotifications();
      
      // Sync FCM token if changed
      await _syncFCMToken();
      
      _logger.d('Pending actions synced successfully');
    } catch (e) {
      _logger.e('Failed to sync pending actions: $e');
    }
  }

  static Future<void> _syncReadNotifications() async {
    try {
      final notifications = StorageService.getNotifications();
      final readNotifications = notifications
          .where((n) => n.isRead && (n.lastSyncAt == null || n.readAt!.isAfter(n.lastSyncAt!)))
          .toList();

      for (final notification in readNotifications) {
        try {
          await NetworkService.patch('/notifications/${notification.id}/read');
          
          // Update local notification with sync timestamp
          final updatedNotification = notification.copyWith(
            lastSyncAt: DateTime.now(),
          );
          await StorageService.saveNotification(updatedNotification);
        } catch (e) {
          _logger.w('Failed to sync read status for notification ${notification.id}: $e');
        }
      }
    } catch (e) {
      _logger.e('Failed to sync read notifications: $e');
    }
  }

  static Future<void> _syncFCMToken() async {
    try {
      final storedToken = await StorageService.getFcmToken();
      if (storedToken != null) {
        await NetworkService.patch('/auth/profile', data: {
          'fcmToken': storedToken,
        });
        _logger.d('FCM token synced successfully');
      }
    } catch (e) {
      _logger.e('Failed to sync FCM token: $e');
    }
  }

  // Force sync specific data
  static Future<void> forceSyncMaintenanceBills() async {
    await StorageService.setLastSyncTime('maintenance_bills', DateTime(2020));
    await syncMaintenanceBills();
  }

  static Future<void> forceSyncNotifications() async {
    await StorageService.setLastSyncTime('notifications', DateTime(2020));
    await syncNotifications();
  }

  static Future<void> forceSyncAll() async {
    await StorageService.setLastSyncTime('user_profile', DateTime(2020));
    await StorageService.setLastSyncTime('maintenance_bills', DateTime(2020));
    await StorageService.setLastSyncTime('notifications', DateTime(2020));
    await syncAll();
  }

  // Sync status
  static bool get isSyncing => _isSyncing;

  static DateTime? getLastSyncTime(String key) {
    return StorageService.getLastSyncTime(key);
  }

  // Background sync
  static Future<void> performBackgroundSync() async {
    _logger.i('Performing background sync...');
    
    try {
      if (await NetworkService.isConnected()) {
        await syncAll();
        await syncPendingActions();
      }
    } catch (e) {
      _logger.e('Background sync failed: $e');
    }
  }

  static void dispose() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }
}