import 'package:flutter/material.dart';

/// =======================================================
/// MATERIAL 3 LIGHT PALETTES
/// Full Tonal System (50 → 900)
/// =======================================================

class AppLightColors {
  AppLightColors._();

  // =======================================================
  // PRIMARY (Orange)
  // =======================================================

  static const Color primary = Color(0xFFFF7729);

  static const MaterialColor primaryPalette = MaterialColor(0xFFFF7729, {
    50: Color(0xFFFFF0E7),
    100: Color(0xFFFFE3D1),
    200: Color(0xFFFFD0A8),
    300: Color(0xFFFFB77F),
    400: Color(0xFFFF9E56),
    500: Color(0xFFFF7729),
    600: Color(0xFFE66A24),
    700: Color(0xFFCC5D1F),
    800: Color(0xFFB3501A),
    900: Color(0xFF994315),
  });

  // =======================================================
  // SECONDARY (Blue Gray)
  // =======================================================

  static const Color secondary = Color(0xFF637381);

  static const MaterialColor secondaryPalette = MaterialColor(0xFF637381, {
    50: Color(0xFFF8FAFC),
    100: Color(0xFFF1F5F9),
    200: Color(0xFFE2E8F0),
    300: Color(0xFFCBD5E1),
    400: Color(0xFF94A3B8),
    500: Color(0xFF637381),
    600: Color(0xFF535862),
    700: Color(0xFF414651),
    800: Color(0xFF334155),
    900: Color(0xFF1E293B),
  });

  // =======================================================
  // TERTIARY (Gold)
  // =======================================================

  static const Color tertiary = Color(0xFFA67931);

  static const MaterialColor tertiaryPalette = MaterialColor(0xFFA67931, {
    50: Color(0xFFFAF8F5),
    100: Color(0xFFF2ECE1),
    200: Color(0xFFEBDDCC),
    300: Color(0xFFE1C5A1),
    400: Color(0xFFD6B17D),
    500: Color(0xFFC89D58),
    600: Color(0xFFA67931),
    700: Color(0xFF805B20),
    800: Color(0xFF593B0B),
    900: Color(0xFF402A04),
  });

  // =======================================================
  // ERROR
  // =======================================================

  static const Color error = Color(0xFFFF5630);

  static const MaterialColor errorPalette = MaterialColor(0xFFFF5630, {
    50: Color(0xFFFFEDE8),
    100: Color(0xFFFFD1C7),
    200: Color(0xFFFFB3A6),
    300: Color(0xFFFF9485),
    400: Color(0xFFFF7A64),
    500: Color(0xFFFF5630),
    600: Color(0xFFE64D2B),
    700: Color(0xFFCC4426),
    800: Color(0xFFB33B21),
    900: Color(0xFF99321C),
  });

  // =======================================================
  // SUCCESS
  // =======================================================

  static const Color success = Color(0xFF00CA5A);

  static const MaterialColor successPalette = MaterialColor(0xFF00CA5A, {
    50: Color(0xFFE6F9F0),
    100: Color(0xFFCCF3E1),
    200: Color(0xFF99E7C3),
    300: Color(0xFF66DBA5),
    400: Color(0xFF33CF87),
    500: Color(0xFF00CA5A),
    600: Color(0xFF00B550),
    700: Color(0xFF00A046),
    800: Color(0xFF008B3C),
    900: Color(0xFF007632),
  });

  // =======================================================
  // NEUTRAL
  // =======================================================

  static const MaterialColor neutralPalette = MaterialColor(0xFF637381, {
    50: Color(0xFFFBFBFB),
    100: Color(0xFFF9FAFB),
    200: Color(0xFFE7E7E7),
    300: Color(0xFFE2E8F0),
    400: Color(0xFF919EAB),
    500: Color(0xFF808A94),
    600: Color(0xFF637381),
    700: Color(0xFF535862),
    800: Color(0xFF414651),
    900: Color(0xFF334155),
  });

  // =======================================================
  // SURFACE / BACKGROUND
  // =======================================================

  static const Color background = Color(0xFFF7F7F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F4F6);

  // =======================================================
  // TEXT
  // =======================================================

  static const Color textPrimary = Color(0xFF181D27);
  static const Color textSecondary = Color(0xFF637381);
  static const Color textDisabled = Color(0xFF919EAB);

  // =======================================================
  // BORDER
  // =======================================================

  static const Color border = Color(0xFFE5E7EB);

  // =======================================================
  // PURE COLORS
  // =======================================================

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // =======================================================
  // BASE SURFACE WHITES
  // =======================================================

  static const MaterialColor whitePalette = MaterialColor(0xFFFFFFFF, {
    50: Color(0xFFFFFFFF), // Pure White
    100: Color(0xFFFCFCFC), // Almost White
    200: Color(0xFFF9F9F9), // Soft White
    300: Color(0xFFF5F5F5), // Light Gray White
    400: Color(0xFFF0F0F0), // Muted White
    500: Color(0xFFEDEDED), // Divider White
    600: Color(0xFFE5E5E5), // Border White
    700: Color(0xFFDCDCDC), // Soft Border
    800: Color(0xFFD0D0D0), // Darker Surface
    900: Color(0xFFC4C4C4), // Deep Neutral
  });
}
