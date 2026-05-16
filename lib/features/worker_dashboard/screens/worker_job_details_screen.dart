import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handyph_app/routes/app_routes.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/features/worker_dashboard/data/mock_worker_job_details_data.dart';

/// Worker Job Details & Tracking Screen
///
/// Shows the worker a detailed view of an active job:
///   - Job info card (ID, title, status, schedule)
///   - Client info (avatar, name, address, chat)
///   - Job progress timeline (4 steps)
///   - Problem description (italic quoted)
///   - Attached photos
///   - Payment details breakdown
///   - Bottom action bar (Update Details + Mark Completed)
class WorkerJobDetailsScreen extends StatelessWidget {
  const WorkerJobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final job = MockWorkerJobDetailsData.jobDetails;
    final steps = MockWorkerJobDetailsData.progressSteps;

    return Scaffold(
      backgroundColor: AppColors.background,

      // ── App Bar ──────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Job Details',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),

      // ── Body ─────────────────────────────────────────────
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Job Info Card ──────────────────────────
                  _buildJobInfoCard(job),
                  const SizedBox(height: 14),

                  // ── Client Info Card ──────────────────────
                  _buildClientInfoCard(context, job),
                  const SizedBox(height: 14),

                  // ── Job Progress Card ─────────────────────
                  _buildProgressCard(steps),
                  const SizedBox(height: 14),

                  // ── Problem Description Card ──────────────
                  _buildProblemCard(job),
                  const SizedBox(height: 14),

                  // ── Payment Details Card ──────────────────
                  _buildPaymentCard(job),
                ],
              ),
            ),
          ),

          // ── Bottom Action Bar ───────────────────────────
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // JOB INFO CARD
  // ════════════════════════════════════════════════════════════
  Widget _buildJobInfoCard(Map<String, dynamic> job) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job ID + Status badge
          Row(
            children: [
              Text(
                'JOB ID: ${job['jobId']}',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.primary, width: 1.5),
                ),
                child: Text(
                  job['status'] as String,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Title
          Text(
            job['title'] as String,
            style: AppTypography.titleLarge.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),

          // Schedule
          Row(
            children: [
              Icon(Icons.access_time_rounded,
                  size: 15, color: AppColors.textTertiary),
              const SizedBox(width: 6),
              Text(
                job['schedule'] as String,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // CLIENT INFO CARD
  // ════════════════════════════════════════════════════════════
  Widget _buildClientInfoCard(
      BuildContext context, Map<String, dynamic> job) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primarySurface,
            child: const Icon(Icons.person_rounded,
                color: AppColors.primary, size: 26),
          ),
          const SizedBox(width: 12),

          // Name + Address
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job['clientName'] as String,
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 13, color: AppColors.textTertiary),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        job['clientAddress'] as String,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Chat button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () => context.push(AppRoutes.workerChat),
              icon: const Icon(Icons.chat_bubble_rounded,
                  size: 18, color: Colors.white),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // JOB PROGRESS CARD
  // ════════════════════════════════════════════════════════════
  Widget _buildProgressCard(List<Map<String, dynamic>> steps) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Job Progress',
            style: AppTypography.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 18),

          // Timeline steps
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
        ],
      ),
    );
  }

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
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? dotColor
                        : isPending
                            ? AppColors.divider
                            : Colors.transparent,
                    border: isActive
                        ? Border.all(color: dotColor, width: 2.5)
                        : null,
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check_rounded,
                          size: 14, color: Colors.white)
                      : isActive
                          ? Center(
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                ),
                              ),
                            )
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
              padding: EdgeInsets.only(bottom: isLast ? 0 : 22),
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
  // PROBLEM DESCRIPTION + ATTACHED PHOTOS CARD
  // ════════════════════════════════════════════════════════════
  Widget _buildProblemCard(Map<String, dynamic> job) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Problem Description',
            style: AppTypography.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),

          // Quoted description
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border(
                left: BorderSide(
                  color: AppColors.divider,
                  width: 3,
                ),
              ),
            ),
            child: Text(
              job['description'] as String,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Attached Photos header
          Text(
            'Attached Photos',
            style: AppTypography.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),

          // Photo thumbnails
          Row(
            children: [
              // Photo 1 — filled placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(color: const Color(0xFF3A3A3A)),
                      Icon(Icons.plumbing_rounded,
                          size: 32, color: Colors.white.withValues(alpha: 0.6)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Photo 2 — empty placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.divider, width: 1),
                ),
                child: Icon(Icons.broken_image_outlined,
                    size: 28, color: AppColors.textTertiary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // PAYMENT DETAILS CARD
  // ════════════════════════════════════════════════════════════
  Widget _buildPaymentCard(Map<String, dynamic> job) {
    final baseFee = job['baseServiceFee'] as double;
    final materials = job['estimatedMaterials'] as double;
    final total = job['totalAmount'] as double;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Payment Details',
            style: AppTypography.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 14),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 14),

          // Base Service Fee
          _paymentRow('Base Service Fee', '₱${baseFee.toStringAsFixed(2)}'),
          const SizedBox(height: 10),

          // Estimated Materials
          _paymentRow(
              'Estimated Materials', '₱${materials.toStringAsFixed(2)}'),
          const SizedBox(height: 14),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 14),

          // Total
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount to Collect',
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        job['paymentMethod'] as String,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '₱${total.toStringAsFixed(2)}',
                style: AppTypography.headlineSmall.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paymentRow(String label, String amount) {
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
          amount,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // BOTTOM ACTION BAR
  // ════════════════════════════════════════════════════════════
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Update Details — outlined
          Expanded(
            child: SizedBox(
              height: 48,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.edit_note_rounded, size: 20),
                label: Text(
                  'Update Details',
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Mark Completed — filled amber/green
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5C842),
                  foregroundColor: AppColors.textPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {},
                icon: Icon(Icons.check_circle_outline_rounded,
                    size: 20, color: AppColors.secondary),
                label: Text(
                  'Mark Completed',
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
