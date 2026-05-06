import 'package:flutter/material.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';

/// Upcoming Job card shown on the Home Dashboard.
///
/// Displays a scheduled job with category icon, title, date, and worker name.
class UpcomingJobCard extends StatelessWidget {
  final String title;
  final String date;
  final String workerName;
  final String category;
  final VoidCallback? onTap;

  const UpcomingJobCard({
    super.key,
    required this.title,
    required this.date,
    required this.workerName,
    required this.category,
    this.onTap,
  });

  IconData get _categoryIcon {
    switch (category) {
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
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
        child: Row(
          children: [
            // Category icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _categoryIcon,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),

            // Job details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        size: 14,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        workerName,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Chevron
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
