import 'package:flutter/material.dart';
import 'app_light_color.dart';
import 'app_dark_color.dart';

/// Custom theme extension for app colors.
/// Access via: Theme.of(context).extension<AppColorsExtension>()!
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  // =======================================================
  // PRIMARY
  // =======================================================
  final Color primary;
  final MaterialColor primaryPalette;

  // =======================================================
  // SECONDARY
  // =======================================================
  final Color secondary;
  final MaterialColor secondaryPalette;

  // =======================================================
  // TERTIARY
  // =======================================================
  final Color tertiary;
  final MaterialColor tertiaryPalette;

  // =======================================================
  // ERROR
  // =======================================================
  final Color error;
  final MaterialColor errorPalette;

  // =======================================================
  // SUCCESS
  // =======================================================
  final Color success;
  final MaterialColor successPalette;

  // =======================================================
  // NEUTRAL
  // =======================================================
  final MaterialColor neutralPalette;

  // =======================================================
  // BACKGROUND / SURFACE
  // =======================================================
  final Color background;
  final Color surface;
  final Color surfaceVariant;

  // =======================================================
  // TEXT
  // =======================================================
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;

  // =======================================================
  // BORDER
  // =======================================================
  final Color border;

  const AppColorsExtension({
    required this.primary,
    required this.primaryPalette,
    required this.secondary,
    required this.secondaryPalette,
    required this.tertiary,
    required this.tertiaryPalette,
    required this.error,
    required this.errorPalette,
    required this.success,
    required this.successPalette,
    required this.neutralPalette,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.border,
  });

  /// Light theme colors
  static const AppColorsExtension light = AppColorsExtension(
    primary: AppLightColors.primary,
    primaryPalette: AppLightColors.primaryPalette,
    secondary: AppLightColors.secondary,
    secondaryPalette: AppLightColors.secondaryPalette,
    tertiary: AppLightColors.tertiary,
    tertiaryPalette: AppLightColors.tertiaryPalette,
    error: AppLightColors.error,
    errorPalette: AppLightColors.errorPalette,
    success: AppLightColors.success,
    successPalette: AppLightColors.successPalette,
    neutralPalette: AppLightColors.neutralPalette,
    background: AppLightColors.background,
    surface: AppLightColors.surface,
    surfaceVariant: AppLightColors.surfaceVariant,
    textPrimary: AppLightColors.textPrimary,
    textSecondary: AppLightColors.textSecondary,
    textDisabled: AppLightColors.textDisabled,
    border: AppLightColors.border,
  );

  /// Dark theme colors
  static const AppColorsExtension dark = AppColorsExtension(
    primary: AppDarkColors.primary,
    primaryPalette: AppDarkColors.primaryPalette,
    secondary: AppDarkColors.secondary,
    secondaryPalette: AppDarkColors.secondaryPalette,
    tertiary: AppDarkColors.tertiary,
    tertiaryPalette: AppDarkColors.tertiaryPalette,
    error: AppDarkColors.error,
    errorPalette: AppDarkColors.errorPalette,
    success: AppDarkColors.success,
    successPalette: AppDarkColors.successPalette,
    neutralPalette: AppDarkColors.neutralPalette,
    background: AppDarkColors.background,
    surface: AppDarkColors.surface,
    surfaceVariant: AppDarkColors.surfaceVariant,
    textPrimary: AppDarkColors.textPrimary,
    textSecondary: AppDarkColors.textSecondary,
    textDisabled: AppDarkColors.textDisabled,
    border: AppDarkColors.border,
  );

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primary,
    MaterialColor? primaryPalette,
    Color? secondary,
    MaterialColor? secondaryPalette,
    Color? tertiary,
    MaterialColor? tertiaryPalette,
    Color? error,
    MaterialColor? errorPalette,
    Color? success,
    MaterialColor? successPalette,
    MaterialColor? neutralPalette,
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDisabled,
    Color? border,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      primaryPalette: primaryPalette ?? this.primaryPalette,
      secondary: secondary ?? this.secondary,
      secondaryPalette: secondaryPalette ?? this.secondaryPalette,
      tertiary: tertiary ?? this.tertiary,
      tertiaryPalette: tertiaryPalette ?? this.tertiaryPalette,
      error: error ?? this.error,
      errorPalette: errorPalette ?? this.errorPalette,
      success: success ?? this.success,
      successPalette: successPalette ?? this.successPalette,
      neutralPalette: neutralPalette ?? this.neutralPalette,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textDisabled: textDisabled ?? this.textDisabled,
      border: border ?? this.border,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      primaryPalette: primaryPalette, // MaterialColor doesn't lerp well
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      secondaryPalette: secondaryPalette,
      tertiary: Color.lerp(tertiary, other.tertiary, t) ?? tertiary,
      tertiaryPalette: tertiaryPalette,
      error: Color.lerp(error, other.error, t) ?? error,
      errorPalette: errorPalette,
      success: Color.lerp(success, other.success, t) ?? success,
      successPalette: successPalette,
      neutralPalette: neutralPalette,
      background: Color.lerp(background, other.background, t) ?? background,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      surfaceVariant:
          Color.lerp(surfaceVariant, other.surfaceVariant, t) ?? surfaceVariant,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textSecondary:
          Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      textDisabled:
          Color.lerp(textDisabled, other.textDisabled, t) ?? textDisabled,
      border: Color.lerp(border, other.border, t) ?? border,
    );
  }
}

