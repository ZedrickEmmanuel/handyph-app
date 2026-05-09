import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/features/worker_registration/data/mock_worker_registration_data.dart';

/// Worker Registration — Step 1: Professional Profile
///
/// Collects the worker's basic professional information:
///   - Full Name
///   - Primary Skill (dropdown)
///   - Years of Experience
///   - Base Rate (PHP / hr)
///   - Verified badge info
///   - Next Step button
class WorkerRegistrationScreen extends StatefulWidget {
  const WorkerRegistrationScreen({super.key});

  @override
  State<WorkerRegistrationScreen> createState() =>
      _WorkerRegistrationScreenState();
}

class _WorkerRegistrationScreenState extends State<WorkerRegistrationScreen> {
  String? _selectedSkill;

  @override
  Widget build(BuildContext context) {
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
        title: Image.asset(
          'assets/logo/handyPH_logo.png',
          height: 22,
          fit: BoxFit.contain,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline_rounded,
                color: AppColors.textPrimary),
            onPressed: () {},
          ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero Banner ─────────────────────────────────
            _buildHeroBanner(),
            const SizedBox(height: 20),

            // ── Step Indicator + Heading ─────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step label
                  Text(
                    'STEP 1 OF 3',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Heading + step dots
                  Row(
                    children: [
                      Text(
                        'Professional Profile',
                        style: AppTypography.headlineSmall.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      // Step dots
                      _buildStepDots(currentStep: 1),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Form Card ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Full Name ─────────────────────────────
                    _fieldLabel('Full Name'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      icon: Icons.badge_outlined,
                      hint: 'Juan Dela Cruz',
                    ),
                    const SizedBox(height: 20),

                    // ── Primary Skill ────────────────────────
                    _fieldLabel('Primary Skill'),
                    const SizedBox(height: 8),
                    _buildDropdown(),
                    const SizedBox(height: 20),

                    // ── Years of Experience ──────────────────
                    _fieldLabel('Years of Experience'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      icon: Icons.workspace_premium_outlined,
                      hint: 'e.g. 5',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),

                    // ── Base Rate ────────────────────────────
                    _fieldLabel('Base Rate (PHP / hr)'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      icon: Icons.monetization_on_outlined,
                      hint: '500',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 22),

                    // ── Verified Info Box ────────────────────
                    _buildVerifiedInfoBox(),
                    const SizedBox(height: 22),

                    // ── Next Step Button ─────────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        onPressed: () {
                          context.push('/register-worker-verification');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next Step',
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
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Terms Footer ────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'By continuing, you agree to HandyPH\'s\nService Provider Terms and Conditions.',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // HERO BANNER — dark overlay with text
  // ════════════════════════════════════════════════════════════
  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.85),
            const Color(0xFF1A2A4A),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative overlay shapes
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(51),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Become a Pro',
                  style: AppTypography.headlineSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Join the most trusted service network in the\nPhilippines.',
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
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
  // STEP DOTS
  // ════════════════════════════════════════════════════════════
  Widget _buildStepDots({required int currentStep}) {
    return Row(
      children: List.generate(3, (index) {
        final stepNum = index + 1;
        final isActive = stepNum <= currentStep;
        return Container(
          width: isActive ? 24 : 10,
          height: 10,
          margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.divider,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }

  // ════════════════════════════════════════════════════════════
  // FIELD LABEL
  // ════════════════════════════════════════════════════════════
  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: AppTypography.titleSmall.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 13,
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // TEXT FIELD — with leading icon
  // ════════════════════════════════════════════════════════════
  Widget _buildTextField({
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
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
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: AppColors.textTertiary),
            hintText: hint,
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // DROPDOWN — Primary Skill
  // ════════════════════════════════════════════════════════════
  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
          ),
        ),
        child: DropdownButtonFormField<String>(
          initialValue: _selectedSkill,
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.textTertiary),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.build_rounded,
                size: 20, color: AppColors.textTertiary),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
          hint: Text(
            'Select your specialty',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          dropdownColor: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          items: MockWorkerRegistrationData.specialties
              .map((skill) => DropdownMenuItem(
                    value: skill,
                    child: Text(skill),
                  ))
              .toList(),
          onChanged: (value) => setState(() => _selectedSkill = value),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // VERIFIED INFO BOX
  // ════════════════════════════════════════════════════════════
  Widget _buildVerifiedInfoBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_user_rounded,
              size: 20, color: AppColors.secondary),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTypography.bodySmall.copyWith(
                  color: const Color(0xFF2E7D32),
                  height: 1.4,
                ),
                children: const [
                  TextSpan(text: 'Your profile will receive a '),
                  TextSpan(
                    text: 'Verified Professional',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: ' badge after Step 3.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
