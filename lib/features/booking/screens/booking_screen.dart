import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handyph_app/routes/app_routes.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/features/booking/data/mock_booking_data.dart';

/// Booking — Book Service Form Screen
///
/// Allows homeowners to submit a booking request with:
///   - Worker summary card
///   - Problem description text area
///   - Date & time pickers
///   - Photo upload area (optional)
///   - Service address card
///   - Submit button
class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    final worker = MockBookingData.selectedWorker;
    final address = MockBookingData.userAddress;

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
          'Book Service',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
      ),

      // ── Body ─────────────────────────────────────────────
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Worker Summary Card ─────────────────────────
            _buildWorkerCard(worker),
            const SizedBox(height: 24),

            // ── Problem Description ─────────────────────────
            _sectionLabel('Describe the problem'),
            const SizedBox(height: 10),
            _buildProblemField(),
            const SizedBox(height: 24),

            // ── Preferred Date ──────────────────────────────
            _sectionLabel('Preferred Date'),
            const SizedBox(height: 10),
            _buildDatePicker(context),
            const SizedBox(height: 24),

            // ── Preferred Time ──────────────────────────────
            _sectionLabel('Preferred Time'),
            const SizedBox(height: 10),
            _buildTimePicker(context),
            const SizedBox(height: 24),

            // ── Photo Upload ────────────────────────────────
            _sectionLabel('Add a photo of the issue (Optional)'),
            const SizedBox(height: 10),
            _buildPhotoUpload(),
            const SizedBox(height: 24),

            // ── Service Address ─────────────────────────────
            _buildAddressCard(address),
            const SizedBox(height: 32),

            // ── Submit Button ───────────────────────────────
            _buildSubmitButton(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // SECTION LABEL
  // ════════════════════════════════════════════════════════════
  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: AppTypography.titleSmall.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // WORKER SUMMARY CARD
  // ════════════════════════════════════════════════════════════
  Widget _buildWorkerCard(Map<String, dynamic> worker) {
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
            radius: 28,
            backgroundColor: AppColors.primarySurface,
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.primary,
              size: 28,
            ),
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
                      worker['name'] as String,
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (worker['isVerified'] as bool)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.secondarySurface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.secondary.withValues(alpha: 0.3),
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
                ),
                const SizedBox(height: 2),

                // Specialty
                Text(
                  worker['specialty'] as String,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),

                // Rating
                Row(
                  children: [
                    const Icon(Icons.star_outline_rounded,
                        color: Color(0xFFFFC107), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${worker['rating']}',
                      style: AppTypography.labelLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${worker['reviews']} reviews)',
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
  // PROBLEM DESCRIPTION FIELD
  // ════════════════════════════════════════════════════════════
  Widget _buildProblemField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: TextField(
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'e.g., Leaking pipe under the kitchen sink...',
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // DATE PICKER
  // ════════════════════════════════════════════════════════════
  Widget _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(days: 1)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 90)),
        );
        if (date != null) {
          setState(() => _selectedDate = date);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined,
                size: 20, color: AppColors.textTertiary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _selectedDate != null
                    ? '${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.year}'
                    : 'mm/dd/yyyy',
                style: AppTypography.bodyMedium.copyWith(
                  color: _selectedDate != null
                      ? AppColors.textPrimary
                      : AppColors.textTertiary,
                ),
              ),
            ),
            Icon(Icons.calendar_month_outlined,
                size: 20, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // TIME PICKER
  // ════════════════════════════════════════════════════════════
  Widget _buildTimePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null) {
          setState(() => _selectedTime = time);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time_rounded,
                size: 20, color: AppColors.textTertiary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _selectedTime != null
                    ? _selectedTime!.format(context)
                    : '--:-- --',
                style: AppTypography.bodyMedium.copyWith(
                  color: _selectedTime != null
                      ? AppColors.textPrimary
                      : AppColors.textTertiary,
                ),
              ),
            ),
            Icon(Icons.schedule_outlined,
                size: 20, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // PHOTO UPLOAD AREA
  // ════════════════════════════════════════════════════════════
  Widget _buildPhotoUpload() {
    return GestureDetector(
      onTap: () {
        // Phase 4 — Firebase Storage upload
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.divider,
            width: 1.5,
            // Dashed border visual approximated with a solid border
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Camera icon in a circle
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),

            // Tap to upload
            Text(
              'Tap to upload',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),

            // File info
            Text(
              'PNG, JPG up to 10MB',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // SERVICE ADDRESS CARD
  // ════════════════════════════════════════════════════════════
  Widget _buildAddressCard(Map<String, dynamic> address) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service Address',
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address['full'] as String,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // SUBMIT BUTTON
  // ════════════════════════════════════════════════════════════
  Widget _buildSubmitButton(BuildContext context) {
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
        onPressed: () => context.push(AppRoutes.bookingConfirmation),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Submit Booking Request',
              style: AppTypography.titleSmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_rounded, size: 20),
          ],
        ),
      ),
    );
  }
}
