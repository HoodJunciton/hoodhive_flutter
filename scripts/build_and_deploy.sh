#!/bin/bash

# HoodJunction Flutter App - Build and Deploy Script
# This script handles building and deploying the Flutter app for different environments

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
APP_NAME="HoodJunction"
ANDROID_PACKAGE="com.hoodjunction.app"
IOS_BUNDLE_ID="com.hoodjunction.app"

# Functions
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}================================${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if Flutter is installed
check_flutter() {
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed or not in PATH"
        exit 1
    fi
    
    print_success "Flutter is installed"
    flutter --version
}

# Check dependencies
check_dependencies() {
    print_header "Checking Dependencies"
    
    check_flutter
    
    # Check if we're in a Flutter project
    if [ ! -f "pubspec.yaml" ]; then
        print_error "Not in a Flutter project directory"
        exit 1
    fi
    
    print_success "All dependencies are available"
}

# Clean and get dependencies
setup_project() {
    print_header "Setting Up Project"
    
    print_info "Cleaning project..."
    flutter clean
    
    print_info "Getting dependencies..."
    flutter pub get
    
    print_info "Running code generation..."
    flutter packages pub run build_runner build --delete-conflicting-outputs
    
    print_success "Project setup completed"
}

# Run tests
run_tests() {
    print_header "Running Tests"
    
    print_info "Running unit tests..."
    flutter test
    
    print_info "Running integration tests..."
    if [ -d "integration_test" ]; then
        flutter test integration_test/
    else
        print_warning "No integration tests found"
    fi
    
    print_success "All tests passed"
}

# Analyze code
analyze_code() {
    print_header "Analyzing Code"
    
    print_info "Running Flutter analyze..."
    flutter analyze
    
    print_info "Checking formatting..."
    dart format --set-exit-if-changed .
    
    print_success "Code analysis completed"
}

# Build Android APK
build_android_apk() {
    print_header "Building Android APK"
    
    print_info "Building release APK..."
    flutter build apk --release --target-platform android-arm64
    
    # Copy APK to releases directory
    mkdir -p releases/android
    cp build/app/outputs/flutter-apk/app-release.apk "releases/android/${APP_NAME}-$(date +%Y%m%d-%H%M%S).apk"
    
    print_success "Android APK built successfully"
    print_info "APK location: build/app/outputs/flutter-apk/app-release.apk"
}

# Build Android App Bundle
build_android_bundle() {
    print_header "Building Android App Bundle"
    
    print_info "Building release App Bundle..."
    flutter build appbundle --release
    
    # Copy AAB to releases directory
    mkdir -p releases/android
    cp build/app/outputs/bundle/release/app-release.aab "releases/android/${APP_NAME}-$(date +%Y%m%d-%H%M%S).aab"
    
    print_success "Android App Bundle built successfully"
    print_info "AAB location: build/app/outputs/bundle/release/app-release.aab"
}

# Build iOS
build_ios() {
    print_header "Building iOS"
    
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_warning "iOS build is only supported on macOS"
        return
    fi
    
    print_info "Building iOS release..."
    flutter build ios --release --no-codesign
    
    print_success "iOS build completed"
    print_info "iOS build location: build/ios/iphoneos/Runner.app"
}

# Build Web
build_web() {
    print_header "Building Web"
    
    print_info "Building web release..."
    flutter build web --release
    
    # Copy web build to releases directory
    mkdir -p releases/web
    cp -r build/web "releases/web/${APP_NAME}-web-$(date +%Y%m%d-%H%M%S)"
    
    print_success "Web build completed"
    print_info "Web build location: build/web"
}

# Generate release notes
generate_release_notes() {
    print_header "Generating Release Notes"
    
    local version=$(grep "version:" pubspec.yaml | cut -d' ' -f2)
    local date=$(date +"%Y-%m-%d %H:%M:%S")
    
    cat > releases/RELEASE_NOTES.md << EOF
# $APP_NAME Release Notes

## Version: $version
## Date: $date

### Features
- Offline-first architecture with local data caching
- Firebase Authentication with phone OTP
- Push notifications with FCM
- Real-time data synchronization
- Beautiful Material Design 3 UI
- Comprehensive error handling

### Technical Details
- Flutter SDK: $(flutter --version | head -n1)
- Dart SDK: $(dart --version | cut -d' ' -f4)
- Build Date: $date
- Build Environment: $(uname -s) $(uname -r)

### Build Artifacts
- Android APK: Available in releases/android/
- Android App Bundle: Available in releases/android/
- iOS Build: Available in releases/ios/ (macOS only)
- Web Build: Available in releases/web/

### Installation
1. Download the appropriate build for your platform
2. For Android: Install the APK or upload AAB to Play Store
3. For iOS: Use Xcode to build and deploy
4. For Web: Deploy the web folder to your hosting service

### Support
For issues and support, please contact: support@hoodjunction.com
EOF
    
    print_success "Release notes generated"
}

# Deploy to Firebase Hosting (Web)
deploy_web() {
    print_header "Deploying Web to Firebase Hosting"
    
    if ! command -v firebase &> /dev/null; then
        print_error "Firebase CLI is not installed"
        print_info "Install it with: npm install -g firebase-tools"
        return 1
    fi
    
    print_info "Building web for production..."
    flutter build web --release
    
    print_info "Deploying to Firebase Hosting..."
    firebase deploy --only hosting
    
    print_success "Web deployment completed"
}

# Main build function
build_all() {
    local platform=$1
    
    check_dependencies
    setup_project
    
    if [ "$SKIP_TESTS" != "true" ]; then
        run_tests
    fi
    
    if [ "$SKIP_ANALYSIS" != "true" ]; then
        analyze_code
    fi
    
    case $platform in
        "android")
            build_android_apk
            build_android_bundle
            ;;
        "ios")
            build_ios
            ;;
        "web")
            build_web
            ;;
        "all")
            build_android_apk
            build_android_bundle
            build_ios
            build_web
            ;;
        *)
            print_error "Unknown platform: $platform"
            print_info "Available platforms: android, ios, web, all"
            exit 1
            ;;
    esac
    
    generate_release_notes
    
    print_success "Build process completed successfully!"
}

