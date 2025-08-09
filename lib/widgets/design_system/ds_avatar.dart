import 'package:flutter/material.dart';
import '../../core/theme/design_system.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';

class DSAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final AvatarSize size;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final Widget? badge;
  final bool showBorder;
  final Color? borderColor;
  final IconData? placeholderIcon;

  const DSAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = AvatarSize.medium,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.badge,
    this.showBorder = false,
    this.borderColor,
    this.placeholderIcon,
  });

  const DSAvatar.small({
    super.key,
    this.imageUrl,
    this.name,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.badge,
    this.showBorder = false,
    this.borderColor,
    this.placeholderIcon,
  }) : size = AvatarSize.small;

  const DSAvatar.medium({
    super.key,
    this.imageUrl,
    this.name,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.badge,
    this.showBorder = false,
    this.borderColor,
    this.placeholderIcon,
  }) : size = AvatarSize.medium;

  const DSAvatar.large({
    super.key,
    this.imageUrl,
    this.name,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.badge,
    this.showBorder = false,
    this.borderColor,
    this.placeholderIcon,
  }) : size = AvatarSize.large;

  const DSAvatar.extraLarge({
    super.key,
    this.imageUrl,
    this.name,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.badge,
    this.showBorder = false,
    this.borderColor,
    this.placeholderIcon,
  }) : size = AvatarSize.extraLarge;

  @override
  Widget build(BuildContext context) {
    final avatarSize = DesignSystemUtils.getAvatarSize(size);
    
    Widget avatar = Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(
                color: borderColor ?? context.colorScheme.outline,
                width: AppDimensions.borderWidth,
              )
            : null,
      ),
      child: CircleAvatar(
        radius: avatarSize / 2,
        backgroundColor: backgroundColor ?? 
            context.colorScheme.primaryContainer,
        backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
        child: imageUrl == null ? _buildPlaceholder(context) : null,
      ),
    );

    if (onTap != null) {
      avatar = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(avatarSize / 2),
        child: avatar,
      );
    }

    if (badge != null) {
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: badge!,
          ),
        ],
      );
    }

    return avatar;
  }

  Widget _buildPlaceholder(BuildContext context) {
    if (placeholderIcon != null) {
      return Icon(
        placeholderIcon,
        color: textColor ?? context.colorScheme.onPrimaryContainer,
        size: _getIconSize(),
      );
    }

    if (name != null && name!.isNotEmpty) {
      return Text(
        _getInitials(name!),
        style: _getTextStyle(context),
      );
    }

    return Icon(
      Icons.person,
      color: textColor ?? context.colorScheme.onPrimaryContainer,
      size: _getIconSize(),
    );
  }

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty) {
      return words[0][0].toUpperCase();
    }
    return '';
  }

  TextStyle _getTextStyle(BuildContext context) {
    switch (size) {
      case AvatarSize.small:
        return AppTypography.textTheme.labelSmall!.copyWith(
          color: textColor ?? context.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
        );
      case AvatarSize.medium:
        return AppTypography.textTheme.labelMedium!.copyWith(
          color: textColor ?? context.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
        );
      case AvatarSize.large:
        return AppTypography.textTheme.titleMedium!.copyWith(
          color: textColor ?? context.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
        );
      case AvatarSize.extraLarge:
        return AppTypography.textTheme.titleLarge!.copyWith(
          color: textColor ?? context.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
        );
    }
  }

  double _getIconSize() {
    switch (size) {
      case AvatarSize.small:
        return AppDimensions.iconSmall;
      case AvatarSize.medium:
        return AppDimensions.iconMedium;
      case AvatarSize.large:
        return AppDimensions.iconLarge;
      case AvatarSize.extraLarge:
        return AppDimensions.iconXLarge;
    }
  }
}

// Avatar Badge Widget
class DSAvatarBadge extends StatelessWidget {
  final Color? color;
  final double? size;
  final Widget? child;
  final bool isOnline;

  const DSAvatarBadge({
    super.key,
    this.color,
    this.size,
    this.child,
    this.isOnline = false,
  });

  const DSAvatarBadge.online({
    super.key,
    this.size,
  }) : color = AppColors.success,
       child = null,
       isOnline = true;

  const DSAvatarBadge.offline({
    super.key,
    this.size,
  }) : color = AppColors.neutral400,
       child = null,
       isOnline = false;

  @override
  Widget build(BuildContext context) {
    final badgeSize = size ?? 12.0;
    
    return Container(
      width: badgeSize,
      height: badgeSize,
      decoration: BoxDecoration(
        color: color ?? context.colorScheme.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: context.colorScheme.surface,
          width: 2,
        ),
      ),
      child: child,
    );
  }
}

// Avatar Group Widget
class DSAvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final List<String?> names;
  final AvatarSize size;
  final int maxVisible;
  final VoidCallback? onMoreTap;
  final double overlap;

  const DSAvatarGroup({
    super.key,
    this.imageUrls = const [],
    this.names = const [],
    this.size = AvatarSize.medium,
    this.maxVisible = 3,
    this.onMoreTap,
    this.overlap = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = DesignSystemUtils.getAvatarSize(size);
    final overlapOffset = avatarSize * overlap;
    
    final totalItems = imageUrls.length;
    final visibleItems = totalItems > maxVisible ? maxVisible - 1 : totalItems;
    final remainingCount = totalItems - visibleItems;

    return SizedBox(
      width: avatarSize + (visibleItems - 1) * overlapOffset + 
             (remainingCount > 0 ? overlapOffset : 0),
      height: avatarSize,
      child: Stack(
        children: [
          // Visible avatars
          for (int i = 0; i < visibleItems; i++)
            Positioned(
              left: i * overlapOffset,
              child: DSAvatar(
                imageUrl: i < imageUrls.length ? imageUrls[i] : null,
                name: i < names.length ? names[i] : null,
                size: size,
                showBorder: true,
                borderColor: context.colorScheme.surface,
              ),
            ),
          
          // More indicator
          if (remainingCount > 0)
            Positioned(
              left: visibleItems * overlapOffset,
              child: GestureDetector(
                onTap: onMoreTap,
                child: Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceVariant,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.colorScheme.surface,
                      width: AppDimensions.borderWidth,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '+$remainingCount',
                      style: AppTypography.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}