import 'package:flutter/material.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';

/// Worker card displayed in the discovery list.
///
/// Shows avatar, name, specialty badge, verified status,
/// rating, success rate, base rate, and favorite toggle.
class WorkerCard extends StatelessWidget {
  final String name;
  final String specialty;
  final bool isVerified;
  final double rating;
  final int reviews;
  final int successRate;
  final int baseRate;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const WorkerCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.isVerified,
    required this.rating,
    required this.reviews,
    required this.successRate,
    required this.baseRate,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteTap,
  });

  Color get _specialtyColor {
    switch (specialty.toLowerCase()) {
      case 'plumber':
        return AppColors.primary;
      case 'cleaner':
        return AppColors.secondary;
      case 'electrician':
        return AppColors.tertiary;
      case 'painter':
        return const Color(0xFF6B4EAA);
      case 'carpenter':
        return const Color(0xFF8B6914);
      default:
        return AppColors.primary;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Row: Avatar + Info + Favorite ────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.primarySurface,
                  child: Icon(
                    Icons.person_rounded,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 14),

                // Name + Specialty + Verified
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        name,
                        style: AppTypography.titleSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Specialty badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _specialtyColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          specialty,
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Verified badge
                      if (isVerified)
                        Row(
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Verified Identity',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                // Favorite icon
                GestureDetector(
                  onTap: onFavoriteTap,
                  child: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isFavorite ? Colors.red : AppColors.neutralLight,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // ── Rating + Success Rate ───────────────────
            Row(
              children: [
                // Star + Rating
                Icon(
                  Icons.star_rounded,
                  color: const Color(0xFFFFC107),
                  size: 18,
                ),
                const SizedBox(width: 3),
                Text(
                  '$rating',
                  style: AppTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  '($reviews)',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '•',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(width: 8),

                // Success Rate
                Text(
                  'Success Rate:\n$successRate%',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ── Base Rate ───────────────────────────────
            Text(
              'Base Rate: ₱$baseRate',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
