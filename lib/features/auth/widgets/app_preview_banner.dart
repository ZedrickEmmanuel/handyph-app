import 'package:flutter/material.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';

/// App preview banner shown at the bottom of the Role Selection screen.
///
/// Displays three overlapping phone mockups with a "Trusted by 10k+ users" badge.
class AppPreviewBanner extends StatelessWidget {
  const AppPreviewBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.surfaceVariant.withValues(alpha: 0.5),
            AppColors.surfaceVariant,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phone mockups (keep centered)
          Center(
            child: SizedBox(
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Left phone (tilted)
                  Positioned(
                    left: 20,
                    top: 10,
                    child: Transform.rotate(
                      angle: -0.12,
                      child: _PhoneMockup(
                        color: AppColors.surface,
                        child: _HomeScreenPreview(),
                      ),
                    ),
                  ),
                  // Right phone (tilted)
                  Positioned(
                    right: 20,
                    top: 10,
                    child: Transform.rotate(
                      angle: 0.12,
                      child: _PhoneMockup(
                        color: AppColors.neutralDark,
                        child: _DarkScreenPreview(),
                      ),
                    ),
                  ),
                  // Center phone (front)
                  Positioned(
                    top: 0,
                    child: _PhoneMockup(
                      color: AppColors.surface,
                      child: _SearchScreenPreview(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Trust badge (Bottom Left)
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Trusted by 10k+ users',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// Simplified phone mockup container.
class _PhoneMockup extends StatelessWidget {
  final Color color;
  final Widget child;

  const _PhoneMockup({required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.neutralLight.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: child,
      ),
    );
  }
}

/// Simulated home screen preview inside mockup.
class _HomeScreenPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status bar placeholder
        Container(
          height: 6,
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Title placeholder
        Container(
          height: 5,
          width: 50,
          decoration: BoxDecoration(
            color: AppColors.textPrimary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 4),
        // Search bar placeholder
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 6),
        // Cards placeholder
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primarySurface.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Bottom bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            3,
            (_) => Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.neutralLight.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Simulated search screen preview inside mockup.
class _SearchScreenPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 6,
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Search title
        Container(
          height: 5,
          width: 55,
          decoration: BoxDecoration(
            color: AppColors.textPrimary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 6),
        // List items
        ...List.generate(4, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 4,
                        width: 45,
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        height: 3,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary.withValues(alpha: 0.07),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

/// Simulated dark screen preview inside mockup.
class _DarkScreenPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutralDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 6,
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 6),
          // Content blocks
          ...List.generate(3, (_) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
