import 'package:flutter/material.dart';

import 'app_light_color.dart';
import 'app_dark_color.dart';
import 'app_colors_extension.dart';

class AppTheme {
  AppTheme._();

  // =======================================================
  // LIGHT THEME
  // =======================================================

  static ThemeData get lightTheme {
    final textTheme = ThemeData.light().textTheme;

    final colorScheme = ColorScheme.light(
      primary: AppLightColors.primary,
      onPrimary: AppLightColors.white,
      primaryContainer: AppLightColors.primaryPalette.shade100,
      onPrimaryContainer: AppLightColors.primaryPalette.shade900,

      secondary: AppLightColors.secondary,
      onSecondary: AppLightColors.white,
      secondaryContainer: AppLightColors.secondaryPalette.shade100,
      onSecondaryContainer: AppLightColors.secondaryPalette.shade900,

      tertiary: AppLightColors.tertiary,
      onTertiary: AppLightColors.white,

      error: AppLightColors.error,
      onError: AppLightColors.white,

      surface: AppLightColors.surface,
      onSurface: AppLightColors.textPrimary,
      surfaceContainer: AppLightColors.surfaceVariant,
      surfaceContainerHigh: AppLightColors.neutralPalette.shade100,

      outline: AppLightColors.border,
      outlineVariant: AppLightColors.neutralPalette.shade200,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppLightColors.background,

      extensions: const [
        AppColorsExtension.light,
      ],

      appBarTheme: AppBarTheme(
        backgroundColor: AppLightColors.surface,
        foregroundColor: AppLightColors.textPrimary,
        elevation: 0,
        centerTitle: false,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppLightColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppLightColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppLightColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppLightColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppLightColors.primary,
          foregroundColor: AppLightColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppLightColors.primary,
        foregroundColor: AppLightColors.white,
      ),

      textTheme: textTheme.apply(
        bodyColor: AppLightColors.textPrimary,
        displayColor: AppLightColors.textPrimary,
      ),
    );
  }

  // =======================================================
  // DARK THEME (WhatsApp-style)
  // =======================================================

  static ThemeData get darkTheme {
    final textTheme = ThemeData.dark().textTheme;

    final colorScheme = ColorScheme.dark(
      primary: AppDarkColors.primary,
      onPrimary: AppDarkColors.background,
      primaryContainer: AppDarkColors.neutralPalette.shade700,
      onPrimaryContainer: AppDarkColors.textPrimary,

      secondary: AppDarkColors.secondary,
      onSecondary: AppDarkColors.background,

      error: AppDarkColors.error,
      onError: AppDarkColors.background,

      surface: AppDarkColors.surface,
      onSurface: AppDarkColors.textPrimary,

      surfaceContainer: AppDarkColors.surfaceVariant,
      surfaceContainerHigh: AppDarkColors.neutralPalette.shade300,

      outline: AppDarkColors.border,
      outlineVariant: AppDarkColors.neutralPalette.shade400,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppDarkColors.background,

      extensions: const [
        AppColorsExtension.dark,
      ],

      appBarTheme: AppBarTheme(
        backgroundColor: AppDarkColors.surface,
        foregroundColor: AppDarkColors.textPrimary,
        elevation: 0,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppDarkColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppDarkColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppDarkColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppDarkColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppDarkColors.primary,
          foregroundColor: AppDarkColors.background,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppDarkColors.primary,
        foregroundColor: AppDarkColors.background,
      ),

      textTheme: textTheme.apply(
        bodyColor: AppDarkColors.textPrimary,
        displayColor: AppDarkColors.textPrimary,
      ),
    );
  }
}