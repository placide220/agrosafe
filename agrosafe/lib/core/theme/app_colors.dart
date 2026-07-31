import 'package:flutter/material.dart';

/// AgroSafe design tokens — the single source of truth for colour.
///
/// Screens should reference these tokens instead of hard-coding hex values,
/// so the palette stays consistent across the whole app. These values were
/// consolidated from the colours already used in the app (six near-identical
/// greens collapsed to one, a single gray ramp, one amber, one red family).
class AppColors {
  AppColors._();

  // ---- Brand: green -------------------------------------------------------
  static const Color primary = Color(0xFF1E5620); // canonical brand green
  static const Color primaryDark = Color(0xFF15401A); // pressed / emphasis
  static const Color primaryLight = Color(0xFF81C784); // light green accent
  static const Color primarySurface = Color(0xFFF3F9F3); // faint green tint bg

  // ---- Secondary: amber ---------------------------------------------------
  static const Color amber = Color(0xFFF59E0B);
  static const Color onAmber = Color(0xFF78350F); // text/icon on amber cards
  static const Color amberSurface = Color(0xFFFFFBEB);

  // ---- Status -------------------------------------------------------------
  static const Color error = Color(0xFFDC2626);
  static const Color errorDark = Color(0xFF991B1B);
  static const Color errorSurface = Color(0xFFFEE2E2);
  static const Color success = primary;
  static const Color warning = amber;

  // ---- Neutrals: text & lines (one consistent gray ramp) ------------------
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textTertiary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderStrong = Color(0xFFD1D5DB);
  static const Color surface = Colors.white;
  static const Color background = Color(0xFFF9F9F6);

  // ---- Intentional one-offs (kept distinct on purpose) --------------------
  static const Color highContrastYellow = Color(0xFFFFFF00); // a11y mode
  static const Color womenCircleAccent = Color(0xFF831843); // women's circle
}
