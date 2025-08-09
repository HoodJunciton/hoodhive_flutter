import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/design_system.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';

class DSTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final InputVariant variant;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool isRequired;
  final Color? fillColor;
  final Color? borderColor;

  const DSTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.variant = InputVariant.outlined,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.isRequired = false,
    this.fillColor,
    this.borderColor,
  });

  const DSTextField.outlined({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.isRequired = false,
    this.fillColor,
    this.borderColor,
  }) : variant = InputVariant.outlined;

  const DSTextField.filled({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.isRequired = false,
    this.fillColor,
    this.borderColor,
  }) : variant = InputVariant.filled;

  const DSTextField.underlined({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.isRequired = false,
    this.fillColor,
    this.borderColor,
  }) : variant = InputVariant.underlined;

  @override
  State<DSTextField> createState() => _DSTextFieldState();
}

class _DSTextFieldState extends State<DSTextField> {
  late bool _obscureText;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          _buildLabel(context),
          SizedBox(height: AppDimensions.paddingSmall),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          validator: widget.validator,
          obscureText: _obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          autofocus: widget.autofocus,
          style: AppTypography.inputText.copyWith(
            color: widget.enabled 
                ? context.colorScheme.onSurface 
                : context.colorScheme.onSurface.withOpacity(0.6),
          ),
          decoration: _buildInputDecoration(context),
        ),
        if (widget.helperText != null || widget.errorText != null) ...[
          SizedBox(height: AppDimensions.paddingXSmall),
          _buildHelperText(context),
        ],
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: widget.label!,
        style: AppTypography.inputLabel.copyWith(
          color: _isFocused 
              ? context.colorScheme.primary 
              : context.colorScheme.onSurfaceVariant,
        ),
        children: widget.isRequired
            ? [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: AppColors.error),
                ),
              ]
            : null,
      ),
    );
  }

  Widget _buildHelperText(BuildContext context) {
    final text = widget.errorText ?? widget.helperText;
    final isError = widget.errorText != null;
    
    return Text(
      text!,
      style: AppTypography.textTheme.bodySmall?.copyWith(
        color: isError 
            ? AppColors.error 
            : context.colorScheme.onSurfaceVariant,
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    final hasError = widget.errorText != null;
    final primaryColor = context.colorScheme.primary;
    final errorColor = AppColors.error;
    final outlineColor = widget.borderColor ?? context.colorScheme.outline;
    
    switch (widget.variant) {
      case InputVariant.outlined:
        return InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTypography.inputHint.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
          prefixIcon: widget.prefixIcon != null 
              ? Icon(
                  widget.prefixIcon,
                  color: _isFocused 
                      ? primaryColor 
                      : context.colorScheme.onSurfaceVariant,
                  size: AppDimensions.iconMedium,
                )
              : null,
          suffixIcon: _buildSuffixIcon(context),
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            borderSide: BorderSide(
              color: outlineColor,
              width: AppDimensions.borderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            borderSide: BorderSide(
              color: hasError ? errorColor : outlineColor,
              width: AppDimensions.borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            borderSide: BorderSide(
              color: hasError ? errorColor : primaryColor,
              width: AppDimensions.borderWidthFocused,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            borderSide: BorderSide(
              color: errorColor,
              width: AppDimensions.borderWidth,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            borderSide: BorderSide(
              color: errorColor,
              width: AppDimensions.borderWidthFocused,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingMedium,
          ),
        );
        
      case InputVariant.filled:
        return InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTypography.inputHint.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
          prefixIcon: widget.prefixIcon != null 
              ? Icon(
                  widget.prefixIcon,
                  color: _isFocused 
                      ? primaryColor 
                      : context.colorScheme.onSurfaceVariant,
                  size: AppDimensions.iconMedium,
                )
              : null,
          suffixIcon: _buildSuffixIcon(context),
          filled: true,
          fillColor: widget.fillColor ?? 
              context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            borderSide: hasError 
                ? BorderSide(color: errorColor, width: AppDimensions.borderWidth)
                : BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            borderSide: BorderSide(
              color: hasError ? errorColor : primaryColor,
              width: AppDimensions.borderWidthFocused,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            borderSide: BorderSide(
              color: errorColor,
              width: AppDimensions.borderWidth,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            borderSide: BorderSide(
              color: errorColor,
              width: AppDimensions.borderWidthFocused,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingMedium,
          ),
        );
        
      case InputVariant.underlined:
        return InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTypography.inputHint.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
          prefixIcon: widget.prefixIcon != null 
              ? Icon(
                  widget.prefixIcon,
                  color: _isFocused 
                      ? primaryColor 
                      : context.colorScheme.onSurfaceVariant,
                  size: AppDimensions.iconMedium,
                )
              : null,
          suffixIcon: _buildSuffixIcon(context),
          filled: false,
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: outlineColor,
              width: AppDimensions.borderWidth,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: hasError ? errorColor : outlineColor,
              width: AppDimensions.borderWidth,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: hasError ? errorColor : primaryColor,
              width: AppDimensions.borderWidthFocused,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: errorColor,
              width: AppDimensions.borderWidth,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: errorColor,
              width: AppDimensions.borderWidthFocused,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingSmall,
            vertical: AppDimensions.paddingMedium,
          ),
        );
    }
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: context.colorScheme.onSurfaceVariant,
          size: AppDimensions.iconMedium,
        ),
        onPressed: _toggleObscureText,
      );
    }
    
    return widget.suffixIcon;
  }
}