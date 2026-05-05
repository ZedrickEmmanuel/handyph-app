import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// HandyPH Design System — Button Styles
///
/// Four button variants from the design system:
///   Primary   — Filled blue
///   Secondary — Outlined border
///   Inverted  — Filled dark
///   Outlined  — Light outlined
class AppButtonStyles {
  AppButtonStyles._();

  // ── Primary Button (Filled Blue) ────────────────────────
  static ButtonStyle get primary => ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        textStyle: AppTypography.labelLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
      );

  // ── Secondary Button (Outlined) ─────────────────────────
  static ButtonStyle get secondary => OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTypography.labelLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        side: const BorderSide(color: AppColors.primary, width: 1.5),
      );

  // ── Inverted Button (Filled Dark) ──────────────────────
  static ButtonStyle get inverted => ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.textOnPrimary,
        textStyle: AppTypography.labelLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
      );

  // ── Outlined Button (Light border) ─────────────────────
  static ButtonStyle get outlined => OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        textStyle: AppTypography.labelLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        side: const BorderSide(color: AppColors.border, width: 1.5),
      );
}
