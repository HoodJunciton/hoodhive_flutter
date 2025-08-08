# HoodJunction Flutter App - Complete Setup Guide

## Overview
HoodJunction is a comprehensive society management Flutter application with offline-first architecture, real-time notifications, and seamless user experience.

## Features Implemented

### 🏗️ Architecture
- **Offline-First Architecture**: Data is cached locally and synced when online
- **Riverpod State Management**: Clean, reactive state management
- **Repository Pattern**: Clean separation of data layer
- **Service Layer**: Modular services for different functionalities

### 📱 Core Features
- **Firebase Authentication**: Phone number OTP-based login
- **Local Storage**: Hive for offline data storage
- **Secure Storage**: Flutter Secure Storage for sensitive data
- **Network Management**: Automatic online/offline detection
- **Background Sync**: Periodic data synchronization

### 🔔 Notifications
- **Firebase Cloud Messaging (FCM)**: Push notifications
- **Local Notifications**: Beautiful local notifications with channels
- **Notification Channels**: Categorized notifications (Maintenance, General, Emergency)
- **Background Handling**: Notifications work even when app is closed

### 💾 Offline Support
- **Data Caching**: All API responses cached locally
- **Offline Operations**: App works without internet
- **Smart Sync**: Automatic sync when connection is restored
- **Conflict Resolution**: Handles data conflicts gracefully

### 🎨 UI/UX
- **Material Design 3**: Modern, beautiful UI
- **Responsive Design**: Works on all screen sizes
- **Loading States**: Shimmer effects and proper loading indicators
- **Error Handling**: Graceful error states with retry options
- **Connectivity Banner**: Shows offline status

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart          # App-wide constants
│   ├── models/
│   │   ├── user_model.dart             # User data model
│   │   ├── maintenance_bill_model.dart  # Maintenance bill model
│   │   └── notification_model.dart     # Notification model
│   ├── providers/
│   │   ├── auth_provider.dart          # Authentication state
│   │   └── maintenance_provider.dart   # Maintenance bills state
│   ├── repositories/
│   │   ├── auth_repository.dart        # Auth data operations
│   │   └── maintenance_repository.dart # Maintenance data operations
│   └── services/
│       ├── storage_service.dart        # Local storage management
│       ├── network_service.dart        # HTTP client with interceptors
│       ├── notification_service.dart   # FCM & local notifications
│       └── sync_service.dart           # Background sync
├── screens/
│   ├── auth/
│   │   └── login_screen.dart           # Phone OTP login
│   ├── home/
│   │   └── home_screen.dart            # Dashboard
│   └── splash/
│       └── splash_screen.dart          # Loading screen
├── widgets/
│   ├── common/
│   │   ├── connectivity_banner.dart    # Offline indicator
│   │   └── app_drawer.dart             # Navigation drawer
│   └── home/
│       ├── dashboard_card.dart         # Dashboard cards
│       ├── quick_actions.dart          # Quick action buttons
│       └── recent_bills.dart           # Recent bills list
├── app.dart                            # Main app widget
└── main.dart                           # App entry point
```

## Setup Instructions

### 1. Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Firebase project setup

### 2. Clone and Install Dependencies
```bash
git clone <repository-url>
cd hoodhive_flutter
flutter pub get
```

### 3. Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Enable Authentication (Phone provider)
4. Enable Cloud Firestore
5. Enable Cloud Messaging

#### Android Configuration
1. Add Android app to Firebase project
2. Download `google-services.json`
3. Place it in `android/app/`
4. Update `android/build.gradle`:
```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.3.15'
}
```

5. Update `android/app/build.gradle`:
```gradle
apply plugin: 'com.google.gms.google-services'

