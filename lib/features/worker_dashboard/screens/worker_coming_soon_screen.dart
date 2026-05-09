import 'package:flutter/material.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/shared/widgets/worker_bottom_nav_bar.dart';

/// Placeholder screen for worker tabs that haven't been built yet.
/// Shows a "Content Coming Soon" message.
class WorkerComingSoonScreen extends StatelessWidget {
  final String tabName;
  final int navIndex;

  const WorkerComingSoonScreen({
    super.key,
    required this.tabName,
    required this.navIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.construction_rounded,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Content Coming Soon',
                style: AppTypography.headlineSmall.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'The worker $tabName screen is under development. Check back soon!',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: WorkerBottomNavBar(currentIndex: navIndex),
    );
  }
}
