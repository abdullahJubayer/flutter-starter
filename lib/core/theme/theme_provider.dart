import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app/default_config.dart';
import 'package:flutter_template/core/constants/core_constants.dart';
import 'package:flutter_template/core/di/injection_container.dart';
import 'package:flutter_template/core/storage/i_local_storage_service.dart';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);

class ThemeNotifier extends Notifier<ThemeMode> {
  late final ILocalStorageService storage;

  @override
  ThemeMode build() {
    storage = sl<ILocalStorageService>();
    return ref.watch(appConfigProvider).themeMode;
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await storage.setData(CoreConstants.themeModeKey, mode.index.toString());
  }
}