# Show usage
show_usage() {
    echo "Usage: $0 [OPTIONS] <platform>"
    echo ""
    echo "Platforms:"
    echo "  android    Build Android APK and App Bundle"
    echo "  ios        Build iOS (macOS only)"
    echo "  web        Build Web"
    echo "  all        Build all platforms"
    echo ""
    echo "Options:"
    echo "  --skip-tests      Skip running tests"
    echo "  --skip-analysis   Skip code analysis"
    echo "  --deploy-web      Deploy web build to Firebase Hosting"
    echo "  --help           Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 android                    # Build Android only"
    echo "  $0 --skip-tests all          # Build all platforms without tests"
    echo "  $0 --deploy-web web          # Build and deploy web"
}

# Parse command line arguments
SKIP_TESTS=false
SKIP_ANALYSIS=false
DEPLOY_WEB=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --skip-tests)
            SKIP_TESTS=true
            shift
            ;;
        --skip-analysis)
            SKIP_ANALYSIS=true
            shift
            ;;
        --deploy-web)
            DEPLOY_WEB=true
            shift
            ;;
        --help)
            show_usage
            exit 0
            ;;
        -*)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
        *)
            PLATFORM=$1
            shift
            ;;
    esac
done

# Check if platform is provided
if [ -z "$PLATFORM" ]; then
    print_error "Platform is required"
    show_usage
    exit 1
fi

# Run the build
print_header "Starting Build Process for $PLATFORM"
build_all $PLATFORM

# Deploy web if requested
if [ "$DEPLOY_WEB" = true ] && [ "$PLATFORM" = "web" ]; then
    deploy_web
fi

print_success "All operations completed successfully!"