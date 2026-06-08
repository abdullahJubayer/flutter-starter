import 'package:flutter/material.dart';

import 'app_light_color.dart';
import 'app_dark_color.dart';

class AppTextTheme {
  const AppTextTheme();

  // =========================
  // LIGHT
  // =========================

  TextTheme get appLightTextTheme => TextTheme(
    displayLarge: _display(96, AppLightColors.textPrimary),
    displayMedium: _display(60, AppLightColors.textPrimary),
    displaySmall: _display(48, AppLightColors.textPrimary),

    headlineLarge: _headline(32, AppLightColors.textPrimary),
    headlineMedium: _headline(28, AppLightColors.textPrimary),
    headlineSmall: _headline(24, AppLightColors.textPrimary),

    titleLarge: _title(18, AppLightColors.textPrimary),
    titleMedium: _title(16, AppLightColors.textPrimary),
    titleSmall: _title(14, AppLightColors.textPrimary),

    bodyLarge: _body(16, FontWeight.w400, AppLightColors.textPrimary),
    bodyMedium: _body(14, FontWeight.w400, AppLightColors.textPrimary),
    bodySmall: _body(12, FontWeight.w400, AppLightColors.textPrimary),

    labelLarge: _label(14, AppLightColors.textSecondary),
    labelMedium: _label(12, AppLightColors.textSecondary),
    labelSmall: _label(11, AppLightColors.textSecondary),
  );

  // =========================
  // DARK
  // =========================

  TextTheme get appDarkTextTheme => TextTheme(
    displayLarge: _display(96, AppDarkColors.textPrimary),
    displayMedium: _display(60, AppDarkColors.textPrimary),
    displaySmall: _display(48, AppDarkColors.textPrimary),

    headlineLarge: _headline(32, AppDarkColors.textPrimary),
    headlineMedium: _headline(28, AppDarkColors.textPrimary),
    headlineSmall: _headline(24, AppDarkColors.textPrimary),

    titleLarge: _title(18, AppDarkColors.textPrimary),
    titleMedium: _title(16, AppDarkColors.textPrimary),
    titleSmall: _title(14, AppDarkColors.textPrimary),

    bodyLarge: _body(16, FontWeight.w400, AppDarkColors.textPrimary),
    bodyMedium: _body(14, FontWeight.w400, AppDarkColors.textPrimary),
    bodySmall: _body(12, FontWeight.w400, AppDarkColors.textPrimary),

    labelLarge: _label(14, AppDarkColors.textSecondary),
    labelMedium: _label(12, AppDarkColors.textSecondary),
    labelSmall: _label(11, AppDarkColors.textSecondary),
  );

  // =========================
  // HELPERS (STATIC or INSTANCE SAFE)
  // =========================

  TextStyle _display(double size, Color color) => TextStyle(
    fontSize: size,
    height: 1.2,
    fontWeight: FontWeight.w400,
    fontFamily: 'PublicSans',
    color: color,
  );

  TextStyle _headline(double size, Color color) => TextStyle(
    fontSize: size,
    height: 1.3,
    fontWeight: FontWeight.w600,
    fontFamily: 'PublicSans',
    color: color,
  );

  TextStyle _title(double size, Color color) => TextStyle(
    fontSize: size,
    height: 1.3,
    fontWeight: FontWeight.w600,
    fontFamily: 'PublicSans',
    color: color,
  );

  TextStyle _body(double size, FontWeight w, Color color) => TextStyle(
    fontSize: size,
    height: 1.4,
    fontWeight: w,
    fontFamily: 'PublicSans',
    color: color,
  );

  TextStyle _label(double size, Color color) => TextStyle(
    fontSize: size,
    height: 1.2,
    fontWeight: FontWeight.w500,
    fontFamily: 'PublicSans',
    color: color,
  );
}