import 'package:flutter/material.dart';
import 'package:handyph_app/shared/widgets/skeleton_loader.dart';

/// Skeleton loading placeholder for the Discovery Screen.
///
/// Mimics the layout with shimmer placeholders for:
///   - Search bar
///   - Filter chips
///   - Worker cards grid
class DiscoverySkeletonScreen extends StatelessWidget {
  const DiscoverySkeletonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoader(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Search bar skeleton ──────────────────────
            const SkeletonBox(width: double.infinity, height: 48, borderRadius: 24),
            const SizedBox(height: 16),

            // ── Filter chips ────────────────────────────
            Row(
              children: const [
                SkeletonBox(width: 70, height: 32, borderRadius: 16),
                SizedBox(width: 8),
                SkeletonBox(width: 80, height: 32, borderRadius: 16),
                SizedBox(width: 8),
                SkeletonBox(width: 90, height: 32, borderRadius: 16),
                SizedBox(width: 8),
                SkeletonBox(width: 60, height: 32, borderRadius: 16),
              ],
            ),
            const SizedBox(height: 20),

            // ── Section label ───────────────────────────
            const SkeletonBox(width: 120, height: 14),
            const SizedBox(height: 14),

            // ── Worker cards (x3) ───────────────────────
            _buildWorkerCardSkeleton(),
            const SizedBox(height: 14),
            _buildWorkerCardSkeleton(),
            const SizedBox(height: 14),
            _buildWorkerCardSkeleton(),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkerCardSkeleton() {
    return SkeletonCard(
      child: Row(
        children: [
          const SkeletonBox(width: 70, height: 70, borderRadius: 12),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonBox(width: 130, height: 14),
                SizedBox(height: 6),
                SkeletonBox(width: 100, height: 10),
                SizedBox(height: 6),
                SkeletonBox(width: 80, height: 10),
                SizedBox(height: 10),
                Row(
                  children: [
                    SkeletonBox(width: 50, height: 20, borderRadius: 10),
                    Spacer(),
                    SkeletonBox(width: 80, height: 32, borderRadius: 14),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
