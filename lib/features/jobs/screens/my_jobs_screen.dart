import 'package:flutter/material.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/shared/widgets/app_bottom_nav_bar.dart';

/// Jobs — My Jobs Screen
class MyJobsScreen extends StatelessWidget {
  const MyJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true, // Allow body to flow under the floating nav bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('My Jobs'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('My Jobs Content coming soon'),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }
}
