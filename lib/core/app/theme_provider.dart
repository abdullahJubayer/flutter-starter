import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/storage/i_local_storage_service.dart';
import 'package:flutter_template/core/di/service_locator.dart';

const _themeKey = 'theme_mode';

final themeProvider = FutureProvider<ThemeMode>((ref) async {
  final storageService = sl<ILocalStorageService>();
  final themeIndex = await storageService.getData(_themeKey) as int?;
  if (themeIndex == null) {
    return ThemeMode.dark;
  }
  return ThemeMode.values[themeIndex];
});

