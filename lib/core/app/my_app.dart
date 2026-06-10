import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app_route/app_route.dart';
import 'package:flutter_template/core/localization/language_provider.dart';
import 'package:flutter_template/core/theme/theme_data.dart';
import 'package:flutter_template/core/theme/theme_provider.dart';
import 'package:flutter_template/core/widget/custom_toast.dart';
import 'package:flutter_template/l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'lifecycle_manager.dart';
import 'security_gate.dart';

final appRouter = AppRouter();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CustomToast.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);
    const environment = String.fromEnvironment('ENV', defaultValue: 'dev');

    return LifecycleManager(
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: theme,
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [AppLocalizations.delegate],
        builder: (context, child) {
          final toastBuilder = FToastBuilder();
          final builtChild = toastBuilder(context, SecurityGate(child: child!));

          if (environment != 'prod') {
            return Banner(
              color: Theme.of(context).colorScheme.primary,
              message: 'DEV',
              location: BannerLocation.topEnd,
              child: builtChild,
            );
          }
          return builtChild;
        },
      ),
    );
  }
}
