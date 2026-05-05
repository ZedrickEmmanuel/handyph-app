import 'package:flutter/material.dart';
import 'package:handyph_app/shared/widgets/placeholder_screen.dart';
import 'package:handyph_app/core/theme/app_colors.dart';

/// Jobs — My Jobs Screen (Placeholder)
class MyJobsScreen extends StatelessWidget {
  const MyJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'My Jobs',
      icon: Icons.work_rounded,
      accentColor: AppColors.secondary,
    );
  }
}
