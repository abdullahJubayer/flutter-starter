import 'package:flutter/material.dart';

/// =======================================================
/// MATERIAL 3 LIGHT PALETTES
/// Full Tonal System (50 → 900)
/// =======================================================

class AppLightColors {
  AppLightColors._();

  // =======================================================
  // PRIMARY (WhatsApp Green)
  // =======================================================

  static const Color primary = Color(0xFF25D366);

  static const MaterialColor primaryPalette = MaterialColor(0xFF25D366, {
    50: Color(0xFFE7F9EF),
    100: Color(0xFFC3F1D7),
    200: Color(0xFF9AE8BD),
    300: Color(0xFF6FDEA2),
    400: Color(0xFF4DD78D),
    500: Color(0xFF25D366),
    600: Color(0xFF1FC15C),
    700: Color(0xFF18AD50),
    800: Color(0xFF129944),
    900: Color(0xFF0A7731),
  });

  // =======================================================
  // SECONDARY (WhatsApp Teal)
  // =======================================================

  static const Color secondary = Color(0xFF128C7E);

  static const MaterialColor secondaryPalette = MaterialColor(0xFF128C7E, {
    50: Color(0xFFE4F4F2),
    100: Color(0xFFBCE3DE),
    200: Color(0xFF8DD0C8),
    300: Color(0xFF5DBCB1),
    400: Color(0xFF39AD9F),
    500: Color(0xFF128C7E),
    600: Color(0xFF108174),
    700: Color(0xFF0D7567),
    800: Color(0xFF0A695B),
    900: Color(0xFF075E54),
  });

  // =======================================================
  // TERTIARY (Accent Mint)
  // =======================================================

  static const Color tertiary = Color(0xFF34B7A7);

  static const MaterialColor tertiaryPalette = MaterialColor(0xFF34B7A7, {
    50: Color(0xFFE7F7F5),
    100: Color(0xFFC2EBE6),
    200: Color(0xFF98DED6),
    300: Color(0xFF6DD1C5),
    400: Color(0xFF4CC7B8),
    500: Color(0xFF34B7A7),
    600: Color(0xFF2EA89A),
    700: Color(0xFF269587),
    800: Color(0xFF1F8375),
    900: Color(0xFF146458),
  });

  // =======================================================
  // ERROR
  // =======================================================

  static const Color error = Color(0xFFE53935);

  static const MaterialColor errorPalette = MaterialColor(0xFFE53935, {
    50: Color(0xFFFFEBEE),
    100: Color(0xFFFFCDD2),
    200: Color(0xFFEF9A9A),
    300: Color(0xFFE57373),
    400: Color(0xFFEF5350),
    500: Color(0xFFE53935),
    600: Color(0xFFD32F2F),
    700: Color(0xFFC62828),
    800: Color(0xFFB71C1C),
    900: Color(0xFF8E0000),
  });

  // =======================================================
  // SUCCESS
  // =======================================================

  static const Color success = Color(0xFF25D366);

  static const MaterialColor successPalette = MaterialColor(0xFF25D366, {
    50: Color(0xFFE7F9EF),
    100: Color(0xFFC3F1D7),
    200: Color(0xFF9AE8BD),
    300: Color(0xFF6FDEA2),
    400: Color(0xFF4DD78D),
    500: Color(0xFF25D366),
    600: Color(0xFF1FC15C),
    700: Color(0xFF18AD50),
    800: Color(0xFF129944),
    900: Color(0xFF0A7731),
  });

  // =======================================================
  // NEUTRAL
  // =======================================================

  static const MaterialColor neutralPalette = MaterialColor(0xFF667781, {
    50: Color(0xFFF7F8F8),
    100: Color(0xFFF1F2F3),
    200: Color(0xFFE3E6E8),
    300: Color(0xFFD5DADF),
    400: Color(0xFF9AA6AD),
    500: Color(0xFF7B8790),
    600: Color(0xFF667781),
    700: Color(0xFF54656F),
    800: Color(0xFF41525D),
    900: Color(0xFF2A3942),
  });

  // =======================================================
  // SURFACE / BACKGROUND
  // =======================================================

  static const Color background = Color(0xFFF0F2F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF7F8FA);

  // =======================================================
  // TEXT
  // =======================================================

  static const Color textPrimary = Color(0xFF111B21);
  static const Color textSecondary = Color(0xFF667781);
  static const Color textDisabled = Color(0xFF9AA6AD);

  // =======================================================
  // BORDER
  // =======================================================

  static const Color border = Color(0xFFE9EDEF);

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
