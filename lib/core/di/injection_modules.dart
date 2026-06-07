import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_template/core/auth/i_session_service.dart';
import 'package:flutter_template/core/network/interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @singleton
  Dio dio(ISessionService sessionService) {
    final d = Dio(BaseOptions(baseUrl: dotenv.get('BASE_URL')));

    d.interceptors.addAll([
      AuthHeaderInterceptor(sessionService: sessionService),
      ApiLoggingInterceptor(),
      AuthRefreshInterceptor(dio: d, sessionService: sessionService),
    ]);

    return d;
  }
}
