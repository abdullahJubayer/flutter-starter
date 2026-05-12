import 'package:flutter/material.dart';

import 'app_light_color.dart';
import 'app_dark_color.dart';
import 'app_colors_extension.dart';

class AppTheme {
  AppTheme._();

  // =======================================================
  // LIGHT THEME
  // =======================================================

  /// Static light theme so it can be accessed as `AppTheme.lightTheme`.
  /// Uses `ThemeData.light().textTheme` as the base text theme.
  static ThemeData get lightTheme {
    final appTextTheme = ThemeData.light().textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppLightColors.neutralPalette.shade50,
      extensions: const <ThemeExtension<dynamic>>[
        AppColorsExtension.light,
      ],
      colorScheme: ColorScheme.light(
        primary: AppLightColors.primary,
        onPrimary: AppLightColors.white,
        secondary: AppLightColors.secondary,
        onSecondary: AppLightColors.white,
        error: AppLightColors.error,
        onError: AppLightColors.white,
        surface: AppLightColors.surface,
        onSurface: AppLightColors.neutralPalette.shade900,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppLightColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: AppLightColors.neutralPalette.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: AppLightColors.neutralPalette.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: AppLightColors.primaryPalette.shade500, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: AppLightColors.errorPalette.shade500, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: AppLightColors.errorPalette.shade500, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: appTextTheme.titleMedium?.copyWith(
          color: AppLightColors.primaryPalette.shade500,
        ),
        labelStyle: appTextTheme.bodyLarge?.copyWith(
          color: AppLightColors.neutralPalette.shade500,
        ),
        hintStyle: appTextTheme.bodyLarge?.copyWith(
          color: AppLightColors.neutralPalette.shade500,
        ),
        errorStyle: appTextTheme.bodySmall?.copyWith(
          color: AppLightColors.errorPalette.shade500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppLightColors.primaryPalette.shade500,
          foregroundColor: AppLightColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle:
              appTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppLightColors.primaryPalette.shade500,
          side: BorderSide(
              color: AppLightColors.primaryPalette.shade500, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle:
              appTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppLightColors.primaryPalette.shade500,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle:
              appTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // =======================================================
  // DARK THEME
  // =======================================================

  /// Static dark theme so it can be accessed as `AppTheme.darkTheme`.
  /// Uses `ThemeData.dark().textTheme` as the base text theme.
  static ThemeData get darkTheme {
    final appTextTheme = ThemeData.dark().textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppDarkColors.background,
      extensions: const <ThemeExtension<dynamic>>[
        AppColorsExtension.dark,
      ],
      colorScheme: ColorScheme.dark(
        primary: AppDarkColors.primary,
        onPrimary: AppDarkColors.neutralPalette.shade50,
        secondary: AppDarkColors.secondary,
        onSecondary: AppDarkColors.neutralPalette.shade50,
        error: AppDarkColors.error,
        onError: AppDarkColors.neutralPalette.shade50,
        surface: AppDarkColors.surface,
        onSurface: AppDarkColors.textPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppDarkColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppDarkColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppDarkColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppDarkColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppDarkColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppDarkColors.error, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: appTextTheme.titleMedium?.copyWith(
          color: AppDarkColors.primary,
        ),
        labelStyle: appTextTheme.bodyLarge?.copyWith(
          color: AppDarkColors.textSecondary,
        ),
        hintStyle: appTextTheme.bodyLarge?.copyWith(
          color: AppDarkColors.textSecondary,
        ),
        errorStyle: appTextTheme.bodySmall?.copyWith(
          color: AppDarkColors.error,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppDarkColors.primary,
          foregroundColor: AppDarkColors.neutralPalette.shade50,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle:
              appTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppDarkColors.primary,
          side: BorderSide(color: AppDarkColors.primary, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle:
              appTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppDarkColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle:
              appTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
