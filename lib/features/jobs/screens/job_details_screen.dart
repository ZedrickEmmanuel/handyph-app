import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handyph_app/routes/app_routes.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/features/jobs/data/mock_job_details_data.dart';
import 'package:handyph_app/shared/widgets/app_bottom_nav_bar.dart';

/// Jobs — Job Details & Tracking Screen
///
/// Shows full details for a specific job:
///   - Status banner
///   - Worker card with chat
///   - Job progress timeline
///   - Payment summary
///   - Job information
///   - Bottom nav (My Jobs active)
class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final job = MockJobDetailsData.job;
    final steps = MockJobDetailsData.progressSteps;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,

      // ── App Bar ──────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Image.asset(
          'assets/logo/handyPH_logo.png',
          height: 22,
          fit: BoxFit.contain,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: AppColors.textPrimary),
            onPressed: () => context.push(AppRoutes.discovery),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primarySurface,
              child: const Icon(Icons.person_rounded,
                  color: AppColors.primary, size: 18),
            ),
          ),
        ],
      ),

      // ── Body ─────────────────────────────────────────────
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
        child: Column(
          children: [
            // ── Status Banner ───────────────────────────────
            _buildStatusBanner(job['status'] as String),
            const SizedBox(height: 16),

            // ── Worker Card ─────────────────────────────────
            _buildWorkerCard(context, job),
            const SizedBox(height: 14),

            // ── Job Progress Card ───────────────────────────
            _buildProgressCard(steps),
            const SizedBox(height: 14),

            // ── Payment Summary Card ────────────────────────
            _buildPaymentCard(job),
            const SizedBox(height: 14),

            // ── Job Information Card ────────────────────────
            _buildJobInfoCard(job),
            const SizedBox(height: 20),

            // ── Rate Service Button ─────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                onPressed: () => context.push(AppRoutes.reviewService),
                icon: const Icon(Icons.star_rounded, size: 20),
                label: Text(
                  'Rate this Service',
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

      // ── Bottom Navigation ────────────────────────────────
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }

  // ════════════════════════════════════════════════════════════
  // STATUS BANNER — green bar with checkmark
  // ════════════════════════════════════════════════════════════
  Widget _buildStatusBanner(String status) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFB2F5D8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 10),
          Text(
            status,
            style: AppTypography.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1B5E3B),
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // WORKER CARD — avatar, name, specialty, rating, chat button
  // ════════════════════════════════════════════════════════════
  Widget _buildWorkerCard(BuildContext context, Map<String, dynamic> job) {
    return _sectionCard(
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primarySurface,
            child: const Icon(Icons.person_rounded,
                color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Verified
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        job['workerName'] as String,
                        style: AppTypography.titleSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (job['isVerified'] as bool) ...[
                      const SizedBox(width: 6),
                      Icon(Icons.verified_rounded,
                          size: 18, color: AppColors.secondary),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  job['workerSpecialty'] as String,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_outline_rounded,
                        color: Color(0xFFFFC107), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${job['workerRating']}',
                      style: AppTypography.labelLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${job['workerReviews']} reviews)',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Chat button
          GestureDetector(
            onTap: () => context.push(AppRoutes.chat),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.chat_bubble_outline_rounded,
                  color: AppColors.primary, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // JOB PROGRESS CARD — timeline stepper
  // ════════════════════════════════════════════════════════════
  Widget _buildProgressCard(List<Map<String, dynamic>> steps) {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Job Progress',
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),

          // Timeline
          ...List.generate(steps.length, (index) {
            final step = steps[index];
            final state = step['state'] as String;
            final isLast = index == steps.length - 1;

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Timeline column (circle + line) ──────
                  SizedBox(
                    width: 32,
                    child: Column(
                      children: [
                        // Circle indicator
                        _timelineCircle(state),

                        // Connecting line
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2.5,
                              color: state == 'completed'
                                  ? AppColors.primary
                                  : AppColors.divider,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),

                  // ── Content column ───────────────────────
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step['title'] as String,
                            style: AppTypography.titleSmall.copyWith(
                              fontWeight: FontWeight.w700,
                              color: state == 'active'
                                  ? AppColors.primary
                                  : state == 'pending'
                                      ? AppColors.textTertiary
                                      : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            step['subtitle'] as String,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textTertiary,
                              fontStyle: state == 'pending'
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _timelineCircle(String state) {
    switch (state) {
      case 'completed':
        return Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded, color: Colors.white, size: 16),
        );
      case 'active':
        return Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 3),
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      default: // pending
        return Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.divider,
            shape: BoxShape.circle,
          ),
        );
    }
  }

  // ════════════════════════════════════════════════════════════
  // PAYMENT SUMMARY CARD
  // ════════════════════════════════════════════════════════════
  Widget _buildPaymentCard(Map<String, dynamic> job) {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 18),

          // Service Cost
          _paymentRow('Service Cost',
              '₱${(job['serviceCost'] as double).toStringAsFixed(2)}'),
          const SizedBox(height: 10),

          // Booking Fee
          _paymentRow('Booking Fee',
              '₱${(job['bookingFee'] as double).toStringAsFixed(2)}'),
          const SizedBox(height: 14),

          // Dotted divider
          Row(
            children: List.generate(
              50,
              (_) => Expanded(
                child: Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  color: AppColors.divider,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              Text(
                '₱${(job['totalAmount'] as double).toStringAsFixed(2)}',
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Payment method info
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.divider, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.account_balance_wallet_outlined,
                      color: AppColors.primary, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Method: ${job['paymentMethod']}',
                        style: AppTypography.labelLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job['paymentNote'] as String,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // JOB INFORMATION CARD
  // ════════════════════════════════════════════════════════════
  Widget _buildJobInfoCard(Map<String, dynamic> job) {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Job Information',
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),

          // Scheduled Date
          _infoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Scheduled Date',
            value: job['scheduledDate'] as String,
          ),
          const SizedBox(height: 20),

          // Service Address
          _infoRow(
            icon: Icons.location_on_outlined,
            label: 'Service Address',
            value: job['serviceAddress'] as String,
          ),
          const SizedBox(height: 20),

          // Job Description
          _infoRow(
            icon: Icons.menu_rounded,
            label: 'Job Description',
            value: job['jobDescription'] as String,
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.textTertiary),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // SHARED SECTION CARD WRAPPER
  // ════════════════════════════════════════════════════════════
  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
