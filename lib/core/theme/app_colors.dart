import 'package:flutter/material.dart';

/// HandyPH Design System — Color Palette
///
/// Extracted from the Figma design system:
///   Primary:   #1A56A0  (Deep Blue)
///   Secondary: #0F6E56  (Emerald Green)
///   Tertiary:  #8A4300  (Amber Brown)
///   Neutral:   #75777D  (Gray)
class AppColors {
  AppColors._();

  // ── Primary (Deep Blue) ──────────────────────────────────
  static const Color primary = Color(0xFF1A56A0);
  static const Color primaryLight = Color(0xFF3D7BC8);
  static const Color primaryDark = Color(0xFF0E3A6E);
  static const Color primarySurface = Color(0xFFE8F0FA);

  // ── Secondary (Emerald Green) ────────────────────────────
  static const Color secondary = Color(0xFF0F6E56);
  static const Color secondaryLight = Color(0xFF2E9B7E);
  static const Color secondaryDark = Color(0xFF084A3A);
  static const Color secondarySurface = Color(0xFFE6F5F0);

  // ── Tertiary (Amber Brown) ───────────────────────────────
  static const Color tertiary = Color(0xFF8A4300);
  static const Color tertiaryLight = Color(0xFFB5672A);
  static const Color tertiaryDark = Color(0xFF5E2E00);
  static const Color tertiarySurface = Color(0xFFFFF0E2);

  // ── Neutral (Gray) ──────────────────────────────────────
  static const Color neutral = Color(0xFF75777D);
  static const Color neutralLight = Color(0xFFB0B2B8);
  static const Color neutralDark = Color(0xFF44464B);
  static const Color neutralSurface = Color(0xFFF2F2F4);

  // ── Backgrounds & Surfaces ──────────────────────────────
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F0F2);

  // ── Text ────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1C1E);
  static const Color textSecondary = Color(0xFF44464B);
  static const Color textTertiary = Color(0xFF75777D);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);

  // ── Semantic ────────────────────────────────────────────
  static const Color success = Color(0xFF0F6E56);
  static const Color error = Color(0xFFBA1A1A);
  static const Color warning = Color(0xFF8A4300);
  static const Color info = Color(0xFF1A56A0);

  // ── Dividers & Borders ──────────────────────────────────
  static const Color divider = Color(0xFFE0E0E2);
  static const Color border = Color(0xFFD0D0D4);
}
