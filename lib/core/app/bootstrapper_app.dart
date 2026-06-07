import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_template/core/di/injection_container.dart';
import 'package:flutter_template/core/logger/app_logging.dart';
import 'package:flutter_template/core/storage/path_provider_service.dart';

class BootstrapperApp {
  Future<void> init() async {
    await initLogger();
    await loadEnvironment();
    await configureDependencies();
    await PathProviderService.init();
  }

  Future<void> loadEnvironment() {
    const environments = {
      'dev': 'environments/.env.dev',
      'prod': 'environments/.env.prod',
    };
    const environment = String.fromEnvironment('ENV', defaultValue: 'dev');
    final filePath = environments[environment] ?? environments['dev'];
    logger.d(message: '======== Loaded environment:$environment ==========');
    return dotenv.load(fileName: filePath!);
  }
}
