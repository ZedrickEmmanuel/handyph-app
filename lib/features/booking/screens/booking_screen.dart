import 'package:flutter/material.dart';
import 'package:handyph_app/shared/widgets/placeholder_screen.dart';
import 'package:handyph_app/core/theme/app_colors.dart';

/// Booking — Booking Screen (Placeholder)
class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Booking',
      icon: Icons.calendar_today_rounded,
      accentColor: AppColors.tertiary,
    );
  }
}
