import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/core/app_route/app_route.gr.dart';
import 'package:flutter_template/core/storage/i_local_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_template/core/auth/i_session_service.dart';
import 'package:flutter_template/core/constants/core_constants.dart';
import 'package:flutter_template/core/app/my_app.dart';
import 'package:flutter_template/core/widget/session_expire_dialog.dart';
import 'package:flutter_template/core/logger/app_logging.dart';

class CustomInterceptors extends InterceptorsWrapper {
  CustomInterceptors({
    required ILocalStorageService sharePref,
    required Dio dio,
    required FlutterSecureStorage secureStorage,
    required ISessionService sessionService,
  })  : _sharePref = sharePref,
        _dio = dio,
        _secureStorage = secureStorage,
        _sessionService = sessionService;

  final ILocalStorageService _sharePref;
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  final ISessionService _sessionService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _sharePref.getData(CoreConstants.accessTokenKey) ?? '';

    options.headers.addAll({if (token.isNotEmpty) 'Authorization': "Bearer $token"});

    var data = options.data ?? {};

    logger.i(
      tag: 'API Request',
      message: '''🔥 Url: ${options.baseUrl}${options.path} 
    Headers: ${jsonEncode(options.headers)} 
    Data: ${jsonEncode(data)} 
    Param: ${options.queryParameters}''',
    );
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Attempt refresh token flow on 401 errors
    final statusCode = err.response?.statusCode;
    final requestOptions = err.requestOptions;

    if (statusCode == 401 && requestOptions.extra['retried'] != true) {
      try {
        final refreshToken = await _secureStorage.read(key: CoreConstants.refreshTokenKey);
        if (refreshToken == null || refreshToken.isEmpty) {
          return handler.next(err);
        }

        // Call refresh endpoint without interceptors to avoid loops
        final refreshDio = Dio(BaseOptions(baseUrl: requestOptions.baseUrl));
        final resp = await refreshDio.post(CoreConstants.refreshTokenEndpoint,
            data: {'refreshToken': refreshToken});

        if (resp.statusCode == 200) {
          final data = resp.data as Map<String, dynamic>;
          final newAccessToken = data['accessToken'] as String? ?? '';
          final newRefreshToken = data['refreshToken'] as String?;

          if (newAccessToken.isNotEmpty) {
            await _sharePref.setData(CoreConstants.accessTokenKey, newAccessToken);
          }
          if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
            await _secureStorage.write(key: CoreConstants.refreshTokenKey, value: newRefreshToken);
          }

          // retry the original request with new token
          requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          requestOptions.extra['retried'] = true;
          final response = await _dio.fetch(requestOptions);
          return handler.resolve(response);
        }
      } catch (e) {
        // refresh failed — fall through to next
        logger.e(
          tag: 'Token Refresh',
          error: e,
          message: 'Refresh token failed',
        );
        try {
          await _sessionService.removeSession();
        } catch (_) {}
      }
    }

    if (statusCode == 401) {
      sessionExpireDialog();
    }

    logError(err);
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data as Map;
    data.putIfAbsent('status_code', () => response.statusCode);
    response.data = data;
    logger.i(
      tag: 'API Response',
      message: '''✅ Url: ${response.requestOptions.baseUrl}${response.requestOptions.path} 
    Response: ${jsonEncode(response.data)}''',
    );
    return handler.next(response);
  }

  void logError(dynamic err) {
    final logMessage =
        '''❌ Url: ${err.requestOptions.baseUrl}${err.requestOptions.path} 
    Status Code: ${err.response?.statusCode}
    Error: ${err.response.toString()}''';
    final lines = logMessage.split('\n').take(10).toList();

    for (final line in lines) {
      logger.e(
        error: line,
        tag: 'API Error',
      );
    }
  }

  void sessionExpireDialog() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final context = appRouter.navigatorKey.currentContext;
    if (context != null && context.mounted) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SessionExpireDialog(
            onConfirm: () {
              Navigator.pop(context);
              appRouter.replaceAll([const LoginRoute()]);
            },
          );
        },
      );
    }
  }
}
