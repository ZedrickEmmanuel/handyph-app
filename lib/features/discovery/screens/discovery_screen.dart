import 'package:flutter/material.dart';
import 'package:handyph_app/shared/widgets/placeholder_screen.dart';
import 'package:handyph_app/core/theme/app_colors.dart';

/// Discovery — Discovery Screen (Placeholder)
class DiscoveryScreen extends StatelessWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Discovery',
      icon: Icons.search_rounded,
      accentColor: AppColors.primary,
    );
  }
}
