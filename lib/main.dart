import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app/bootstrapper_app.dart';
import 'package:flutter_template/core/app/my_app.dart';
import 'core/app/default_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bootstrap = BootstrapperApp();
  await bootstrap.init();
  final config = await bootstrap.loadAppConfig();

  runApp(
    ProviderScope(
      overrides: [appConfigProvider.overrideWithValue(config)],
      child: MyApp(),
    ),
  );
}
