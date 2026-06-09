import 'package:flutter/material.dart';
import 'package:flutter_template/core/app/default_config.dart';
import 'package:flutter_template/core/constants/core_constants.dart';
import 'package:flutter_template/core/di/injection_container.dart';
import 'package:flutter_template/core/logger/app_logging.dart';
import 'package:flutter_template/core/storage/i_local_storage_service.dart';
import 'package:flutter_template/core/storage/path_provider_service.dart';

class BootstrapperApp {
  Future<void> init() async {
    await initLogger();
    await configureDependencies();
    await PathProviderService.init();
  }

  Future<AppConfig> loadAppConfig() async {
    final storage = sl<ILocalStorageService>();
    final themeIndex = await storage.getData(CoreConstants.themeModeKey) as int?;
    final localeCode = await storage.getData(CoreConstants.languageCodeKey);

    return AppConfig(
      themeMode: themeIndex != null
          ? ThemeMode.values[themeIndex]
          : ThemeMode.light,
      locale: localeCode != null ? Locale(localeCode) : const Locale('en'),
    );
  }
}
