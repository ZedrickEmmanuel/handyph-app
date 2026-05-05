import 'package:flutter/material.dart';
import 'package:handyph_app/shared/widgets/placeholder_screen.dart';
import 'package:handyph_app/core/theme/app_colors.dart';

/// Home — Home Screen (Placeholder)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Home',
      icon: Icons.home_rounded,
      accentColor: AppColors.primary,
    );
  }
}
