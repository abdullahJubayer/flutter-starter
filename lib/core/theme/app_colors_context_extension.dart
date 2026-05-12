import 'package:flutter/material.dart';
import 'app_colors_extension.dart';

/// Extension on BuildContext to easily access app colors.
/// Usage: context.appColors.primary
extension AppColorsContextExtension on BuildContext {
  /// Get the current AppColorsExtension from the theme.
  /// This will automatically pick light or dark colors based on the current theme.
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>() ??
      AppColorsExtension.light;
}

