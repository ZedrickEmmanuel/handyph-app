import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handyph_app/routes/app_routes.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/features/review/data/mock_review_data.dart';

/// Review — Rate Your Service Screen
///
/// Allows the homeowner to:
///   - View completed job worker info
///   - Tap interactive star rating (1-5)
///   - Write a text review
///   - Submit the review
class ReviewServiceScreen extends StatefulWidget {
  const ReviewServiceScreen({super.key});

  @override
  State<ReviewServiceScreen> createState() => _ReviewServiceScreenState();
}

class _ReviewServiceScreenState extends State<ReviewServiceScreen> {
  int _rating = 4; // Default to 4 stars as shown in design
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final job = MockReviewData.completedJob;

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
            // Profile avatar
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primarySurface,
              child: const Icon(Icons.person_rounded,
                  color: AppColors.primary, size: 18),
            ),
            const SizedBox(width: 10),
            // HandyPH logo
            Image.asset(
              'assets/logo/handyPH_logo.png',
              height: 20,
              fit: BoxFit.contain,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: 4),
        ],
      ),

      // ── Body ─────────────────────────────────────────────
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          children: [
            // ── Heading ──────────────────────────────────────
            Text(
              'Rate Your Service',
              style: AppTypography.headlineSmall.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 24,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Your feedback helps us maintain quality.',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // ── Worker Card ──────────────────────────────────
            _buildWorkerCard(job),
            const SizedBox(height: 32),

            // ── Star Rating ──────────────────────────────────
            _buildStarRating(),
            const SizedBox(height: 12),

            // ── Rating Label ─────────────────────────────────
            Text(
              MockReviewData.ratingLabels[_rating] ?? '',
              style: AppTypography.titleSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 32),

            // ── Review Text Area ─────────────────────────────
            _buildReviewField(),
            const SizedBox(height: 32),

            // ── Submit Button ────────────────────────────────
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // WORKER CARD
  // ════════════════════════════════════════════════════════════
  Widget _buildWorkerCard(Map<String, dynamic> job) {
    return Container(
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
            radius: 26,
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
                    Text(
                      job['workerName'] as String,
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    if (job['isVerified'] as bool) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.secondarySurface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                AppColors.secondary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.verified_user_outlined,
                                size: 11, color: AppColors.secondary),
                            const SizedBox(width: 3),
                            Text(
                              'Verified',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),

                // Specialty
                Text(
                  job['workerSpecialty'] as String,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),

                // Date
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 13, color: AppColors.textTertiary),
                    const SizedBox(width: 5),
                    Text(
                      job['serviceDate'] as String,
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
    );
  }

  // ════════════════════════════════════════════════════════════
  // STAR RATING — 5 tappable stars
  // ════════════════════════════════════════════════════════════
  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isFilled = starIndex <= _rating;

        return GestureDetector(
          onTap: () => setState(() => _rating = starIndex),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(
              isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
              color: isFilled
                  ? const Color(0xFFFFC107)
                  : AppColors.divider,
              size: 44,
            ),
          ),
        );
      }),
    );
  }

  // ════════════════════════════════════════════════════════════
  // REVIEW TEXT AREA
  // ════════════════════════════════════════════════════════════
  Widget _buildReviewField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tell us about your experience',
          style: AppTypography.titleSmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.divider, width: 1),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: const InputDecorationTheme(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                outlineBorder: BorderSide.none,
              ),
            ),
            child: TextField(
              controller: _reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'What went well? What could be improved?',
                hintStyle: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // SUBMIT BUTTON
  // ════════════════════════════════════════════════════════════
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        onPressed: () {
          // Phase 3 — submit review to Firestore
          context.go(AppRoutes.myJobs);
        },
        child: Text(
          'Submit Review',
          style: AppTypography.titleSmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
