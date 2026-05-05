import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// HandyPH Design System — Typography
///
/// Uses the Inter font family throughout.
/// Three tiers: Headline, Body, Label (from the design system).
class AppTypography {
  AppTypography._();

  // ── Base Text Style ─────────────────────────────────────
  static TextStyle get _baseStyle => GoogleFonts.inter(
        color: AppColors.textPrimary,
      );

  // ── Headline ────────────────────────────────────────────
  static TextStyle get headlineLarge => _baseStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.25,
      );

  static TextStyle get headlineMedium => _baseStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.29,
      );

  static TextStyle get headlineSmall => _baseStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.33,
      );

  // ── Title ───────────────────────────────────────────────
  static TextStyle get titleLarge => _baseStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.27,
      );

  static TextStyle get titleMedium => _baseStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.33,
      );

  static TextStyle get titleSmall => _baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.38,
      );

  // ── Body ────────────────────────────────────────────────
  static TextStyle get bodyLarge => _baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodyMedium => _baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
      );

  static TextStyle get bodySmall => _baseStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
      );

  // ── Label ───────────────────────────────────────────────
  static TextStyle get labelLarge => _baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
      );

  static TextStyle get labelMedium => _baseStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
      );

  static TextStyle get labelSmall => _baseStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.45,
      );
}
