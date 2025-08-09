import 'package:flutter/material.dart';

class AppDimensions {
  // Padding & Margins
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  static const double paddingXXLarge = 48.0;
  
  // Border Radius
  static const double radiusXSmall = 4.0;
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;
  static const double radiusXXLarge = 24.0;
  static const double radiusCircular = 50.0;
  
  // Icon Sizes
  static const double iconXSmall = 12.0;
  static const double iconSmall = 16.0;
  static const double iconMedium = 20.0;
  static const double iconLarge = 24.0;
  static const double iconXLarge = 32.0;
  static const double iconXXLarge = 48.0;
  static const double iconXXXLarge = 64.0;
  
  // Button Dimensions
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightLarge = 56.0;
  static const double buttonMinWidth = 64.0;
  static const double buttonElevation = 2.0;
  
  // Input Field Dimensions
  static const double inputHeight = 48.0;
  static const double inputHeightSmall = 36.0;
  static const double inputHeightLarge = 56.0;
  static const double inputBorderRadius = 12.0;
  
  // Card Dimensions
  static const double cardElevation = 2.0;
  static const double cardElevationHover = 4.0;
  static const double cardElevationPressed = 1.0;
  static const double cardBorderRadius = 16.0;
  static const double cardPadding = 16.0;
  
  // AppBar Dimensions
  static const double appBarHeight = 56.0;
  static const double appBarElevation = 0.0;
  
  // Bottom Navigation
  static const double bottomNavHeight = 60.0;
  static const double bottomNavElevation = 8.0;
  
  // Drawer Dimensions
  static const double drawerWidth = 280.0;
  static const double drawerHeaderHeight = 160.0;
  
  // Dialog Dimensions
  static const double dialogElevation = 8.0;
  static const double dialogBorderRadius = 20.0;
  static const double dialogMaxWidth = 400.0;
  
  // Divider
  static const double dividerThickness = 1.0;
  static const double dividerIndent = 16.0;
  
  // Border Widths
  static const double borderWidth = 1.0;
  static const double borderWidthFocused = 2.0;
  static const double borderWidthThick = 3.0;
  
  // Avatar Sizes
  static const double avatarSmall = 24.0;
  static const double avatarMedium = 32.0;
  static const double avatarLarge = 48.0;
  static const double avatarXLarge = 64.0;
  static const double avatarXXLarge = 96.0;
  
  // Chip Dimensions
  static const double chipHeight = 32.0;
  static const double chipBorderRadius = 16.0;
  static const double chipPadding = 12.0;
  
  // Progress Indicators
  static const double progressIndicatorHeight = 4.0;
  static const double progressIndicatorBorderRadius = 2.0;
  static const double circularProgressSize = 20.0;
  
  // List Tile Dimensions
  static const double listTileHeight = 56.0;
  static const double listTileHeightSmall = 48.0;
  static const double listTileHeightLarge = 72.0;
  static const double listTilePadding = 16.0;
  
  // Tab Dimensions
  static const double tabHeight = 48.0;
  static const double tabMinWidth = 90.0;
  static const double tabPadding = 16.0;
  
  // Floating Action Button
  static const double fabSize = 56.0;
  static const double fabSizeSmall = 40.0;
  static const double fabSizeLarge = 64.0;
  static const double fabElevation = 6.0;
  
  // Snackbar Dimensions
  static const double snackbarElevation = 6.0;
  static const double snackbarBorderRadius = 8.0;
  static const double snackbarMargin = 16.0;
  
  // Grid Dimensions
  static const double gridSpacing = 16.0;
  static const double gridCrossAxisSpacing = 16.0;
  static const double gridMainAxisSpacing = 16.0;
  static const double gridChildAspectRatio = 1.0;
  
  // Breakpoints for Responsive Design
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1440.0;
  
  // Container Constraints
  static const double maxContentWidth = 1200.0;
  static const double minTouchTarget = 44.0;
  
  // Animation Durations (in milliseconds)
  static const int animationDurationFast = 150;
  static const int animationDurationMedium = 300;
  static const int animationDurationSlow = 500;
  
  // Responsive Padding
  static double responsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > desktopBreakpoint) {
      return paddingXXLarge;
    } else if (screenWidth > tabletBreakpoint) {
      return paddingXLarge;
    } else if (screenWidth > mobileBreakpoint) {
      return paddingLarge;
    } else {
      return paddingMedium;
    }
  }
  
  // Responsive Margin
  static double responsiveMargin(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > desktopBreakpoint) {
      return paddingXLarge;
    } else if (screenWidth > tabletBreakpoint) {
      return paddingLarge;
    } else if (screenWidth > mobileBreakpoint) {
      return paddingMedium;
    } else {
      return paddingSmall;
    }
  }
  
  // Responsive Icon Size
  static double responsiveIconSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > tabletBreakpoint) {
      return iconLarge;
    } else {
      return iconMedium;
    }
  }
  
  // Responsive Button Height
  static double responsiveButtonHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > tabletBreakpoint) {
      return buttonHeightLarge;
    } else {
      return buttonHeight;
    }
  }
  
  // Grid Column Count
  static int getGridColumnCount(BuildContext context, {double itemWidth = 200.0}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - (paddingMedium * 2);
    final columns = (availableWidth / (itemWidth + gridSpacing)).floor();
    return columns.clamp(1, 6);
  }
  
  // Safe Area Padding
  static EdgeInsets safeAreaPadding(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return EdgeInsets.only(
      top: mediaQuery.padding.top,
      bottom: mediaQuery.padding.bottom,
      left: mediaQuery.padding.left,
      right: mediaQuery.padding.right,
    );
  }
  
  // Content Padding with Safe Area
  static EdgeInsets contentPadding(BuildContext context) {
    final safeArea = safeAreaPadding(context);
    final responsive = responsivePadding(context);
    return EdgeInsets.only(
      top: safeArea.top + responsive,
      bottom: safeArea.bottom + responsive,
      left: safeArea.left + responsive,
      right: safeArea.right + responsive,
    );
  }
  
  // Device Type Detection
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }
  
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < desktopBreakpoint;
  }
  
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }
  
  // Orientation-based Dimensions
  static double orientationAwarePadding(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return paddingSmall;
    } else {
      return responsivePadding(context);
    }
  }
  
  // Accessibility-aware Dimensions
  static double accessibleTouchTarget(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return (minTouchTarget * textScaleFactor).clamp(minTouchTarget, minTouchTarget * 1.5);
  }
}