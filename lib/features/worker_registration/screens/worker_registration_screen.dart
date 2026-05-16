import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:handyph_app/routes/app_routes.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/features/worker_registration/data/mock_worker_registration_data.dart';
import 'package:handyph_app/providers/auth_provider.dart';

/// Worker Registration — Step 1: Account + Professional Setup
///
/// Fields (per approved architecture):
///   Full Name → Email → Password → Phone → Primary Skill →
///   Years Experience → Base Rate
///
/// On "Continue →": creates Firebase Auth account + Firestore profile,
/// then navigates to Step 2 (Verification).
class WorkerRegistrationScreen extends StatefulWidget {
  const WorkerRegistrationScreen({super.key});

  @override
  State<WorkerRegistrationScreen> createState() =>
      _WorkerRegistrationScreenState();
}

class _WorkerRegistrationScreenState extends State<WorkerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _experienceController = TextEditingController();
  final _rateController = TextEditingController();
  String? _selectedSkill;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _experienceController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedSkill == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select your primary skill'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.registerWorker(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      phone: _phoneController.text,
      primarySkill: _selectedSkill!,
      yearsExperience: int.tryParse(_experienceController.text) ?? 0,
      baseRate: int.tryParse(_rateController.text) ?? 0,
    );

    if (!mounted) return;

    if (success) {
      // Auth account + Firestore created → go to verification step
      context.push(AppRoutes.registerWorkerVerification);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.error ?? 'Registration failed'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

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
                color: AppColors.textTertiary),
            onPressed: () {},
          ),
        ],
      ),

      // ── Body ──────────────────────────────────────────────
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Hero Banner ──────────────────────────────────
              _buildHeroBanner(),
              const SizedBox(height: 24),

              // ── Form Card ────────────────────────────────────
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
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
                    // Step indicator
                    Row(
                      children: [
                        Text(
                          'Step 1 of 2',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildStepDots(currentStep: 1),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Account & Professional Setup',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // ── Full Name ─────────────────────────────
                    _fieldLabel('Full Name'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _nameController,
                      icon: Icons.badge_outlined,
                      hint: 'Juan Dela Cruz',
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Name is required' : null,
                    ),
                    const SizedBox(height: 20),

                    // ── Email ─────────────────────────────────
                    _fieldLabel('Email Address'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _emailController,
                      icon: Icons.email_outlined,
                      hint: 'juan@email.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Email is required';
                        if (!v.contains('@') || !v.contains('.')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // ── Password ──────────────────────────────
                    _fieldLabel('Password'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _passwordController,
                      icon: Icons.lock_outline_rounded,
                      hint: '••••••••',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.textTertiary,
                          size: 20,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Password is required';
                        if (v.length < 6) return 'Must be at least 6 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // ── Phone Number ─────────────────────────
                    _fieldLabel('Phone Number'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _phoneController,
                      icon: Icons.phone_android_rounded,
                      hint: '09XX XXX XXXX',
                      keyboardType: TextInputType.phone,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Phone is required' : null,
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
                      controller: _experienceController,
                      icon: Icons.workspace_premium_outlined,
                      hint: 'e.g. 5',
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 20),

                    // ── Base Rate ────────────────────────────
                    _fieldLabel('Base Rate (PHP / hr)'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _rateController,
                      icon: Icons.monetization_on_outlined,
                      hint: '500',
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 22),

                    // ── Verified Info Box ────────────────────
                    _buildVerifiedInfoBox(),
                    const SizedBox(height: 22),

                    // ── Continue Button ──────────────────────
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
                        onPressed:
                            authProvider.isLoading ? null : _handleRegister,
                        child: authProvider.isLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Continue',
                                    style: AppTypography.titleSmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward_rounded,
                                      size: 20),
                                ],
                              ),
                      ),
                    ),
                  ],
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
      children: List.generate(2, (index) {
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
  // TEXT FIELD — with leading icon and validation
  // ════════════════════════════════════════════════════════════
  Widget _buildTextField({
    TextEditingController? controller,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, size: 20, color: AppColors.textTertiary),
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textTertiary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        fillColor: AppColors.surface,
        filled: true,
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
                  TextSpan(text: ' badge after verification.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
