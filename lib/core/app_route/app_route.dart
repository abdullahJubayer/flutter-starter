import 'package:auto_route/auto_route.dart';
import 'package:flutter_template/core/app_route/app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  static const String splash = '/splash';
  static const String main = '/main';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';

  @override
  List<AutoRoute> get routes => [
    RedirectRoute(path: '/', redirectTo: splash),
    AutoRoute(path: splash, page: SplashRoute.page, initial: true),
    AutoRoute(path: login, page: LoginRoute.page),
    AutoRoute(path: registration, page: RegistrationRoute.page),
    AutoRoute(path: resetPassword, page: ResetPasswordRoute.page),
  ];
}
