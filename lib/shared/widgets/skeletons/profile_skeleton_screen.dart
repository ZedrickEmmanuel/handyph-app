import 'package:flutter/material.dart';
import 'package:handyph_app/shared/widgets/skeleton_loader.dart';

/// Skeleton loading placeholder for the Profile Screen.
///
/// Mimics the profile layout with shimmer placeholders:
///   - Profile avatar + name + email
///   - Stats row
///   - Menu items
class ProfileSkeletonScreen extends StatelessWidget {
  const ProfileSkeletonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoader(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
        child: Column(
          children: [
            // ── Avatar ──────────────────────────────────
            const SkeletonCircle(size: 90),
            const SizedBox(height: 16),

            // ── Name + email ────────────────────────────
            const SkeletonBox(width: 140, height: 18),
            const SizedBox(height: 8),
            const SkeletonBox(width: 180, height: 12),
            const SizedBox(height: 24),

            // ── Stats row ───────────────────────────────
            SkeletonCard(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Column(
                    children: [
                      SkeletonBox(width: 40, height: 18),
                      SizedBox(height: 6),
                      SkeletonBox(width: 60, height: 10),
                    ],
                  ),
                  Column(
                    children: [
                      SkeletonBox(width: 40, height: 18),
                      SizedBox(height: 6),
                      SkeletonBox(width: 60, height: 10),
                    ],
                  ),
                  Column(
                    children: [
                      SkeletonBox(width: 40, height: 18),
                      SizedBox(height: 6),
                      SkeletonBox(width: 60, height: 10),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Menu items (x5) ─────────────────────────
            ...List.generate(5, (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SkeletonCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: const [
                    SkeletonCircle(size: 36),
                    SizedBox(width: 14),
                    Expanded(
                      child: SkeletonBox(width: 120, height: 14),
                    ),
                    SkeletonBox(width: 20, height: 20, borderRadius: 4),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
