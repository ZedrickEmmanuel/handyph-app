import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/core/theme/app_button_styles.dart';

/// Auth — Homeowner Registration Screen
///
/// Ref: HomeOwnerRegistration.png
class HomeownerRegistrationScreen extends StatelessWidget {
  const HomeownerRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'HandyPH',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded, color: AppColors.textTertiary),
            onPressed: () {},
          ),
        ],
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // ── Registration Card ──────────────────────────
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Homeowner\nAccount',
                      style: AppTypography.headlineSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tell us about yourself to start booking local pros.',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Full Name
                    _buildLabel('Full Name'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      hint: 'Juan Dela Cruz',
                      icon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(height: 20),

                    // Mobile Number
                    _buildLabel('Mobile Number'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      hint: '09XX XXX XXXX',
                      icon: Icons.phone_android_rounded,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),

                    // Service Address
                    _buildLabel('Service Address'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            hint: 'City',
                            icon: Icons.location_city_rounded,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            hint: 'Barangay',
                            icon: Icons.map_rounded,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      hint: 'House No. / Street / Village',
                      icon: Icons.home_outlined,
                    ),
                    const SizedBox(height: 32),

                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: AppButtonStyles.primary.copyWith(
                          backgroundColor: WidgetStateProperty.all(AppColors.primary),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Navigate to home after registration
                          context.go('/home');
                        },
                        child: Text(
                          'Create Account',
                          style: AppTypography.titleSmall.copyWith(
                            color: AppColors.textOnPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Footer Link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.go('/login'),
                            child: Text(
                              'Back to Login',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Legal Disclaimer
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(text: 'By clicking "Create Account", you agree to our '),
                            TextSpan(
                              text: 'Terms of Service',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: AppTypography.labelLarge.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.neutralLight),
        prefixIcon: Icon(icon, size: 22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        fillColor: AppColors.surface,
        filled: true,
      ),
    );
  }
}
