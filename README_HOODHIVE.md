# HoodHive Flutter Project

This is a Flutter project for the HoodHive application with Riverpod and Firebase integration.

## Project Structure

```
lib/
├── app.dart                 # Main app widget
├── main.dart                # Entry point
├── providers/               # Riverpod providers
├── screens/                 # UI screens
├── widgets/                 # Reusable widgets
├── models/                  # Data models
├── services/                # Business logic and services
├── repositories/            # Data repositories
├── utils/                   # Utility functions
├── constants/               # Constants and configurations
└── routes/                  # App routes
```

## Dependencies

### State Management
- `flutter_riverpod` - For state management
- `riverpod_annotation` - For annotations
- `riverpod_generator` - For code generation
- `build_runner` - For code generation

### Firebase
- `firebase_core` - Core Firebase functionality
- `firebase_auth` - For authentication
- `cloud_firestore` - For Firestore database
- `firebase_storage` - For storage

## Firebase Configuration

### Android
1. Replace `android/app/google-services.json` with your actual file from Firebase Console
2. The file includes instructions on how to obtain it

### iOS
1. Replace `ios/Runner/GoogleService-Info.plist` with your actual file from Firebase Console
2. The file includes instructions on how to obtain it

## Next Steps

1. Replace the placeholder Firebase configuration files with your actual files
2. Run `flutter pub get` to install dependencies
3. For Android: Build the project to generate necessary files
4. For iOS: Run `cd ios && pod install` to install Firebase pods
5. Run `flutter run` to start the application

## Code Generation

This project uses Riverpod Generator for code generation. Run the following command to generate code:

```bash
dart run build_runner build
```

Or for continuous generation during development:

```bash
dart run build_runner watch