dependencies {
    implementation 'com.google.firebase:firebase-messaging:23.2.1'
}
```

#### iOS Configuration
1. Add iOS app to Firebase project
2. Download `GoogleService-Info.plist`
3. Add to `ios/Runner/`
4. Update `ios/Runner/Info.plist` for notifications

### 4. Generate Code
```bash
flutter packages pub run build_runner build
```

### 5. Run the App
```bash
flutter run
```

## API Integration

### Base Configuration
Update `lib/core/constants/app_constants.dart`:
```dart
static const String baseUrl = 'https://your-api-domain.com/v1';
```

### Authentication Flow
1. User enters phone number
2. Firebase sends OTP
3. User verifies OTP
4. App gets Firebase ID token
5. Sends token to backend for JWT
6. Stores JWT securely

### Data Sync Strategy
- **On App Start**: Load cached data immediately
- **Background**: Sync every 15 minutes
- **On Network Restore**: Immediate sync
- **Manual Refresh**: Pull-to-refresh

## Notification Setup

### FCM Configuration
1. **Server Key**: Add to your backend
2. **Topic Subscriptions**: Subscribe users to society topics
3. **Payload Format**:
```json
{
  "notification": {
    "title": "Maintenance Bill Generated",
    "body": "Your bill for July 2025 is ready"
  },
  "data": {
    "type": "MAINTENANCE_BILL",
    "billId": "bill-uuid",
    "amount": "1800"
  }
}
```

### Local Notification Channels
- **Maintenance**: High priority, sound enabled
- **General**: Default priority
- **Emergency**: Max priority, vibration enabled

## Offline-First Implementation

### Data Flow
1. **API Call**: Always try network first
2. **Cache**: Store response in Hive
3. **Offline**: Return cached data
4. **Sync**: Update cache when online

### Storage Strategy
- **Secure Data**: JWT tokens, FCM tokens
- **User Data**: Profile, preferences
- **App Data**: Bills, notifications, society info
- **Sync Metadata**: Last sync timestamps

## Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

### Manual Testing Checklist
- [ ] Login with phone OTP
- [ ] Offline functionality
- [ ] Push notifications
- [ ] Data synchronization
- [ ] Network connectivity changes
- [ ] Background app refresh

## Performance Optimizations

### Implemented
- **Lazy Loading**: Load data as needed
- **Image Caching**: Cached network images
- **Database Indexing**: Optimized Hive queries
- **Memory Management**: Proper disposal of resources
- **Network Optimization**: Request deduplication

### Monitoring
- **Crash Reporting**: Firebase Crashlytics (to be added)
- **Analytics**: Firebase Analytics (to be added)
- **Performance**: Firebase Performance (to be added)

## Security Features

### Data Protection
- **Secure Storage**: Sensitive data encrypted
- **Certificate Pinning**: SSL certificate validation
- **Token Refresh**: Automatic JWT refresh
- **Input Validation**: All user inputs validated

### Privacy
- **Data Minimization**: Only necessary data stored
- **Local Processing**: Sensitive operations local
- **Secure Transmission**: HTTPS only
- **User Consent**: Clear privacy policies

## Deployment

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### CI/CD Pipeline
- **GitHub Actions**: Automated builds
- **Code Quality**: Linting, formatting
- **Testing**: Automated test runs
- **Distribution**: Firebase App Distribution

## Troubleshooting

### Common Issues

#### Build Errors
```bash
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

#### Firebase Issues
- Check `google-services.json` placement
- Verify package name matches Firebase
- Ensure all Firebase services enabled

#### Notification Issues
- Check Android permissions
- Verify FCM token generation
- Test with Firebase Console

#### Offline Issues
- Clear app data and test
- Check Hive box initialization
- Verify sync service setup

### Debug Commands
```bash
# Check dependencies
flutter doctor

# Analyze code
flutter analyze

# Check outdated packages
flutter pub outdated

# Debug build
flutter run --debug

# Profile build
flutter run --profile
```

## Future Enhancements

### Planned Features
- [ ] Biometric authentication
- [ ] Dark mode support
- [ ] Multi-language support
- [ ] Voice notifications
- [ ] Wear OS support
- [ ] Desktop support

### Technical Improvements
- [ ] GraphQL integration
- [ ] Advanced caching strategies
- [ ] Real-time data sync
- [ ] Offline-first mutations
- [ ] Advanced error recovery

## Contributing

### Code Style
- Follow Dart/Flutter conventions
- Use meaningful variable names
- Add comments for complex logic
- Write tests for new features

### Pull Request Process
1. Fork the repository
2. Create feature branch
3. Make changes with tests
4. Update documentation
5. Submit pull request

## Support

### Documentation
- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Riverpod Documentation](https://riverpod.dev/)

### Community
- [Flutter Community](https://flutter.dev/community)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- [GitHub Issues](https://github.com/your-repo/issues)

---

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments
- Flutter team for the amazing framework
- Firebase team for backend services
- Riverpod team for state management
- Open source community for packages used