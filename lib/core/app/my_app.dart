import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app/theme_provider.dart';
import 'package:flutter_template/core/app_route/app_route.dart';
import 'package:flutter_template/core/localization/language_provider.dart';
import 'package:flutter_template/core/theme/theme_data.dart';
import 'package:flutter_template/l10n/app_localizations.dart';
import 'lifecycle_manager.dart';

final appRouter = AppRouter();

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);
    const environment = String.fromEnvironment('ENV', defaultValue: 'dev');

    return themeMode.when(
      data: (theme) {
        return locale.when(
          data: (lang) {
            return LifecycleManager(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: appRouter.config(),
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: theme,
                locale: lang,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: const [
                  AppLocalizations.delegate
                ],
                builder: (context, child) {
                  if (environment != 'prod') {
                    return Banner(
                      color: Theme.of(context).colorScheme.primary,
                      message: 'DEV',
                      location: BannerLocation.topEnd,
                      child: child!,
                    );
                  }
                  return child!;
                },
              ),
            );
          },
          loading: () => _buildLoadingScreen(),
          error: (error, stackTrace) => _buildErrorScreen(error, stackTrace),
        );
      },
      loading: () => _buildLoadingScreen(),
      error: (error, stackTrace) => _buildErrorScreen(error, stackTrace),
    );
  }

  Widget _buildLoadingScreen() {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorScreen(Object error, StackTrace stackTrace) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
