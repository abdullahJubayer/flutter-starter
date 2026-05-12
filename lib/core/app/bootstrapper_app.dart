import 'package:flutter_template/core/di/injection_container.dart';
import 'package:flutter_template/core/logger/app_logging.dart';
import 'package:flutter_template/core/storage/path_provider_service.dart';
import '../config/secure_env.dart';

class BootstrapperApp {
  Future<void> init() async {
    await injectableConfig();
    await initLogger();
    await loadEnvironment();
    await PathProviderService.init();
  }

  Future<void> loadEnvironment() {
    const environments = {
      'stage': 'environments/.env.stage',
      'prod': 'environments/.env.prod',
    };
    const environment = String.fromEnvironment('ENV', defaultValue: 'stage');
    final filePath = environments[environment] ?? environments['stage'];
    return secureEnv.load(fileName: filePath!);
  }
}
