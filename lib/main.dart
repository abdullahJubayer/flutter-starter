import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app/bootstrapper_app.dart';
import 'package:flutter_template/core/app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BootstrapperApp().init();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
