import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color primaryGreenLight = Color(0xFF60AD5E);
  static const Color primaryGreenDark = Color(0xFF005005);
  
  // Secondary Colors
  static const Color secondaryBlue = Color(0xFF1976D2);
  static const Color secondaryBlueLight = Color(0xFF63A4FF);
  static const Color secondaryBlueDark = Color(0xFF004BA0);
  
  // Accent Colors
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color accentOrangeLight = Color(0xFFFFC947);
  static const Color accentOrangeDark = Color(0xFFC66900);
  
  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF80E27E);
  static const Color successDark = Color(0xFF087F23);
  
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFC947);
  static const Color warningDark = Color(0xFFC66900);
  
  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFFFF6F60);
  static const Color errorDark = Color(0xFFAB000D);
  
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF6EC6FF);
  static const Color infoDark = Color(0xFF0069C0);
  
  // Neutral Colors
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFEEEEEE);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF616161);
  static const Color neutral800 = Color(0xFF424242);
  static const Color neutral900 = Color(0xFF212121);
  
  // Surface Colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF121212);
  static const Color surfaceVariantLight = Color(0xFFF3F3F3);
  static const Color surfaceVariantDark = Color(0xFF2C2C2C);
  static const Color surfaceContainerHighestLight = Color(0xFFE6E0E9);
  static const Color surfaceContainerHighestDark = Color(0xFF49454F);
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFFCFCFC);
  static const Color backgroundDark = Color(0xFF0F0F0F);
  
  // Light Color Scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryGreen,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFB8E6B8),
    onPrimaryContainer: Color(0xFF002106),
    secondary: secondaryBlue,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFD1E4FF),
    onSecondaryContainer: Color(0xFF001D36),
    tertiary: accentOrange,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFFFDCC1),
    onTertiaryContainer: Color(0xFF2D1600),
    error: error,
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    background: backgroundLight,
    onBackground: neutral900,
    surface: surfaceLight,
    onSurface: neutral900,
    surfaceVariant: surfaceVariantLight,
    onSurfaceVariant: neutral700,
    surfaceContainerHighest: surfaceContainerHighestLight,
    outline: neutral400,
    outlineVariant: neutral200,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: neutral800,
    onInverseSurface: neutral100,
    inversePrimary: Color(0xFF9DD99F),
  );
  
  // Dark Color Scheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF9DD99F),
    onPrimary: Color(0xFF003A03),
    primaryContainer: Color(0xFF005D06),
    onPrimaryContainer: Color(0xFFB8E6B8),
    secondary: Color(0xFFA0CAFF),
    onSecondary: Color(0xFF003258),
    secondaryContainer: Color(0xFF00497D),
    onSecondaryContainer: Color(0xFFD1E4FF),
    tertiary: Color(0xFFFFB77C),
    onTertiary: Color(0xFF4A2800),
    tertiaryContainer: Color(0xFF693C00),
    onTertiaryContainer: Color(0xFFFFDCC1),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    background: backgroundDark,
    onBackground: neutral100,
    surface: surfaceDark,
    onSurface: neutral100,
    surfaceVariant: surfaceVariantDark,
    onSurfaceVariant: neutral300,
    surfaceContainerHighest: surfaceContainerHighestDark,
    outline: neutral600,
    outlineVariant: neutral800,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: neutral100,
    onInverseSurface: neutral800,
    inversePrimary: primaryGreen,
  );
  
  // Status Colors
  static const Map<String, Color> statusColors = {
    'pending': warning,
    'approved': success,
    'rejected': error,
    'active': success,
    'inactive': neutral500,
    'occupied': error,
    'available': success,
    'maintenance': warning,
  };
  
  // Role Colors
  static const Map<String, Color> roleColors = {
    'admin': Color(0xFF6A1B9A),
    'resident': primaryGreen,
    'tenant': secondaryBlue,
    'security': Color(0xFF795548),
    'maintenance': accentOrange,
  };
  
  // Gradient Colors
  static const List<Color> primaryGradient = [
    primaryGreen,
    primaryGreenLight,
  ];
  
  static const List<Color> secondaryGradient = [
    secondaryBlue,
    secondaryBlueLight,
  ];
  
  static const List<Color> successGradient = [
    success,
    successLight,
  ];
  
  static const List<Color> warningGradient = [
    warning,
    warningLight,
  ];
  
  static const List<Color> errorGradient = [
    error,
    errorLight,
  ];
  
  // Utility Methods
  static Color getStatusColor(String status) {
    return statusColors[status.toLowerCase()] ?? neutral500;
  }
  
  static Color getRoleColor(String role) {
    return roleColors[role.toLowerCase()] ?? neutral500;
  }
  
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }
  
  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
  
  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}