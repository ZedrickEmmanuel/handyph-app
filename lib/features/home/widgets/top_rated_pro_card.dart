import 'package:flutter/material.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/core/theme/app_button_styles.dart';

/// Top Rated Pro card displayed in a horizontal scroll on the Home Dashboard.
///
/// Shows worker avatar, name, title, rating, reviews, and a Book Now button.
class TopRatedProCard extends StatelessWidget {
  final String name;
  final String title;
  final double rating;
  final int reviews;
  final bool isVerified;
  final VoidCallback? onBookNow;
  final VoidCallback? onTap;

  const TopRatedProCard({
    super.key,
    required this.name,
    required this.title,
    required this.rating,
    required this.reviews,
    this.isVerified = false,
    this.onBookNow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar + Name row
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.primarySurface,
                  child: const Icon(
                    Icons.person_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),

                // Name + Title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              style: AppTypography.titleSmall.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isVerified) ...[
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.all(1),
                              decoration: const BoxDecoration(
                                color: AppColors.secondary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        title,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Rating
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFFFC107),
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  '$rating',
                  style: AppTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '($reviews reviews)',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Book Now button
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: AppButtonStyles.primary.copyWith(
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: onBookNow,
                child: Text(
                  'Book Now',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
