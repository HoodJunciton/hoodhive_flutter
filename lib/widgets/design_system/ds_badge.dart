import 'package:flutter/material.dart';
import '../../core/theme/design_system.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';

class DSBadge extends StatelessWidget {
  final String text;
  final BadgeVariant variant;
  final IconData? icon;
  final Color? customColor;
  final bool isSmall;

  const DSBadge({
    super.key,
    required this.text,
    this.variant = BadgeVariant.primary,
    this.icon,
    this.customColor,
    this.isSmall = false,
  });

  const DSBadge.primary({
    super.key,
    required this.text,
    this.icon,
    this.customColor,
    this.isSmall = false,
  }) : variant = BadgeVariant.primary;

  const DSBadge.secondary({
    super.key,
    required this.text,
    this.icon,
    this.customColor,
    this.isSmall = false,
  }) : variant = BadgeVariant.secondary;

  const DSBadge.success({
    super.key,
    required this.text,
    this.icon,
    this.customColor,
    this.isSmall = false,
  }) : variant = BadgeVariant.success;

  const DSBadge.warning({
    super.key,
    required this.text,
    this.icon,
    this.customColor,
    this.isSmall = false,
  }) : variant = BadgeVariant.warning;

  const DSBadge.error({
    super.key,
    required this.text,
    this.icon,
    this.customColor,
    this.isSmall = false,
  }) : variant = BadgeVariant.error;

  const DSBadge.info({
    super.key,
    required this.text,
    this.icon,
    this.customColor,
    this.isSmall = false,
  }) : variant = BadgeVariant.info;

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall 
            ? AppDimensions.paddingSmall 
            : AppDimensions.paddingMedium,
        vertical: isSmall 
            ? AppDimensions.paddingXSmall 
            : AppDimensions.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(
          isSmall 
              ? AppDimensions.radiusSmall 
              : AppDimensions.radiusMedium,
        ),
        border: variant == BadgeVariant.secondary
            ? Border.all(
                color: colors.borderColor ?? Colors.transparent,
                width: AppDimensions.borderWidth,
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: isSmall 
                  ? AppDimensions.iconXSmall 
                  : AppDimensions.iconSmall,
              color: colors.textColor,
            ),
            SizedBox(width: AppDimensions.paddingXSmall),
          ],
          Text(
            text,
            style: (isSmall 
                ? AppTypography.textTheme.labelSmall 
                : AppTypography.textTheme.labelMedium)?.copyWith(
              color: colors.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  _BadgeColors _getColors(BuildContext context) {
    if (customColor != null) {
      return _BadgeColors(
        backgroundColor: customColor!.withOpacity(0.1),
        textColor: customColor!,
        borderColor: customColor,
      );
    }

    switch (variant) {
      case BadgeVariant.primary:
        return _BadgeColors(
          backgroundColor: context.colorScheme.primaryContainer,
          textColor: context.colorScheme.onPrimaryContainer,
        );
      case BadgeVariant.secondary:
        return _BadgeColors(
          backgroundColor: Colors.transparent,
          textColor: context.colorScheme.onSurfaceVariant,
          borderColor: context.colorScheme.outline,
        );
      case BadgeVariant.success:
        return _BadgeColors(
          backgroundColor: AppColors.success.withOpacity(0.1),
          textColor: AppColors.success,
        );
      case BadgeVariant.warning:
        return _BadgeColors(
          backgroundColor: AppColors.warning.withOpacity(0.1),
          textColor: AppColors.warning,
        );
      case BadgeVariant.error:
        return _BadgeColors(
          backgroundColor: AppColors.error.withOpacity(0.1),
          textColor: AppColors.error,
        );
      case BadgeVariant.info:
        return _BadgeColors(
          backgroundColor: AppColors.info.withOpacity(0.1),
          textColor: AppColors.info,
        );
    }
  }
}

class _BadgeColors {
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  _BadgeColors({
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });
}

// Status Badge Widget
class DSStatusBadge extends StatelessWidget {
  final String status;
  final bool isSmall;

  const DSStatusBadge({
    super.key,
    required this.status,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = AppColors.getStatusColor(status);
    IconData? icon;

    switch (status.toLowerCase()) {
      case 'pending':
        icon = Icons.schedule;
        break;
      case 'approved':
        icon = Icons.check_circle;
        break;
      case 'rejected':
        icon = Icons.cancel;
        break;
      case 'active':
        icon = Icons.check_circle;
        break;
      case 'inactive':
        icon = Icons.remove_circle;
        break;
      case 'occupied':
        icon = Icons.home;
        break;
      case 'available':
        icon = Icons.home_outlined;
        break;
      case 'maintenance':
        icon = Icons.build;
        break;
    }

    return DSBadge(
      text: status.toUpperCase(),
      customColor: statusColor,
      icon: icon,
      isSmall: isSmall,
    );
  }
}

// Role Badge Widget
class DSRoleBadge extends StatelessWidget {
  final String role;
  final bool isSmall;

  const DSRoleBadge({
    super.key,
    required this.role,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    final roleColor = AppColors.getRoleColor(role);
    IconData? icon;

    switch (role.toLowerCase()) {
      case 'admin':
        icon = Icons.admin_panel_settings;
        break;
      case 'resident':
        icon = Icons.home;
        break;
      case 'tenant':
        icon = Icons.person;
        break;
      case 'security':
        icon = Icons.security;
        break;
      case 'maintenance':
        icon = Icons.build;
        break;
    }

    return DSBadge(
      text: role.toUpperCase(),
      customColor: roleColor,
      icon: icon,
      isSmall: isSmall,
    );
  }
}

// Count Badge Widget
class DSCountBadge extends StatelessWidget {
  final int count;
  final int? maxCount;
  final Color? color;
  final bool showZero;

  const DSCountBadge({
    super.key,
    required this.count,
    this.maxCount,
    this.color,
    this.showZero = false,
  });

  @override
  Widget build(BuildContext context) {
    if (count == 0 && !showZero) {
      return const SizedBox.shrink();
    }

    String displayText;
    if (maxCount != null && count > maxCount!) {
      displayText = '$maxCount+';
    } else {
      displayText = count.toString();
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: count > 9 
            ? AppDimensions.paddingSmall 
            : AppDimensions.paddingXSmall,
        vertical: AppDimensions.paddingXSmall,
      ),
      decoration: BoxDecoration(
        color: color ?? AppColors.error,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      constraints: BoxConstraints(
        minWidth: AppDimensions.iconMedium,
        minHeight: AppDimensions.iconMedium,
      ),
      child: Center(
        child: Text(
          displayText,
          style: AppTypography.textTheme.labelSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}

// Dot Badge Widget
class DSDotBadge extends StatelessWidget {
  final Color? color;
  final double size;

  const DSDotBadge({
    super.key,
    this.color,
    this.size = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? AppColors.error,
        shape: BoxShape.circle,
      ),
    );
  }
}