import 'package:flutter/material.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';

/// Placeholder screen used during Phase 1 navigation setup.
/// Will be replaced with real UI in Phase 2.
class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? accentColor;

  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.icon,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: color),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: AppTypography.headlineSmall.copyWith(color: color),
            ),
            const SizedBox(height: 8),
            Text(
              'Screen coming in Phase 2',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
