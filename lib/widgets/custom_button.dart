import 'package:flutter/material.dart';

enum ButtonType { filled, outlined, text }

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final ButtonType buttonType;
  final bool isLoading;
  final bool fullWidth;
  final IconData? icon;
  final Color? color;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonType = ButtonType.filled,
    this.isLoading = false,
    this.fullWidth = false,
    this.icon,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? const Color(0xFF667eea);
    final isDisabled = onPressed == null || isLoading;

    Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading) ...[
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          Icon(
            icon,
            color: buttonType == ButtonType.filled ? Colors.white : buttonColor,
            size: 20,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: buttonType == ButtonType.filled
                ? Colors.white
                : (isDisabled ? Colors.grey : buttonColor),
          ),
        ),
      ],
    );

    switch (buttonType) {
      case ButtonType.filled:
        return SizedBox(
          width: fullWidth ? double.infinity : width,
          height: height ?? 50,
          child: ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDisabled ? Colors.grey : buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: buttonContent,
          ),
        );

      case ButtonType.outlined:
        return SizedBox(
          width: fullWidth ? double.infinity : width,
          height: height ?? 50,
          child: OutlinedButton(
            onPressed: isDisabled ? null : onPressed,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: isDisabled ? Colors.grey : buttonColor,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: buttonContent,
          ),
        );

      case ButtonType.text:
        return SizedBox(
          width: fullWidth ? double.infinity : width,
          height: height ?? 50,
          child: TextButton(
            onPressed: isDisabled ? null : onPressed,
            style: TextButton.styleFrom(
              foregroundColor: isDisabled ? Colors.grey : buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: buttonContent,
          ),
        );
    }
  }
}