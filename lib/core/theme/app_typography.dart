import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // Font Families
  static const String primaryFontFamily = 'Inter';
  static const String secondaryFontFamily = 'Roboto';
  static const String displayFontFamily = 'Poppins';
  
  // Font Weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
  
  // Font Sizes
  static const double fontSizeXSmall = 10.0;
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeXLarge = 18.0;
  static const double fontSizeXXLarge = 20.0;
  static const double fontSizeXXXLarge = 24.0;
  static const double fontSizeDisplay = 32.0;
  static const double fontSizeDisplayLarge = 40.0;
  
  // Line Heights
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.4;
  static const double lineHeightRelaxed = 1.6;
  static const double lineHeightLoose = 1.8;
  
  // Letter Spacing
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingExtraWide = 1.0;
  
  // Text Theme
  static TextTheme get textTheme => GoogleFonts.interTextTheme().copyWith(
        // Display Styles
        displayLarge: GoogleFonts.poppins(
          fontSize: fontSizeDisplayLarge,
          fontWeight: bold,
          height: lineHeightTight,
          letterSpacing: letterSpacingTight,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: fontSizeDisplay,
          fontWeight: bold,
          height: lineHeightTight,
          letterSpacing: letterSpacingTight,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: fontSizeXXXLarge,
          fontWeight: semiBold,
          height: lineHeightNormal,
          letterSpacing: letterSpacingNormal,
        ),
        
        // Headline Styles
        headlineLarge: GoogleFonts.poppins(
          fontSize: fontSizeXXLarge,
          fontWeight: semiBold,
          height: lineHeightNormal,
          letterSpacing: letterSpacingNormal,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: fontSizeXLarge,
          fontWeight: semiBold,
          height: lineHeightNormal,
          letterSpacing: letterSpacingNormal,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: fontSizeLarge,
          fontWeight: medium,
          height: lineHeightNormal,
          letterSpacing: letterSpacingNormal,
        ),
        
        // Title Styles
        titleLarge: GoogleFonts.inter(
          fontSize: fontSizeLarge,
          fontWeight: semiBold,
          height: lineHeightNormal,
          letterSpacing: letterSpacingNormal,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: fontSizeMedium,
          fontWeight: medium,
          height: lineHeightNormal,
          letterSpacing: letterSpacingNormal,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: fontSizeSmall,
          fontWeight: medium,
          height: lineHeightNormal,
          letterSpacing: letterSpacingWide,
        ),
        
        // Body Styles
        bodyLarge: GoogleFonts.inter(
          fontSize: fontSizeLarge,
          fontWeight: regular,
          height: lineHeightRelaxed,
          letterSpacing: letterSpacingNormal,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: fontSizeMedium,
          fontWeight: regular,
          height: lineHeightRelaxed,
          letterSpacing: letterSpacingNormal,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: fontSizeSmall,
          fontWeight: regular,
          height: lineHeightNormal,
          letterSpacing: letterSpacingNormal,
        ),
        
        // Label Styles
        labelLarge: GoogleFonts.inter(
          fontSize: fontSizeMedium,
          fontWeight: medium,
          height: lineHeightNormal,
          letterSpacing: letterSpacingWide,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: fontSizeSmall,
          fontWeight: medium,
          height: lineHeightNormal,
          letterSpacing: letterSpacingWide,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: fontSizeXSmall,
          fontWeight: medium,
          height: lineHeightNormal,
          letterSpacing: letterSpacingExtraWide,
        ),
      );
  
  // Custom Text Styles
  static TextStyle get caption => GoogleFonts.inter(
        fontSize: fontSizeXSmall,
        fontWeight: regular,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  static TextStyle get overline => GoogleFonts.inter(
        fontSize: fontSizeXSmall,
        fontWeight: medium,
        height: lineHeightNormal,
        letterSpacing: letterSpacingExtraWide,
      );
  
  static TextStyle get button => GoogleFonts.inter(
        fontSize: fontSizeMedium,
        fontWeight: semiBold,
        height: lineHeightNormal,
        letterSpacing: letterSpacingWide,
      );
  
  // Specialized Text Styles
  static TextStyle get heroTitle => GoogleFonts.poppins(
        fontSize: fontSizeDisplayLarge,
        fontWeight: extraBold,
        height: lineHeightTight,
        letterSpacing: letterSpacingTight,
      );
  
  static TextStyle get sectionTitle => GoogleFonts.poppins(
        fontSize: fontSizeXLarge,
        fontWeight: bold,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  static TextStyle get cardTitle => GoogleFonts.inter(
        fontSize: fontSizeLarge,
        fontWeight: semiBold,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  static TextStyle get cardSubtitle => GoogleFonts.inter(
        fontSize: fontSizeMedium,
        fontWeight: regular,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  static TextStyle get inputLabel => GoogleFonts.inter(
        fontSize: fontSizeSmall,
        fontWeight: medium,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  static TextStyle get inputText => GoogleFonts.inter(
        fontSize: fontSizeMedium,
        fontWeight: regular,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  static TextStyle get inputHint => GoogleFonts.inter(
        fontSize: fontSizeMedium,
        fontWeight: regular,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  static TextStyle get tabLabel => GoogleFonts.inter(
        fontSize: fontSizeSmall,
        fontWeight: semiBold,
        height: lineHeightNormal,
        letterSpacing: letterSpacingWide,
      );
  
  static TextStyle get chipLabel => GoogleFonts.inter(
        fontSize: fontSizeSmall,
        fontWeight: medium,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  static TextStyle get badgeLabel => GoogleFonts.inter(
        fontSize: fontSizeXSmall,
        fontWeight: bold,
        height: lineHeightNormal,
        letterSpacing: letterSpacingWide,
      );
  
  static TextStyle get tooltipText => GoogleFonts.inter(
        fontSize: fontSizeSmall,
        fontWeight: regular,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  static TextStyle get errorText => GoogleFonts.inter(
        fontSize: fontSizeSmall,
        fontWeight: regular,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  static TextStyle get successText => GoogleFonts.inter(
        fontSize: fontSizeSmall,
        fontWeight: medium,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  static TextStyle get warningText => GoogleFonts.inter(
        fontSize: fontSizeSmall,
        fontWeight: medium,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  static TextStyle get infoText => GoogleFonts.inter(
        fontSize: fontSizeSmall,
        fontWeight: regular,
        height: lineHeightNormal,
        letterSpacing: letterSpacingNormal,
      );
  
  // Responsive Text Styles
  static TextStyle responsiveTitle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) {
      return heroTitle;
    } else if (screenWidth > 600) {
      return textTheme.displaySmall!;
    } else {
      return textTheme.headlineMedium!;
    }
  }
  
  static TextStyle responsiveBody(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return textTheme.bodyLarge!;
    } else {
      return textTheme.bodyMedium!;
    }
  }
  
  // Utility Methods
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }
  
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
  
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }
  
  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }
  
  static TextStyle withSpacing(TextStyle style, double spacing) {
    return style.copyWith(letterSpacing: spacing);
  }
}