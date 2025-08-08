import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final String? errorText;
  final String? helperText;
  final TextCapitalization textCapitalization;

  const CustomInput({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.errorText,
    this.helperText,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
        helperText: helperText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF667eea),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}