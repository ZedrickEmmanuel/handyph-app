import 'package:flutter/material.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';

/// Service category item displayed in a horizontal row on the Home Dashboard.
///
/// Shows a circular icon with a label underneath.
class CategoryItem extends StatelessWidget {
  final String name;
  final String iconType;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.name,
    required this.iconType,
    this.onTap,
  });

  IconData get _icon {
    switch (iconType) {
      case 'plumbing':
        return Icons.plumbing_rounded;
      case 'electrical':
        return Icons.electrical_services_rounded;
      case 'painting':
        return Icons.format_paint_rounded;
      case 'carpentry':
        return Icons.carpenter_rounded;
      default:
        return Icons.build_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.divider, width: 1),
            ),
            child: Icon(
              _icon,
              color: AppColors.primary,
              size: 26,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
