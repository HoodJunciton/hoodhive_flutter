import 'package:flutter/material.dart';
import '../../core/theme/design_system.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';

class DSButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final Color? customColor;
  final Widget? child;

  const DSButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.customColor,
    this.child,
  });

  const DSButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.customColor,
    this.child,
  }) : variant = ButtonVariant.primary;

  const DSButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.customColor,
    this.child,
  }) : variant = ButtonVariant.secondary;

  const DSButton.tertiary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.customColor,
    this.child,
  }) : variant = ButtonVariant.tertiary;

  const DSButton.ghost({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.customColor,
    this.child,
  }) : variant = ButtonVariant.ghost;

  const DSButton.danger({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.customColor,
    this.child,
  }) : variant = ButtonVariant.danger;

  @override
  Widget build(BuildContext context) {
    final buttonHeight = DesignSystemUtils.getButtonHeight(size);
    final isEnabled = onPressed != null && !isLoading;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: buttonHeight,
      child: _buildButton(context, isEnabled),
    );
  }

  Widget _buildButton(BuildContext context, bool isEnabled) {
    switch (variant) {
      case ButtonVariant.primary:
        return _buildElevatedButton(context, isEnabled);
      case ButtonVariant.secondary:
        return _buildOutlinedButton(context, isEnabled);
      case ButtonVariant.tertiary:
        return _buildFilledButton(context, isEnabled);
      case ButtonVariant.ghost:
        return _buildTextButton(context, isEnabled);
      case ButtonVariant.danger:
        return _buildDangerButton(context, isEnabled);
    }
  }

  Widget _buildElevatedButton(BuildContext context, bool isEnabled) {
    final backgroundColor = customColor ?? context.colorScheme.primary;
    final foregroundColor = customColor != null 
        ? Colors.white 
        : context.colorScheme.onPrimary;

    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: AppDimensions.buttonElevation,
        shadowColor: backgroundColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        padding: _getPadding(),
        textStyle: _getTextStyle(context),
      ),
      child: _buildButtonContent(context, foregroundColor),
    );
  }

  Widget _buildOutlinedButton(BuildContext context, bool isEnabled) {
    final borderColor = customColor ?? context.colorScheme.primary;
    final textColor = customColor ?? context.colorScheme.primary;

    return OutlinedButton(
      onPressed: isEnabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        side: BorderSide(
          color: borderColor,
          width: AppDimensions.borderWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        padding: _getPadding(),
        textStyle: _getTextStyle(context),
      ),
      child: _buildButtonContent(context, textColor),
    );
  }

  Widget _buildFilledButton(BuildContext context, bool isEnabled) {
    final backgroundColor = customColor?.withOpacity(0.1) ?? 
        context.colorScheme.primaryContainer;
    final textColor = customColor ?? context.colorScheme.onPrimaryContainer;

    return FilledButton(
      onPressed: isEnabled ? onPressed : null,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        padding: _getPadding(),
        textStyle: _getTextStyle(context),
      ),
      child: _buildButtonContent(context, textColor),
    );
  }

  Widget _buildTextButton(BuildContext context, bool isEnabled) {
    final textColor = customColor ?? context.colorScheme.primary;

    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        padding: _getPadding(),
        textStyle: _getTextStyle(context),
      ),
      child: _buildButtonContent(context, textColor),
    );
  }

  Widget _buildDangerButton(BuildContext context, bool isEnabled) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
        foregroundColor: Colors.white,
        elevation: AppDimensions.buttonElevation,
        shadowColor: AppColors.error.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        padding: _getPadding(),
        textStyle: _getTextStyle(context),
      ),
      child: _buildButtonContent(context, Colors.white),
    );
  }

  Widget _buildButtonContent(BuildContext context, Color textColor) {
    if (isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    if (child != null) {
      return child!;
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize()),
          SizedBox(width: AppDimensions.paddingSmall),
          Text(text),
        ],
      );
    }

    return Text(text);
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        );
      case ButtonSize.medium:
        return EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
          vertical: AppDimensions.paddingMedium,
        );
      case ButtonSize.large:
        return EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXLarge,
          vertical: AppDimensions.paddingLarge,
        );
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    switch (size) {
      case ButtonSize.small:
        return AppTypography.textTheme.labelMedium!.copyWith(
          fontWeight: FontWeight.w600,
        );
      case ButtonSize.medium:
        return AppTypography.textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.w600,
        );
      case ButtonSize.large:
        return AppTypography.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
        );
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return AppDimensions.iconSmall;
      case ButtonSize.medium:
        return AppDimensions.iconMedium;
      case ButtonSize.large:
        return AppDimensions.iconLarge;
    }
  }
}