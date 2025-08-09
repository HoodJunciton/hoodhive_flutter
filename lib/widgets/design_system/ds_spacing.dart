import 'package:flutter/material.dart';
import '../../core/theme/design_system.dart';

// Spacing Widgets
class DSSpacing extends StatelessWidget {
  final SpacingSize size;
  final bool isVertical;

  const DSSpacing({
    super.key,
    required this.size,
    this.isVertical = true,
  });

  const DSSpacing.vertical(SpacingSize size, {super.key})
      : size = size,
        isVertical = true;

  const DSSpacing.horizontal(SpacingSize size, {super.key})
      : size = size,
        isVertical = false;

  // Predefined spacing widgets
  const DSSpacing.none({super.key})
      : size = SpacingSize.none,
        isVertical = true;

  const DSSpacing.xsmall({super.key})
      : size = SpacingSize.xsmall,
        isVertical = true;

  const DSSpacing.small({super.key})
      : size = SpacingSize.small,
        isVertical = true;

  const DSSpacing.medium({super.key})
      : size = SpacingSize.medium,
        isVertical = true;

  const DSSpacing.large({super.key})
      : size = SpacingSize.large,
        isVertical = true;

  const DSSpacing.xlarge({super.key})
      : size = SpacingSize.xlarge,
        isVertical = true;

  const DSSpacing.xxlarge({super.key})
      : size = SpacingSize.xxlarge,
        isVertical = true;

  @override
  Widget build(BuildContext context) {
    final spacing = DesignSystemUtils.getSpacing(size);
    
    return SizedBox(
      width: isVertical ? null : spacing,
      height: isVertical ? spacing : null,
    );
  }
}

// Responsive Spacing Widget
class DSResponsiveSpacing extends StatelessWidget {
  final bool isVertical;

  const DSResponsiveSpacing({
    super.key,
    this.isVertical = true,
  });

  const DSResponsiveSpacing.vertical({super.key}) : isVertical = true;
  const DSResponsiveSpacing.horizontal({super.key}) : isVertical = false;

  @override
  Widget build(BuildContext context) {
    final spacing = context.responsivePadding;
    
    return SizedBox(
      width: isVertical ? null : spacing,
      height: isVertical ? spacing : null,
    );
  }
}

// Divider Widgets
class DSDivider extends StatelessWidget {
  final Color? color;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final bool isVertical;

  const DSDivider({
    super.key,
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
    this.isVertical = false,
  });

  const DSDivider.vertical({
    super.key,
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
  }) : isVertical = true;

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return VerticalDivider(
        color: color ?? context.colorScheme.outline.withOpacity(0.2),
        thickness: thickness ?? 1.0,
        indent: indent,
        endIndent: endIndent,
      );
    }

    return Divider(
      color: color ?? context.colorScheme.outline.withOpacity(0.2),
      thickness: thickness ?? 1.0,
      indent: indent,
      endIndent: endIndent,
    );
  }
}

// Layout Widgets
class DSContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? shadow;
  final double? width;
  final double? height;

  const DSContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.shadow,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius != null 
            ? BorderRadius.circular(borderRadius!)
            : null,
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: borderWidth ?? 1.0,
              )
            : null,
        boxShadow: shadow,
      ),
      child: child,
    );
  }
}

// Responsive Container
class DSResponsiveContainer extends StatelessWidget {
  final Widget child;
  final bool addPadding;
  final bool addMargin;
  final Color? backgroundColor;

  const DSResponsiveContainer({
    super.key,
    required this.child,
    this.addPadding = true,
    this.addMargin = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: addPadding ? context.contentPadding : null,
      margin: addMargin 
          ? EdgeInsets.all(context.responsiveMargin)
          : null,
      color: backgroundColor,
      child: child,
    );
  }
}

// Safe Area Container
class DSSafeArea extends StatelessWidget {
  final Widget child;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final Color? backgroundColor;

  const DSSafeArea({
    super.key,
    required this.child,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: child,
      ),
    );
  }
}

// Flexible Spacer
class DSFlexSpacer extends StatelessWidget {
  final int flex;

  const DSFlexSpacer({
    super.key,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Container(),
    );
  }
}

// Expanded Spacer
class DSExpandedSpacer extends StatelessWidget {
  final int flex;

  const DSExpandedSpacer({
    super.key,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(),
    );
  }
}