import 'package:flutter/material.dart';
import 'package:handyph_app/shared/widgets/skeleton_loader.dart';

/// Skeleton loading placeholder for the Home Screen.
///
/// Mimics the layout of the actual home screen with shimmer placeholders:
///   - Search bar skeleton
///   - Category pills row
///   - Worker cards (image + text lines + button)
///   - Section header + list items
class HomeSkeletonScreen extends StatelessWidget {
  const HomeSkeletonScreen({super.key});

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
            const SizedBox(height: 20),

            // ── Section title skeleton ──────────────────
            const SkeletonBox(width: 140, height: 16),
            const SizedBox(height: 14),

            // ── Category pills row ──────────────────────
            Row(
              children: const [
                SkeletonBox(width: 64, height: 32, borderRadius: 16),
                SizedBox(width: 10),
                SkeletonBox(width: 64, height: 32, borderRadius: 16),
                SizedBox(width: 10),
                SkeletonBox(width: 64, height: 32, borderRadius: 16),
                SizedBox(width: 10),
                SkeletonBox(width: 64, height: 32, borderRadius: 16),
              ],
            ),
            const SizedBox(height: 28),

            // ── Worker cards (x2) ───────────────────────
            _buildWorkerCardSkeleton(),
            const SizedBox(height: 16),
            _buildWorkerCardSkeleton(),
            const SizedBox(height: 28),

            // ── Section title skeleton ──────────────────
            const SkeletonBox(width: 160, height: 16),
            const SizedBox(height: 14),

            // ── List items (x2) ─────────────────────────
            _buildListItemSkeleton(),
            const SizedBox(height: 12),
            _buildListItemSkeleton(),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkerCardSkeleton() {
    return SkeletonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              SkeletonBox(width: 60, height: 60, borderRadius: 12),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox(width: 120, height: 14),
                    SizedBox(height: 8),
                    SkeletonBox(width: 180, height: 10),
                    SizedBox(height: 8),
                    SkeletonBox(width: 80, height: 10),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const SkeletonBox(width: double.infinity, height: 10),
          const SizedBox(height: 8),
          const SkeletonBox(width: 200, height: 10),
          const SizedBox(height: 14),
          Row(
            children: const [
              SkeletonBox(width: 80, height: 30, borderRadius: 14),
              Spacer(),
              SkeletonBox(width: 60, height: 30, borderRadius: 14),
              SizedBox(width: 8),
              SkeletonBox(width: 80, height: 30, borderRadius: 14),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListItemSkeleton() {
    return SkeletonCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: const [
          SkeletonCircle(size: 44),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: 120, height: 14),
                SizedBox(height: 6),
                SkeletonBox(width: 160, height: 10),
              ],
            ),
          ),
          SkeletonBox(width: 60, height: 30, borderRadius: 14),
        ],
      ),
    );
  }
}
