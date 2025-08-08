import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';

import 'firebase_options.dart';
import 'core/services/storage_service.dart';
import 'core/services/network_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/sync_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final logger = Logger();
  
  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    logger.i('Firebase initialized successfully');

    // Initialize core services
    await StorageService.init();
    logger.i('Storage service initialized');

    await NetworkService.init();
    logger.i('Network service initialized');

    await NotificationService.init();
    logger.i('Notification service initialized');

    await SyncService.init();
    logger.i('Sync service initialized');

    // Run the app
    runApp(
      const ProviderScope(
        child: HoodJunctionApp(),
      ),
    );
  } catch (e, stackTrace) {
    logger.e('Failed to initialize app', error: e, stackTrace: stackTrace);
    
    // Show error screen or fallback
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Failed to initialize app',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  e.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Restart the app
                    main();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
