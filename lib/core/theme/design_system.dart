import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_dimensions.dart';

// Design System Context Extension
extension DesignSystemContext on BuildContext {
  // Theme Access
  AppColors get colors => AppColors();
  AppTypography get typography => AppTypography();
  AppDimensions get dimensions => AppDimensions();
  
  // Color Scheme Access
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  
  // Text Theme Access
  TextTheme get textTheme => Theme.of(this).textTheme;
  
  // Responsive Helpers
  bool get isMobile => AppDimensions.isMobile(this);
  bool get isTablet => AppDimensions.isTablet(this);
  bool get isDesktop => AppDimensions.isDesktop(this);
  
  double get responsivePadding => AppDimensions.responsivePadding(this);
  double get responsiveMargin => AppDimensions.responsiveMargin(this);
  double get responsiveIconSize => AppDimensions.responsiveIconSize(this);
  double get responsiveButtonHeight => AppDimensions.responsiveButtonHeight(this);
  
  // Screen Size
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  
  // Safe Area
  EdgeInsets get safeAreaPadding => AppDimensions.safeAreaPadding(this);
  EdgeInsets get contentPadding => AppDimensions.contentPadding(this);
  
  // Status Colors
  Color statusColor(String status) => AppColors.getStatusColor(status);
  Color roleColor(String role) => AppColors.getRoleColor(role);
  
  // Typography Helpers
  TextStyle get heroTitle => AppTypography.heroTitle;
  TextStyle get sectionTitle => AppTypography.sectionTitle;
  TextStyle get cardTitle => AppTypography.cardTitle;
  TextStyle get cardSubtitle => AppTypography.cardSubtitle;
  TextStyle get inputLabel => AppTypography.inputLabel;
  TextStyle get inputText => AppTypography.inputText;
  TextStyle get inputHint => AppTypography.inputHint;
  TextStyle get tabLabel => AppTypography.tabLabel;
  TextStyle get chipLabel => AppTypography.chipLabel;
  TextStyle get badgeLabel => AppTypography.badgeLabel;
  TextStyle get tooltipText => AppTypography.tooltipText;
  TextStyle get errorText => AppTypography.errorText;
  TextStyle get successText => AppTypography.successText;
  TextStyle get warningText => AppTypography.warningText;
  TextStyle get infoText => AppTypography.infoText;
  
  // Responsive Typography
  TextStyle get responsiveTitle => AppTypography.responsiveTitle(this);
  TextStyle get responsiveBody => AppTypography.responsiveBody(this);
  
  // Show Snackbar with Design System
  void showSnackbar(
    String message, {
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    Color backgroundColor;
    Color textColor;
    IconData icon;
    
    switch (type) {
      case SnackbarType.success:
        backgroundColor = AppColors.success;
        textColor = Colors.white;
        icon = Icons.check_circle;
        break;
      case SnackbarType.error:
        backgroundColor = AppColors.error;
        textColor = Colors.white;
        icon = Icons.error;
        break;
      case SnackbarType.warning:
        backgroundColor = AppColors.warning;
        textColor = Colors.white;
        icon = Icons.warning;
        break;
      case SnackbarType.info:
      default:
        backgroundColor = AppColors.info;
        textColor = Colors.white;
        icon = Icons.info;
        break;
    }
    
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: textColor, size: AppDimensions.iconSmall),
            SizedBox(width: AppDimensions.paddingSmall),
            Expanded(
              child: Text(
                message,
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: textColor,
                onPressed: onAction,
              )
            : null,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        margin: EdgeInsets.all(AppDimensions.paddingMedium),
      ),
    );
  }
  
  // Show Dialog with Design System
  Future<T?> showAppDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
    String? barrierLabel,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
        elevation: AppDimensions.dialogElevation,
        child: child,
      ),
    );
  }
  
  // Show Bottom Sheet with Design System
  Future<T?> showAppBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      backgroundColor: colorScheme.surface,
      builder: (context) => child,
    );
  }
}

// Enums for Design System
enum SnackbarType { success, error, warning, info }

enum ButtonVariant { primary, secondary, tertiary, ghost, danger }

enum ButtonSize { small, medium, large }

enum CardVariant { elevated, outlined, filled }

enum InputVariant { outlined, filled, underlined }

enum BadgeVariant { primary, secondary, success, warning, error, info }

enum AvatarSize { small, medium, large, extraLarge }

enum SpacingSize { none, xsmall, small, medium, large, xlarge, xxlarge }

enum RadiusSize { none, xsmall, small, medium, large, xlarge, xxlarge, circular }

// Design System Utilities
class DesignSystemUtils {
  // Get Spacing Value
  static double getSpacing(SpacingSize size) {
    switch (size) {
      case SpacingSize.none:
        return 0;
      case SpacingSize.xsmall:
        return AppDimensions.paddingXSmall;
      case SpacingSize.small:
        return AppDimensions.paddingSmall;
      case SpacingSize.medium:
        return AppDimensions.paddingMedium;
      case SpacingSize.large:
        return AppDimensions.paddingLarge;
      case SpacingSize.xlarge:
        return AppDimensions.paddingXLarge;
      case SpacingSize.xxlarge:
        return AppDimensions.paddingXXLarge;
    }
  }
  
  // Get Radius Value
  static double getRadius(RadiusSize size) {
    switch (size) {
      case RadiusSize.none:
        return 0;
      case RadiusSize.xsmall:
        return AppDimensions.radiusXSmall;
      case RadiusSize.small:
        return AppDimensions.radiusSmall;
      case RadiusSize.medium:
        return AppDimensions.radiusMedium;
      case RadiusSize.large:
        return AppDimensions.radiusLarge;
      case RadiusSize.xlarge:
        return AppDimensions.radiusXLarge;
      case RadiusSize.xxlarge:
        return AppDimensions.radiusXXLarge;
      case RadiusSize.circular:
        return AppDimensions.radiusCircular;
    }
  }
  
  // Get Avatar Size
  static double getAvatarSize(AvatarSize size) {
    switch (size) {
      case AvatarSize.small:
        return AppDimensions.avatarSmall;
      case AvatarSize.medium:
        return AppDimensions.avatarMedium;
      case AvatarSize.large:
        return AppDimensions.avatarLarge;
      case AvatarSize.extraLarge:
        return AppDimensions.avatarXLarge;
    }
  }
  
  // Get Button Height
  static double getButtonHeight(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return AppDimensions.buttonHeightSmall;
      case ButtonSize.medium:
        return AppDimensions.buttonHeight;
      case ButtonSize.large:
        return AppDimensions.buttonHeightLarge;
    }
  }
  
  // Create Gradient
  static LinearGradient createGradient(
    List<Color> colors, {
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return LinearGradient(
      colors: colors,
      begin: begin,
      end: end,
    );
  }
  
  // Create Shadow
  static List<BoxShadow> createShadow({
    Color? color,
    double elevation = 2.0,
    double opacity = 0.1,
  }) {
    return [
      BoxShadow(
        color: (color ?? Colors.black).withOpacity(opacity),
        blurRadius: elevation * 2,
        offset: Offset(0, elevation),
      ),
    ];
  }
  
  // Create Border
  static Border createBorder({
    Color? color,
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
  }) {
    return Border.all(
      color: color ?? AppColors.neutral300,
      width: width,
      style: style,
    );
  }
  
  // Create Rounded Rectangle Border
  static RoundedRectangleBorder createRoundedBorder({
    double radius = 12.0,
    Color? borderColor,
    double borderWidth = 1.0,
  }) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: borderColor != null
          ? BorderSide(color: borderColor, width: borderWidth)
          : BorderSide.none,
    );
  }
}