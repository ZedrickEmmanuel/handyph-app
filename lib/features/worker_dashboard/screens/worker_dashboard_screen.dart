import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/shared/widgets/worker_bottom_nav_bar.dart';
import 'package:handyph_app/features/worker_dashboard/data/mock_worker_dashboard_data.dart';

/// Worker Dashboard — Job Dashboard Screen
///
/// Shows the worker's:
///   - Incoming service requests (accept / decline / counter)
///   - Active jobs with progress timeline
///   - Upcoming jobs preview
class WorkerDashboardScreen extends StatelessWidget {
  const WorkerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final requests = MockWorkerDashboardData.incomingRequests;
    final activeJob = MockWorkerDashboardData.activeJob;
    final upcoming = MockWorkerDashboardData.upcomingJob;

    return Scaffold(
      backgroundColor: AppColors.background,

      // ── App Bar ──────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primarySurface,
              child: const Icon(Icons.person_rounded,
                  color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/logo/handyPH_logo.png',
              height: 20,
              fit: BoxFit.contain,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: AppColors.textPrimary),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),

      // ── Body ─────────────────────────────────────────────
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────
            Text(
              'Job Dashboard',
              style: AppTypography.headlineSmall.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 26,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Manage your incoming requests and active projects.',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),

            // ── Incoming Requests Section ────────────────────
            _buildSectionHeader(
              icon: Icons.assignment_turned_in_outlined,
              title: 'Incoming Requests',
              badgeCount: requests.length,
            ),
            const SizedBox(height: 16),

            // Request Cards
            ...requests.map((req) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildRequestCard(context, req),
                )),
            const SizedBox(height: 12),

            // ── Active Jobs Section ─────────────────────────
            _buildSectionHeader(
              icon: Icons.construction_rounded,
              title: 'Active Jobs',
            ),
            const SizedBox(height: 16),

            // Active Job Card
            _buildActiveJobCard(context, activeJob),
            const SizedBox(height: 14),

