import 'package:flutter/material.dart';
import 'package:handyph_app/shared/widgets/skeleton_loader.dart';

/// Skeleton loading placeholder for the Worker Dashboard.
///
/// Mimics the job dashboard layout:
///   - Section headers
///   - Request cards (avatar + lines + buttons)
///   - Active job card with timeline
class WorkerDashboardSkeletonScreen extends StatelessWidget {
  const WorkerDashboardSkeletonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoader(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title skeleton ──────────────────────────
            const SkeletonBox(width: 180, height: 22),
            const SizedBox(height: 8),
            const SkeletonBox(width: 260, height: 12),
            const SizedBox(height: 24),

            // ── Section header ──────────────────────────
            Row(
              children: const [
                SkeletonBox(width: 22, height: 22, borderRadius: 6),
                SizedBox(width: 8),
                SkeletonBox(width: 140, height: 16),
                SizedBox(width: 10),
                SkeletonBox(width: 50, height: 22, borderRadius: 11),
              ],
            ),
            const SizedBox(height: 16),

            // ── Request cards (x2) ──────────────────────
            _buildRequestCardSkeleton(),
            const SizedBox(height: 14),
            _buildRequestCardSkeleton(),
            const SizedBox(height: 24),

            // ── Active job section header ───────────────
            Row(
              children: const [
                SkeletonBox(width: 22, height: 22, borderRadius: 6),
                SizedBox(width: 8),
                SkeletonBox(width: 100, height: 16),
              ],
            ),
            const SizedBox(height: 16),

            // ── Active job card ─────────────────────────
            _buildActiveJobSkeleton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCardSkeleton() {
    return SkeletonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              SkeletonCircle(size: 44),
              SizedBox(width: 12),
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
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              SkeletonBox(width: 70, height: 22, borderRadius: 8),
              SizedBox(width: 10),
              SkeletonBox(width: 140, height: 14),
            ],
          ),
          const SizedBox(height: 10),
          const SkeletonBox(width: double.infinity, height: 10),
          const SizedBox(height: 6),
          const SkeletonBox(width: 200, height: 10),
          const SizedBox(height: 14),
          const SkeletonBox(width: double.infinity, height: 40, borderRadius: 20),
          const SizedBox(height: 8),
          const SkeletonBox(width: double.infinity, height: 40, borderRadius: 20),
        ],
      ),
    );
  }

  Widget _buildActiveJobSkeleton() {
    return SkeletonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              SkeletonBox(width: 140, height: 10),
              Spacer(),
              SkeletonBox(width: 70, height: 24, borderRadius: 12),
            ],
          ),
          const SizedBox(height: 12),
          const SkeletonBox(width: 200, height: 18),
          const SizedBox(height: 16),
          // Client row
          SkeletonCard(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: const [
                SkeletonCircle(size: 36),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonBox(width: 100, height: 12),
                      SizedBox(height: 4),
                      SkeletonBox(width: 140, height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Timeline steps
          ...List.generate(3, (i) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: const [
                SkeletonCircle(size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonBox(width: 120, height: 12),
                      SizedBox(height: 4),
                      SkeletonBox(width: 100, height: 10),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
