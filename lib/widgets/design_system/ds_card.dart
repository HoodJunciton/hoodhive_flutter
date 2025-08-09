import 'package:flutter/material.dart';
import '../../core/theme/design_system.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';

class DSCard extends StatelessWidget {
  final Widget child;
  final CardVariant variant;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? elevation;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final bool isSelected;
  final bool isHoverable;
  final List<BoxShadow>? customShadow;

  const DSCard({
    super.key,
    required this.child,
    this.variant = CardVariant.elevated,
    this.onTap,
    this.padding,
    this.margin,
    this.elevation,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.isSelected = false,
    this.isHoverable = true,
    this.customShadow,
  });

  const DSCard.elevated({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.elevation,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.isSelected = false,
    this.isHoverable = true,
    this.customShadow,
  }) : variant = CardVariant.elevated;

  const DSCard.outlined({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.elevation,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.isSelected = false,
    this.isHoverable = true,
    this.customShadow,
  }) : variant = CardVariant.outlined;

  const DSCard.filled({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.elevation,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.isSelected = false,
    this.isHoverable = true,
    this.customShadow,
  }) : variant = CardVariant.filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(AppDimensions.paddingSmall),
      child: _buildCard(context),
    );
  }

  Widget _buildCard(BuildContext context) {
    final cardBorderRadius = borderRadius ?? AppDimensions.radiusLarge;
    final cardPadding = padding ?? EdgeInsets.all(AppDimensions.paddingMedium);

    switch (variant) {
      case CardVariant.elevated:
        return _buildElevatedCard(context, cardBorderRadius, cardPadding);
      case CardVariant.outlined:
        return _buildOutlinedCard(context, cardBorderRadius, cardPadding);
      case CardVariant.filled:
        return _buildFilledCard(context, cardBorderRadius, cardPadding);
    }
  }

  Widget _buildElevatedCard(
    BuildContext context,
    double cardBorderRadius,
    EdgeInsets cardPadding,
  ) {
    return Material(
      elevation: elevation ?? AppDimensions.cardElevation,
      shadowColor: customShadow != null ? null : Colors.black.withOpacity(0.1),
      color: backgroundColor ?? context.colorScheme.surface,
      borderRadius: BorderRadius.circular(cardBorderRadius),
      child: _buildCardContent(context, cardBorderRadius, cardPadding),
    );
  }

  Widget _buildOutlinedCard(
    BuildContext context,
    double cardBorderRadius,
    EdgeInsets cardPadding,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.surface,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        border: Border.all(
          color: isSelected
              ? context.colorScheme.primary
              : (borderColor ?? context.colorScheme.outline),
          width: isSelected 
              ? AppDimensions.borderWidthFocused 
              : AppDimensions.borderWidth,
        ),
        boxShadow: customShadow,
      ),
      child: _buildCardContent(context, cardBorderRadius, cardPadding),
    );
  }

  Widget _buildFilledCard(
    BuildContext context,
    double cardBorderRadius,
    EdgeInsets cardPadding,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        boxShadow: customShadow,
      ),
      child: _buildCardContent(context, cardBorderRadius, cardPadding),
    );
  }

  Widget _buildCardContent(
    BuildContext context,
    double cardBorderRadius,
    EdgeInsets cardPadding,
  ) {
    Widget content = Padding(
      padding: cardPadding,
      child: child,
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        hoverColor: isHoverable 
            ? context.colorScheme.primary.withOpacity(0.04)
            : null,
        splashColor: context.colorScheme.primary.withOpacity(0.12),
        highlightColor: context.colorScheme.primary.withOpacity(0.08),
        child: content,
      );
    }

    return content;
  }
}

// Specialized Card Variants
class DSInfoCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  const DSInfoCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DSCard(
      onTap: onTap,
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingSmall),
              decoration: BoxDecoration(
                color: (iconColor ?? context.colorScheme.primary).withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              ),
              child: Icon(
                icon,
                color: iconColor ?? context.colorScheme.primary,
                size: AppDimensions.iconMedium,
              ),
            ),
            SizedBox(width: AppDimensions.paddingMedium),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: AppDimensions.paddingXSmall),
                  Text(
                    subtitle!,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: AppDimensions.paddingMedium),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class DSStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;
  final Widget? trend;

  const DSStatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.color,
    this.onTap,
    this.trend,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? context.colorScheme.primary;

    return DSCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              if (icon != null)
                Container(
                  padding: EdgeInsets.all(AppDimensions.paddingXSmall),
                  decoration: BoxDecoration(
                    color: cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                  ),
                  child: Icon(
                    icon,
                    color: cardColor,
                    size: AppDimensions.iconSmall,
                  ),
                ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingSmall),
          Text(
            value,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: cardColor,
            ),
          ),
          if (subtitle != null || trend != null) ...[
            SizedBox(height: AppDimensions.paddingXSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (subtitle != null)
                  Expanded(
                    child: Text(
                      subtitle!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                if (trend != null) trend!,
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class DSActionCard extends StatelessWidget {
  final String title;
  final String? description;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  const DSActionCard({
    super.key,
    required this.title,
    this.description,
    required this.icon,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? context.colorScheme.primary;

    return DSCard(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(AppDimensions.paddingMedium),
            decoration: BoxDecoration(
              color: cardColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: Icon(
              icon,
              color: cardColor,
              size: AppDimensions.iconLarge,
            ),
          ),
          SizedBox(height: AppDimensions.paddingMedium),
          Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          if (description != null) ...[
            SizedBox(height: AppDimensions.paddingXSmall),
            Text(
              description!,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}