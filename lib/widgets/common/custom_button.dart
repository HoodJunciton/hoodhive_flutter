import 'package:flutter/material.dart';
import 'package:hoodhive_flutter/core/theme/design_system_exports.dart';
import '../../widgets/design_system/ds_button.dart';

// Legacy wrapper for backward compatibility
class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DSButton(
        text: text,
        onPressed: onPressed,
        variant: isOutlined ? ButtonVariant.secondary : ButtonVariant.primary,
        size: height <= 36 
            ? ButtonSize.small 
            : height >= 56 
                ? ButtonSize.large 
                : ButtonSize.medium,
        icon: icon,
        isLoading: isLoading,
        isFullWidth: width == double.infinity,
        customColor: backgroundColor,
      ),
    );
  }
}