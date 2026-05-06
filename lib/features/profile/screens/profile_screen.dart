import 'package:flutter/material.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/shared/widgets/app_bottom_nav_bar.dart';

/// Profile — Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true, // Allow body to flow under the floating nav bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Profile Content coming soon'),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }
}