            // Upcoming Job Preview
            _buildUpcomingJobCard(context, upcoming),
          ],
        ),
      ),

      // ── Bottom Nav ────────────────────────────────────────
      bottomNavigationBar: const WorkerBottomNavBar(currentIndex: 1),
    );
  }

  // ════════════════════════════════════════════════════════════
  // SECTION HEADER — icon + title + optional badge
  // ════════════════════════════════════════════════════════════
  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    int? badgeCount,
  }) {
    return Row(
      children: [
        Icon(icon, size: 22, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        if (badgeCount != null) ...[
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$badgeCount New',
              style: AppTypography.labelSmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // REQUEST CARD
  // ════════════════════════════════════════════════════════════
  Widget _buildRequestCard(
      BuildContext context, Map<String, dynamic> request) {
    final isUrgent = request['isUrgent'] as bool;
    final categoryColor = Color(request['categoryColor'] as int);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Client Row + Urgent Badge ────────────────────
          Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  // Initials Avatar
                  CircleAvatar(
                    radius: 22,
                    backgroundColor:
                        Color(request['initialsColor'] as int),
                    child: Text(
                      request['initials'] as String,
                      style: AppTypography.labelLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request['name'] as String,
                          style: AppTypography.titleSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 13, color: AppColors.textTertiary),
                            const SizedBox(width: 3),
                            Text(
                              request['location'] as String,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Urgent badge
              if (isUrgent)
                Positioned(
                  top: -6,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE85D3A),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'URGENT',
                      style: AppTypography.labelSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Category + Title ────────────────────────────
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  request['category'] as String,
                  style: AppTypography.labelSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  request['title'] as String,
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // ── Description ────────────────────────────────
          Text(
            request['description'] as String,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),

          // ── Date + Time ────────────────────────────────
          Row(
            children: [
              Icon(Icons.calendar_today_outlined,
                  size: 13, color: AppColors.primary),
              const SizedBox(width: 5),
              Text(
                request['date'] as String,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.access_time_rounded,
                  size: 13, color: AppColors.textTertiary),
              const SizedBox(width: 5),
              Text(
                request['time'] as String,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // ── Accept Button ──────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.check_circle_outline_rounded, size: 18),
              label: Text(
                'Accept',
                style: AppTypography.titleSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // ── Decline Button ─────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                side: const BorderSide(color: AppColors.divider, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.cancel_outlined, size: 18),
              label: Text(
                'Decline',
                style: AppTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // ── Counter Link (only for urgent) ────────────
          if (isUrgent) ...[
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Counter',
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // ACTIVE JOB CARD — with timeline
  // ════════════════════════════════════════════════════════════
  Widget _buildActiveJobCard(
      BuildContext context, Map<String, dynamic> job) {
    final steps = job['steps'] as List<Map<String, dynamic>>;

    return GestureDetector(
      onTap: () => context.push('/worker-job-details'),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Status + Ongoing Badge ────────────────────
            Row(
              children: [
                Text(
                  job['status'] as String,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    fontSize: 11,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.autorenew_rounded,
                          size: 13, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        'Ongoing',
                        style: AppTypography.labelSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ── Job Title ────────────────────────────────
            Text(
              job['title'] as String,
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),

            // ── Client Info Row ──────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primarySurface,
                    child: const Icon(Icons.person_rounded,
                        color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job['clientName'] as String,
                          style: AppTypography.titleSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          job['clientAddress'] as String,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Call + Chat icons
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.phone_rounded,
                        size: 20, color: AppColors.primary),
                    constraints:
                        const BoxConstraints(minWidth: 36, minHeight: 36),
                    padding: EdgeInsets.zero,
                  ),
                  IconButton(
                    onPressed: () => context.push('/worker-chat'),
                    icon: Icon(Icons.chat_bubble_rounded,
                        size: 20, color: AppColors.primary),
                    constraints:
                        const BoxConstraints(minWidth: 36, minHeight: 36),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── Progress Timeline ───────────────────────
            ...List.generate(steps.length, (index) {
              final step = steps[index];
              final isLast = index == steps.length - 1;
              return _buildTimelineStep(
                label: step['label'] as String,
                subtitle: step['subtitle'] as String,
                status: step['status'] as String,
                isLast: isLast,
              );
            }),
            const SizedBox(height: 8),

            // ── Divider ────────────────────────────────
            const Divider(color: AppColors.divider),
            const SizedBox(height: 12),

            // ── Mark Job Complete ──────────────────────
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.check_circle_outline_rounded, size: 20),
                label: Text(
                  'Mark Job Complete',
                  style: AppTypography.titleSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // TIMELINE STEP
  // ════════════════════════════════════════════════════════════
  Widget _buildTimelineStep({
    required String label,
    required String subtitle,
    required String status,
    required bool isLast,
  }) {
    final isCompleted = status == 'completed';
    final isActive = status == 'active';
    final isPending = status == 'pending';

    Color dotColor;
    Color lineColor;
    if (isCompleted) {
      dotColor = AppColors.secondary;
      lineColor = AppColors.secondary;
    } else if (isActive) {
      dotColor = AppColors.primary;
      lineColor = AppColors.divider;
    } else {
      dotColor = AppColors.divider;
      lineColor = AppColors.divider;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot + Line
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? dotColor
                        : isPending
                            ? AppColors.divider
                            : Colors.transparent,
                    border: isActive
                        ? Border.all(color: dotColor, width: 2.5)
                        : isPending
                            ? null
                            : null,
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check_rounded,
                          size: 13, color: Colors.white)
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: lineColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Text
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight:
                          isActive ? FontWeight.w700 : FontWeight.w600,
                      color: isPending
                          ? AppColors.textTertiary
                          : isActive
                              ? AppColors.primary
                              : AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall.copyWith(
                      color: isPending
                          ? AppColors.textTertiary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // UPCOMING JOB PREVIEW CARD
  // ════════════════════════════════════════════════════════════
  Widget _buildUpcomingJobCard(BuildContext context, Map<String, dynamic> job) {
    return GestureDetector(
      onTap: () => context.push('/worker-job-details'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
        child: Row(
          children: [
            // Time avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF8B6914),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    job['initials'] as String,
                    style: AppTypography.labelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    job['time'] as String,
                    style: AppTypography.labelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),

            // Title + Location
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job['title'] as String,
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    job['location'] as String,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),

            // Chevron
            Icon(Icons.chevron_right_rounded,
                color: AppColors.textTertiary, size: 24),
          ],
        ),
      ),
    );
  }
}
