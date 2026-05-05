import 'package:flutter/material.dart';
import 'package:handyph_app/shared/widgets/placeholder_screen.dart';
import 'package:handyph_app/core/theme/app_colors.dart';

/// Discovery — Worker Profile Screen (Placeholder)
class WorkerProfileScreen extends StatelessWidget {
  const WorkerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Worker Profile',
      icon: Icons.person_rounded,
      accentColor: AppColors.secondary,
    );
  }
}
