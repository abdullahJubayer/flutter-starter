import 'package:flutter/material.dart';

/// =======================================================
/// MATERIAL 3 DARK PALETTES
/// With Full Tonal Shades
/// =======================================================

class AppDarkColors {
  AppDarkColors._();

  // =======================================================
// PRIMARY (WhatsApp Green - Dark Theme)
// =======================================================

  static const Color primary = Color(0xFF04140A);

  static const MaterialColor primaryPalette = MaterialColor(0xFF25D366, {
    50: Color(0xFF04140A),
    100: Color(0xFF072012),
    200: Color(0xFF0B331D),
    300: Color(0xFF0F4728),
    400: Color(0xFF156338),
    500: Color(0xFF25D366),
    600: Color(0xFF4DDE85),
    700: Color(0xFF7BE7A5),
    800: Color(0xFFB2F1CC),
    900: Color(0xFFE4FBEE),
  });

// =======================================================
// SECONDARY (WhatsApp Teal)
// =======================================================

  static const Color secondary = Color(0xFF53BDAA);

  static const MaterialColor secondaryPalette = MaterialColor(0xFF53BDAA, {
    50: Color(0xFF031412),
    100: Color(0xFF08211E),
    200: Color(0xFF0E3530),
    300: Color(0xFF144A43),
    400: Color(0xFF1D675E),
    500: Color(0xFF128C7E),
    600: Color(0xFF2FA899),
    700: Color(0xFF53BDAA),
    800: Color(0xFF8ED5C8),
    900: Color(0xFFD9F5EF),
  });

// =======================================================
// TERTIARY (Muted Mint Accent)
// =======================================================

  static const Color tertiary = Color(0xFF7ADBCF);

  static const MaterialColor tertiaryPalette = MaterialColor(0xFF7ADBCF, {
    50: Color(0xFF051311),
    100: Color(0xFF0A211E),
    200: Color(0xFF113530),
    300: Color(0xFF184A43),
    400: Color(0xFF23685E),
    500: Color(0xFF34B7A7),
    600: Color(0xFF58C7BA),
    700: Color(0xFF7ADBCF),
    800: Color(0xFFACECE4),
    900: Color(0xFFE1FAF6),
  });

// =======================================================
// ERROR
// =======================================================

  static const Color error = Color(0xFFFFB4AB);

  static const MaterialColor errorPalette = MaterialColor(0xFFFFB4AB, {
    50: Color(0xFF2D0001),
    100: Color(0xFF450002),
    200: Color(0xFF690005),
    300: Color(0xFF93000A),
    400: Color(0xFFC5221F),
    500: Color(0xFFE53935),
    600: Color(0xFFFF6B68),
    700: Color(0xFFFF8A80),
    800: Color(0xFFFFB4AB),
    900: Color(0xFFFFDAD6),
  });

// =======================================================
// SUCCESS
// =======================================================

  static const Color success = Color(0xFF6FE39B);

  static const MaterialColor successPalette = MaterialColor(0xFF6FE39B, {
    50: Color(0xFF04140A),
    100: Color(0xFF072012),
    200: Color(0xFF0B331D),
    300: Color(0xFF0F4728),
    400: Color(0xFF156338),
    500: Color(0xFF25D366),
    600: Color(0xFF4DDE85),
    700: Color(0xFF6FE39B),
    800: Color(0xFFA8EFC3),
    900: Color(0xFFDFF9E8),
  });

// =======================================================
// NEUTRAL (WhatsApp Dark)
// =======================================================

  static const MaterialColor neutralPalette = MaterialColor(0xFF8696A0, {
    50: Color(0xFF0B141A),
    100: Color(0xFF111B21),
    200: Color(0xFF182229),
    300: Color(0xFF202C33),
    400: Color(0xFF2A3942),
    500: Color(0xFF3B4A54),
    600: Color(0xFF667781),
    700: Color(0xFF8696A0),
    800: Color(0xFFD1D7DB),
    900: Color(0xFFF0F2F5),
  });

// =======================================================
// SURFACE / BACKGROUND
// =======================================================

  static const Color background = Color(0xFF0B141A);
  static const Color surface = Color(0xFF111B21);
  static const Color surfaceVariant = Color(0xFF202C33);

// =======================================================
// TEXT
// =======================================================

  static const Color textPrimary = Color(0xFFE9EDEF);
  static const Color textSecondary = Color(0xFF8696A0);
  static const Color textDisabled = Color(0xFF667781);

// =======================================================
// BORDER
// =======================================================

  static const Color border = Color(0xFF2A3942);

// =======================================================
// PURE COLORS
// =======================================================

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}
