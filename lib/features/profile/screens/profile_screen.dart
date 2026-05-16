import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/shared/widgets/app_bottom_nav_bar.dart';
import 'package:handyph_app/shared/widgets/skeletons/profile_skeleton_screen.dart';
import 'package:handyph_app/providers/auth_provider.dart';
import 'package:handyph_app/routes/app_routes.dart';

/// Profile — Profile Screen
///
/// Demonstrates loading → content with skeleton placeholder.
/// Full profile UI to be implemented in a future phase.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true, // Allow body to flow under the floating nav bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Profile',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _isLoading
            ? const ProfileSkeletonScreen(key: ValueKey('skeleton'))
            : SingleChildScrollView(
                key: const ValueKey('content'),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
                child: Column(
                  children: [
                    // ── Avatar ──────────────────────────────
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: AppColors.primarySurface,
                      child: const Icon(Icons.person_rounded,
                          size: 44, color: AppColors.primary),
                    ),
                    const SizedBox(height: 14),

                    // ── Name + Email ────────────────────────
                    Text(
                      context.watch<AuthProvider>().userModel?.name ?? 'User',
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.watch<AuthProvider>().userModel?.email ?? '',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Stats Row ───────────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: AppColors.divider, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStat('12', 'Jobs'),
                          Container(
                              width: 1,
                              height: 32,
                              color: AppColors.divider),
                          _buildStat('4.8', 'Rating'),
                          Container(
                              width: 1,
                              height: 32,
                              color: AppColors.divider),
                          _buildStat('3', 'Reviews'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Menu Items ──────────────────────────
                    _buildMenuItem(
                        Icons.person_outline_rounded, 'Edit Profile'),
                    _buildMenuItem(
                        Icons.location_on_outlined, 'Manage Addresses'),
                    _buildMenuItem(
                        Icons.payment_outlined, 'Payment Methods'),
                    _buildMenuItem(
                        Icons.notifications_outlined, 'Notifications'),
                    _buildMenuItem(Icons.help_outline_rounded, 'Help Center'),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        await context.read<AuthProvider>().logout();
                        if (context.mounted) {
                          context.go(AppRoutes.roleSelection);
                        }
                      },
                      child: _buildMenuItem(
                          Icons.logout_rounded, 'Sign Out',
                          isDestructive: true),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String label,
      {bool isDestructive = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isDestructive
                    ? const Color(0xFFFDE8E8)
                    : AppColors.primarySurface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon,
                  size: 20,
                  color: isDestructive
                      ? const Color(0xFFE53935)
                      : AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: AppTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDestructive
                      ? const Color(0xFFE53935)
                      : AppColors.textPrimary,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                size: 22, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
