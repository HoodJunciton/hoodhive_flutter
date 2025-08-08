import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/auth_provider.dart';
import 'core/services/sync_service.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'widgets/common/connectivity_banner.dart';

class HoodJunctionApp extends ConsumerStatefulWidget {
  const HoodJunctionApp({super.key});

  @override
  ConsumerState<HoodJunctionApp> createState() => _HoodJunctionAppState();
}

class _HoodJunctionAppState extends ConsumerState<HoodJunctionApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SyncService.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // Sync when app comes to foreground
    if (state == AppLifecycleState.resumed) {
      SyncService.syncAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'HoodJunction',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: Stack(
        children: [
          _buildHome(authState),
          const ConnectivityBanner(),
        ],
      ),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E7D32), // Green theme for society app
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildHome(AuthState authState) {
    if (authState.isLoading) {
      return const SplashScreen();
    } else if (authState.isAuthenticated && authState.user != null) {
      return const HomeScreen();
    } else if (authState.error != null) {
      return _buildErrorScreen(authState.error!);
    } else {
      return const LoginScreen();
    }
  }

  Widget _buildErrorScreen(String error) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
                'Something went wrong',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Retry authentication
                  ref.read(authStateProvider.notifier).logout();
                },
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}