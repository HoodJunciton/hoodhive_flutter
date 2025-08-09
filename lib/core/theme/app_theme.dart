import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_dimensions.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.lightColorScheme,
      textTheme: AppTypography.textTheme,
      appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      filledButtonTheme: _filledButtonTheme,
      iconButtonTheme: _iconButtonTheme,
      floatingActionButtonTheme: _floatingActionButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      chipTheme: _chipTheme,
      dividerTheme: _dividerTheme,
      listTileTheme: _listTileTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      navigationBarTheme: _navigationBarTheme,
      navigationRailTheme: _navigationRailTheme,
      tabBarTheme: _tabBarTheme,
      dialogTheme: _dialogTheme,
      snackBarTheme: _snackBarTheme,
      bottomSheetTheme: _bottomSheetTheme,
      expansionTileTheme: _expansionTileTheme,
      drawerTheme: _drawerTheme,
      popupMenuTheme: _popupMenuTheme,
      menuTheme: _menuTheme,
      menuBarTheme: _menuBarTheme,
      menuButtonTheme: _menuButtonTheme,
      switchTheme: _switchTheme,
      checkboxTheme: _checkboxTheme,
      radioTheme: _radioTheme,
      sliderTheme: _sliderTheme,
      progressIndicatorTheme: _progressIndicatorTheme,
      tooltipTheme: _tooltipTheme,
      bannerTheme: _bannerTheme,
      dataTableTheme: _dataTableTheme,
      timePickerTheme: _timePickerTheme,
      datePickerTheme: _datePickerTheme,
      searchBarTheme: _searchBarTheme,
      searchViewTheme: _searchViewTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.darkColorScheme,
      textTheme: AppTypography.textTheme,
      appBarTheme: _appBarTheme.copyWith(
        backgroundColor: AppColors.darkColorScheme.surface,
        foregroundColor: AppColors.darkColorScheme.onSurface,
      ),
      cardTheme: _cardTheme.copyWith(
        color: AppColors.darkColorScheme.surface,
      ),
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      filledButtonTheme: _filledButtonTheme,
      iconButtonTheme: _iconButtonTheme,
      floatingActionButtonTheme: _floatingActionButtonTheme,
      inputDecorationTheme: _inputDecorationTheme.copyWith(
        fillColor: AppColors.darkColorScheme.surfaceContainerHighest
            .withValues(alpha: 0.3),
      ),
      chipTheme: _chipTheme.copyWith(
        backgroundColor: AppColors.darkColorScheme.surfaceContainerHighest,
        selectedColor: AppColors.darkColorScheme.primaryContainer,
      ),
      dividerTheme: _dividerTheme.copyWith(
        color: AppColors.darkColorScheme.outline.withValues(alpha: 0.2),
      ),
      listTileTheme: _listTileTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme.copyWith(
        selectedItemColor: AppColors.darkColorScheme.primary,
        unselectedItemColor: AppColors.darkColorScheme.onSurfaceVariant,
      ),
      navigationBarTheme: _navigationBarTheme,
      navigationRailTheme: _navigationRailTheme.copyWith(
        backgroundColor: AppColors.darkColorScheme.surface,
        selectedIconTheme: IconThemeData(
          color: AppColors.darkColorScheme.primary,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.darkColorScheme.onSurfaceVariant,
        ),
      ),
      tabBarTheme: _tabBarTheme.copyWith(
        labelColor: AppColors.darkColorScheme.primary,
        unselectedLabelColor: AppColors.darkColorScheme.onSurfaceVariant,
      ),
      dialogTheme: _dialogTheme.copyWith(
        backgroundColor: AppColors.darkColorScheme.surface,
      ),
      snackBarTheme: _snackBarTheme.copyWith(
        backgroundColor: AppColors.darkColorScheme.inverseSurface,
        contentTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: AppColors.darkColorScheme.onInverseSurface,
        ),
      ),
      bottomSheetTheme: _bottomSheetTheme.copyWith(
        backgroundColor: AppColors.darkColorScheme.surface,
      ),
      expansionTileTheme: _expansionTileTheme.copyWith(
        backgroundColor: AppColors.darkColorScheme.surfaceContainerHighest
            .withValues(alpha: 0.3),
        textColor: AppColors.darkColorScheme.onSurface,
        iconColor: AppColors.darkColorScheme.onSurfaceVariant,
      ),
      drawerTheme: _drawerTheme.copyWith(
        backgroundColor: AppColors.darkColorScheme.surface,
      ),
      popupMenuTheme: _popupMenuTheme.copyWith(
        color: AppColors.darkColorScheme.surface,
      ),
      menuTheme: _menuTheme,
      menuBarTheme: _menuBarTheme,
      menuButtonTheme: _menuButtonTheme,
      switchTheme: _switchTheme,
      checkboxTheme: _checkboxTheme,
      radioTheme: _radioTheme,
      sliderTheme: _sliderTheme,
      progressIndicatorTheme: _progressIndicatorTheme,
      tooltipTheme: _tooltipTheme.copyWith(
        decoration: BoxDecoration(
          color: AppColors.darkColorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
      ),
      bannerTheme: _bannerTheme,
      dataTableTheme: _dataTableTheme,
      timePickerTheme: _timePickerTheme,
      datePickerTheme: _datePickerTheme,
      searchBarTheme: _searchBarTheme,
      searchViewTheme: _searchViewTheme,
    );
  }

  static AppBarTheme get _appBarTheme => AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.lightColorScheme.onSurface,
        titleTextStyle: AppTypography.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        toolbarHeight: AppDimensions.appBarHeight,
      );

  static CardThemeData get _cardTheme => CardThemeData(
        elevation: AppDimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
        margin: EdgeInsets.all(AppDimensions.paddingSmall),
      );

  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: AppDimensions.buttonElevation,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge,
            vertical: AppDimensions.paddingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          textStyle: AppTypography.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          minimumSize: Size(0, AppDimensions.buttonHeight),
        ),
      );

  static OutlinedButtonThemeData get _outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge,
            vertical: AppDimensions.paddingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          side: BorderSide(
            width: AppDimensions.borderWidth,
            color: AppColors.lightColorScheme.outline,
          ),
          textStyle: AppTypography.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          minimumSize: Size(0, AppDimensions.buttonHeight),
        ),
      );

  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingSmall,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
          textStyle: AppTypography.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightColorScheme.surfaceContainerHighest
            .withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(
            color: AppColors.lightColorScheme.outline,
            width: AppDimensions.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(
            color: AppColors.lightColorScheme.outline,
            width: AppDimensions.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(
            color: AppColors.lightColorScheme.primary,
            width: AppDimensions.borderWidthFocused,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(
            color: AppColors.lightColorScheme.error,
            width: AppDimensions.borderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(
            color: AppColors.lightColorScheme.error,
            width: AppDimensions.borderWidthFocused,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingMedium,
        ),
        labelStyle: AppTypography.textTheme.bodyMedium,
        hintStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: AppColors.lightColorScheme.onSurfaceVariant,
        ),
      );

  static ChipThemeData get _chipTheme => ChipThemeData(
        backgroundColor: AppColors.lightColorScheme.surfaceContainerHighest,
        selectedColor: AppColors.lightColorScheme.primaryContainer,
        disabledColor: AppColors.lightColorScheme.surfaceContainerHighest
            .withValues(alpha: 0.5),
        labelStyle: AppTypography.textTheme.labelMedium,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall,
          vertical: AppDimensions.paddingXSmall,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
      );

  static DividerThemeData get _dividerTheme => DividerThemeData(
        color: AppColors.lightColorScheme.outline.withValues(alpha: 0.2),
        thickness: AppDimensions.dividerThickness,
        space: AppDimensions.paddingMedium,
      );

  static ListTileThemeData get _listTileTheme => ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        titleTextStyle: AppTypography.textTheme.titleMedium,
        subtitleTextStyle: AppTypography.textTheme.bodyMedium,
      );

  static BottomNavigationBarThemeData get _bottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        elevation: AppDimensions.cardElevation,
        selectedItemColor: AppColors.lightColorScheme.primary,
        unselectedItemColor: AppColors.lightColorScheme.onSurfaceVariant,
        selectedLabelStyle: AppTypography.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTypography.textTheme.labelSmall,
      );

  static NavigationRailThemeData get _navigationRailTheme =>
      NavigationRailThemeData(
        backgroundColor: AppColors.lightColorScheme.surface,
        selectedIconTheme: IconThemeData(
          color: AppColors.lightColorScheme.primary,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.lightColorScheme.onSurfaceVariant,
        ),
        selectedLabelTextStyle: AppTypography.textTheme.labelMedium?.copyWith(
          color: AppColors.lightColorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelTextStyle: AppTypography.textTheme.labelMedium?.copyWith(
          color: AppColors.lightColorScheme.onSurfaceVariant,
        ),
      );

  static TabBarThemeData get _tabBarTheme => TabBarThemeData(
        labelColor: AppColors.lightColorScheme.primary,
        unselectedLabelColor: AppColors.lightColorScheme.onSurfaceVariant,
        labelStyle: AppTypography.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTypography.textTheme.titleSmall,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.lightColorScheme.primary,
            width: AppDimensions.borderWidthFocused,
          ),
        ),
      );

  static DialogThemeData get _dialogTheme => DialogThemeData(
        elevation: AppDimensions.dialogElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
        titleTextStyle: AppTypography.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: AppTypography.textTheme.bodyMedium,
      );

  static SnackBarThemeData get _snackBarTheme => SnackBarThemeData(
        backgroundColor: AppColors.lightColorScheme.inverseSurface,
        contentTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: AppColors.lightColorScheme.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: AppDimensions.cardElevation,
      );

  static BottomSheetThemeData get _bottomSheetTheme => BottomSheetThemeData(
        elevation: AppDimensions.dialogElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.radiusLarge),
          ),
        ),
        backgroundColor: AppColors.lightColorScheme.surface,
      );

  static ExpansionTileThemeData get _expansionTileTheme =>
      ExpansionTileThemeData(
        backgroundColor: AppColors.lightColorScheme.surfaceContainerHighest
            .withValues(alpha: 0.3),
        collapsedBackgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        
        // titleTextStyle: Typography.textTheme.titleMedium?.copyWith(
        //   fontWeight: FontWeight.w600,
        // ),
        textColor: AppColors.lightColorScheme.onSurface,
        iconColor: AppColors.lightColorScheme.onSurfaceVariant,
      );

  // Additional Button Themes
  static FilledButtonThemeData get _filledButtonTheme => FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge,
            vertical: AppDimensions.paddingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          textStyle: AppTypography.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          minimumSize: Size(0, AppDimensions.buttonHeight),
        ),
      );

  static IconButtonThemeData get _iconButtonTheme => IconButtonThemeData(
        style: IconButton.styleFrom(
          padding: EdgeInsets.all(AppDimensions.paddingSmall),
          minimumSize:
              Size(AppDimensions.buttonHeight, AppDimensions.buttonHeight),
          iconSize: AppDimensions.iconMedium,
        ),
      );

  static FloatingActionButtonThemeData get _floatingActionButtonTheme =>
      FloatingActionButtonThemeData(
        elevation: AppDimensions.fabElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
        iconSize: AppDimensions.iconLarge,
      );

  // Navigation Themes
  static NavigationBarThemeData get _navigationBarTheme =>
      NavigationBarThemeData(
        elevation: AppDimensions.cardElevation,
        height: AppDimensions.bottomNavHeight,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.lightColorScheme.primary,
            );
          }
          return AppTypography.textTheme.labelSmall?.copyWith(
            color: AppColors.lightColorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: AppColors.lightColorScheme.primary,
              size: AppDimensions.iconMedium,
            );
          }
          return IconThemeData(
            color: AppColors.lightColorScheme.onSurfaceVariant,
            size: AppDimensions.iconMedium,
          );
        }),
      );

  // Drawer Theme
  static DrawerThemeData get _drawerTheme => DrawerThemeData(
        backgroundColor: AppColors.lightColorScheme.surface,
        elevation: AppDimensions.dialogElevation,
        width: AppDimensions.drawerWidth,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(AppDimensions.radiusLarge),
          ),
        ),
      );

  // Menu Themes
  static PopupMenuThemeData get _popupMenuTheme => PopupMenuThemeData(
        elevation: AppDimensions.cardElevation,
        color: AppColors.lightColorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        textStyle: AppTypography.textTheme.bodyMedium,
      );

  static MenuThemeData get _menuTheme => MenuThemeData(
        style: MenuStyle(
          elevation: WidgetStateProperty.all(AppDimensions.cardElevation),
          backgroundColor:
              WidgetStateProperty.all(AppColors.lightColorScheme.surface),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
          ),
        ),
      );

  static MenuBarThemeData get _menuBarTheme => MenuBarThemeData(
        style: MenuStyle(
          backgroundColor:
              WidgetStateProperty.all(AppColors.lightColorScheme.surface),
          elevation: WidgetStateProperty.all(AppDimensions.cardElevation),
        ),
      );

  static MenuButtonThemeData get _menuButtonTheme => MenuButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.paddingSmall,
            ),
          ),
          textStyle:
              WidgetStateProperty.all(AppTypography.textTheme.bodyMedium),
        ),
      );

  // Form Control Themes
  static SwitchThemeData get _switchTheme => SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightColorScheme.onPrimary;
          }
          return AppColors.lightColorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightColorScheme.primary;
          }
          return AppColors.lightColorScheme.surfaceContainerHighest;
        }),
      );

  static CheckboxThemeData get _checkboxTheme => CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightColorScheme.primary;
          }
          return Colors.transparent;
        }),
        checkColor:
            WidgetStateProperty.all(AppColors.lightColorScheme.onPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXSmall),
        ),
      );

  static RadioThemeData get _radioTheme => RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightColorScheme.primary;
          }
          return AppColors.lightColorScheme.outline;
        }),
      );

  static SliderThemeData get _sliderTheme => SliderThemeData(
        activeTrackColor: AppColors.lightColorScheme.primary,
        inactiveTrackColor: AppColors.lightColorScheme.surfaceContainerHighest,
        thumbColor: AppColors.lightColorScheme.primary,
        overlayColor:
            AppColors.lightColorScheme.primary.withValues(alpha: 0.12),
        valueIndicatorColor: AppColors.lightColorScheme.primary,
        valueIndicatorTextStyle: AppTypography.textTheme.bodySmall?.copyWith(
          color: AppColors.lightColorScheme.onPrimary,
        ),
      );

  // Progress Indicator Theme
  static ProgressIndicatorThemeData get _progressIndicatorTheme =>
      ProgressIndicatorThemeData(
        color: AppColors.lightColorScheme.primary,
        linearTrackColor: AppColors.lightColorScheme.surfaceContainerHighest,
        circularTrackColor: AppColors.lightColorScheme.surfaceContainerHighest,
        refreshBackgroundColor: AppColors.lightColorScheme.surface,
      );

  // Tooltip Theme
  static TooltipThemeData get _tooltipTheme => TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.lightColorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
        textStyle: AppTypography.textTheme.bodySmall?.copyWith(
          color: AppColors.lightColorScheme.onInverseSurface,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall,
          vertical: AppDimensions.paddingXSmall,
        ),
      );

  // Banner Theme
  static MaterialBannerThemeData get _bannerTheme => MaterialBannerThemeData(
        backgroundColor: AppColors.lightColorScheme.surface,
        contentTextStyle: AppTypography.textTheme.bodyMedium,
        padding: EdgeInsets.all(AppDimensions.paddingMedium),
      );

  // Data Table Theme
  static DataTableThemeData get _dataTableTheme => DataTableThemeData(
        decoration: BoxDecoration(
          color: AppColors.lightColorScheme.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        headingTextStyle: AppTypography.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        dataTextStyle: AppTypography.textTheme.bodyMedium,
        headingRowColor: WidgetStateProperty.all(
          AppColors.lightColorScheme.surfaceContainerHighest
              .withValues(alpha: 0.5),
        ),
        dataRowMinHeight: AppDimensions.listTileHeight,
        columnSpacing: AppDimensions.paddingMedium,
        horizontalMargin: AppDimensions.paddingMedium,
      );

  // Time Picker Theme
  static TimePickerThemeData get _timePickerTheme => TimePickerThemeData(
        backgroundColor: AppColors.lightColorScheme.surface,
        hourMinuteTextColor: AppColors.lightColorScheme.onSurface,
        hourMinuteColor: AppColors.lightColorScheme.surfaceContainerHighest,
        dayPeriodTextColor: AppColors.lightColorScheme.onSurface,
        dayPeriodColor: AppColors.lightColorScheme.surfaceContainerHighest,
        dialHandColor: AppColors.lightColorScheme.primary,
        dialBackgroundColor: AppColors.lightColorScheme.surfaceContainerHighest,
        dialTextColor: AppColors.lightColorScheme.onSurface,
        entryModeIconColor: AppColors.lightColorScheme.onSurface,
        hourMinuteTextStyle: AppTypography.textTheme.headlineMedium,
        dayPeriodTextStyle: AppTypography.textTheme.titleMedium,
        helpTextStyle: AppTypography.textTheme.labelMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
      );

  // Date Picker Theme
  static DatePickerThemeData get _datePickerTheme => DatePickerThemeData(
        backgroundColor: AppColors.lightColorScheme.surface,
        headerBackgroundColor: AppColors.lightColorScheme.primaryContainer,
        headerForegroundColor: AppColors.lightColorScheme.onPrimaryContainer,
        weekdayStyle: AppTypography.textTheme.bodySmall,
        dayStyle: AppTypography.textTheme.bodyMedium,
        yearStyle: AppTypography.textTheme.bodyLarge,
        rangePickerBackgroundColor: AppColors.lightColorScheme.surface,
        rangeSelectionBackgroundColor:
            AppColors.lightColorScheme.primaryContainer.withValues(alpha: 0.3),
        todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightColorScheme.primary;
          }
          return AppColors.lightColorScheme.surfaceContainerHighest;
        }),
        todayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightColorScheme.onPrimary;
          }
          return AppColors.lightColorScheme.primary;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
      );

  // Search Themes
  static SearchBarThemeData get _searchBarTheme => SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(
          AppColors.lightColorScheme.surfaceContainerHighest
              .withValues(alpha: 0.3),
        ),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium),
        ),
        textStyle: WidgetStateProperty.all(AppTypography.textTheme.bodyMedium),
        hintStyle: WidgetStateProperty.all(
          AppTypography.textTheme.bodyMedium?.copyWith(
            color: AppColors.lightColorScheme.onSurfaceVariant,
          ),
        ),
      );

  static SearchViewThemeData get _searchViewTheme => SearchViewThemeData(
        backgroundColor: AppColors.lightColorScheme.surface,
        elevation: AppDimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
        headerTextStyle: AppTypography.textTheme.bodyLarge,
        headerHintStyle: AppTypography.textTheme.bodyLarge?.copyWith(
          color: AppColors.lightColorScheme.onSurfaceVariant,
        ),
      );
}
