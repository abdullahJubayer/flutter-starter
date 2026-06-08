import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppConfig {
  final ThemeMode themeMode;
  final Locale locale;

  const AppConfig({
    required this.themeMode,
    required this.locale,
  });
}

final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError();
});