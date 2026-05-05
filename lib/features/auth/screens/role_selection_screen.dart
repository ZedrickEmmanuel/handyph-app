import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/core/theme/app_button_styles.dart';
import 'package:handyph_app/features/auth/widgets/role_card.dart';
import 'package:handyph_app/features/auth/widgets/app_preview_banner.dart';

/// Auth — Role Selection Screen
///
/// First screen the user sees. Allows choosing between:
///   • Homeowner ("I need a service")
///   • Worker ("I offer services")
///
/// Matches the Figma design with:
///   - Two selectable role cards
///   - App preview banner with phone mockups
///   - "Trusted by 10k+ users" badge
///   - Next button + Log in link
class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  /// null = nothing selected, 'homeowner' or 'worker'
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 90,
        leading: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () {
              // In future: navigate back or exit
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Image.asset(
            'assets/logo/handyPH_logo.png',
            height: 32,
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // ── Scrollable Content ──────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: MediaQuery.of(context).padding.top + 90 + 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // ── Heading ──────────────────────────────
                  Text(
                    'How would you like to\nuse HandyPH?',
                    style: AppTypography.headlineMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Subtitle ────────────────────────────
                  Text(
                    'Choose your role to get started with the best home service professionals in the Philippines.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Homeowner Card ──────────────────────
                  RoleCard(
                    icon: Icons.home_rounded,
                    iconColor: AppColors.primary,
                    iconBackgroundColor: AppColors.primarySurface,
                    title: 'I need a service',
                    description:
                        'Find, book, and manage trusted local professionals for your home maintenance needs.',
                    isSelected: _selectedRole == 'homeowner',
                    onTap: () => setState(() => _selectedRole = 'homeowner'),
                  ),
                  const SizedBox(height: 16),

                  // ── Worker Card ─────────────────────────
                  RoleCard(
                    icon: Icons.construction_rounded,
                    iconColor: AppColors.secondary,
                    iconBackgroundColor: AppColors.secondarySurface,
                    title: 'I offer services',
                    description:
                        'Grow your business, reach new customers, and manage your service bookings effectively.',
                    isSelected: _selectedRole == 'worker',
                    onTap: () => setState(() => _selectedRole = 'worker'),
                  ),
                  const SizedBox(height: 40),

                  // ── App Preview Banner ──────────────────
                  const AppPreviewBanner(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // ── Bottom Fixed Section ────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
            decoration: BoxDecoration(
              color: AppColors.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Next button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: AppButtonStyles.primary.copyWith(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                    ),
                    onPressed: _selectedRole != null
                        ? () {
                            // Navigate to registration or login with selected role
                            if (_selectedRole == 'homeowner') {
                              context.go('/register-homeowner');
                            } else {
                              context.go('/login');
                            }
                          }
                        : null,
                    child: Text(
                      'Next',
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: Text(
                        'Log in',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
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
}
