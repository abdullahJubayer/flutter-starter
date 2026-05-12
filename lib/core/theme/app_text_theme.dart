import 'package:flutter/material.dart';

import 'app_light_color.dart';
import 'app_dark_color.dart';

class AppTextTheme {
  TextTheme scaleTextTheme(TextTheme base, double textScaleFactor) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontSize: base.displayLarge!.fontSize! / textScaleFactor,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontSize: base.displayMedium!.fontSize! / textScaleFactor,
      ),
      displaySmall: base.displaySmall?.copyWith(
        fontSize: base.displaySmall!.fontSize! / textScaleFactor,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        fontSize: base.headlineLarge!.fontSize! / textScaleFactor,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: base.headlineMedium!.fontSize! / textScaleFactor,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontSize: base.headlineSmall!.fontSize! / textScaleFactor,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: base.titleLarge!.fontSize! / textScaleFactor,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontSize: base.titleMedium!.fontSize! / textScaleFactor,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontSize: base.titleSmall!.fontSize! / textScaleFactor,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: base.bodyLarge!.fontSize! / textScaleFactor,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: base.bodyMedium!.fontSize! / textScaleFactor,
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontSize: base.bodySmall!.fontSize! / textScaleFactor,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontSize: base.labelLarge!.fontSize! / textScaleFactor,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontSize: base.labelMedium!.fontSize! / textScaleFactor,
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontSize: base.labelSmall!.fontSize! / textScaleFactor,
      ),
    );
  }

  TextTheme appLightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 96,
      height: 1.2,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w400,
      fontFamily: 'PublicSans',
    ),
    displayMedium: TextStyle(
      fontSize: 60,
      height: 1.2,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w400,
      fontFamily: 'PublicSans',
    ),
    displaySmall: TextStyle(
      fontSize: 48,
      height: 1.2,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w400,
      fontFamily: 'PublicSans',
    ),
    headlineLarge: TextStyle(
      fontSize: 28,
      height: 36 / 28,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w700,
      fontFamily: 'PublicSans',
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      height: 36 / 24,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w600,
      fontFamily: 'PublicSans',
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      height: 24 / 20,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w600,
      fontFamily: 'PublicSans',
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      height: 24 / 16,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w600,
      fontFamily: 'PublicSans',
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      height: 18 / 14,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w600,
      fontFamily: 'PublicSans',
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      height: 18 / 14,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w600,
      fontFamily: 'PublicSans',
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 22 / 16,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w400,
      fontFamily: 'PublicSans',
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      height: 22 / 16,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w600,
      fontFamily: 'PublicSans',
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      height: 22 / 14,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w400,
      fontFamily: 'PublicSans',
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      height: 22 / 14,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w400,
      fontFamily: 'PublicSans',
    ),
    labelMedium: TextStyle(
      fontSize: 13,
      height: 18 / 13,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w500,
      fontFamily: 'PublicSans',
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      height: 16 / 12,
      color: AppLightColors.neutralPalette.shade900,
      fontWeight: FontWeight.w400,
      fontFamily: 'PublicSans',
    ),
  );

  TextTheme get appDarkTextTheme => appLightTextTheme.apply(
        bodyColor: AppDarkColors.textPrimary,
        displayColor: AppDarkColors.textPrimary,
      );
}
