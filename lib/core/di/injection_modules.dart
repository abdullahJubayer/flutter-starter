import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_template/core/auth/i_session_service.dart';
import 'package:flutter_template/core/config/secure_env.dart';
import 'package:flutter_template/core/di/injection_container.dart';
import 'package:flutter_template/core/network/interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  Dio get dio {
    final d = Dio(BaseOptions(baseUrl: secureEnv.env['BASE_URL'] ?? ''));
    d.interceptors.addAll([
      AuthHeaderInterceptor(sessionService: sl<ISessionService>()),
      ApiLoggingInterceptor(),
      AuthRefreshInterceptor(dio: d, sessionService: sl<ISessionService>()),
    ]);
    return d;
  }
}
