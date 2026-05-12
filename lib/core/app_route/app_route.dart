import 'package:auto_route/auto_route.dart' as ar;

import 'app_route.gr.dart';

@ar.AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends ar.RootStackRouter {
  static const String splash = '/splash';
  static const String main = '/main';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';

  @override
  List<ar.AutoRoute> get routes => [
        ar.RedirectRoute(path: '/', redirectTo: splash),
        ar.AutoRoute(path: splash, page: SplashRoute.page, initial: true),
        ar.AutoRoute(path: login, page: LoginRoute.page),
        ar.AutoRoute(path: registration, page: RegistrationRoute.page),
        ar.AutoRoute(path: resetPassword, page: ResetPasswordRoute.page),
      ];
}

