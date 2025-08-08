import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.home_work,
                size: 60,
                color: theme.colorScheme.primary,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // App Name
            Text(
              'HoodJunction',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Tagline
            Text(
              'Your Society, Connected',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.9),
                fontWeight: FontWeight.w300,
              ),
            ),
            
            const SizedBox(height: 64),
            
            // Loading Indicator
            SpinKitWave(
              color: Colors.white,
              size: 40.0,
            ),
            
            const SizedBox(height: 24),
            
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}