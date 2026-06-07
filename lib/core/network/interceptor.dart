import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/core/app/my_app.dart';
import 'package:flutter_template/core/app_route/app_route.gr.dart';
import 'package:flutter_template/core/auth/i_session_service.dart';
import 'package:flutter_template/core/constants/core_constants.dart';
import 'package:flutter_template/core/logger/app_logging.dart';
import 'package:flutter_template/core/widget/session_expire_dialog.dart';
import 'package:flutter_template/feature/auth/domain/model/auth_response.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';
import 'package:flutter_template/feature/auth/domain/model/refresh_token_request.dart';

class AuthHeaderInterceptor extends InterceptorsWrapper {
  AuthHeaderInterceptor({required ISessionService sessionService})
    : _sessionService = sessionService;

  final ISessionService _sessionService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _sessionService.getAccessToken() ?? '';

    options.headers.addAll({
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    });

    return handler.next(options);
  }
}

class ApiLoggingInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i(
      tag: 'API Request',
      message:
          'URL: ${options.baseUrl}${options.path} | '
          'Headers: ${options.headers} | '
          'Data: ${options.data} | '
          'Params: ${options.queryParameters}',
    );
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(
      tag: 'API Response',
      message:
          'URL: ${response.requestOptions.baseUrl}${response.requestOptions.path} | '
          'Response: ${response.data}',
    );
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      tag: 'API Error',
      error:
          'URL: ${err.requestOptions.baseUrl}${err.requestOptions.path} | '
          'Status: ${err.response?.statusCode} | '
          'Type: ${err.type} | '
          'Response: ${err.response?.data}',
    );
    return handler.next(err);
  }
}

class AuthRefreshInterceptor extends InterceptorsWrapper {
  AuthRefreshInterceptor({
    required Dio dio,
    required ISessionService sessionService,
  }) : _dio = dio,
       _sessionService = sessionService;

  final Dio _dio;
  final ISessionService _sessionService;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final requestOptions = err.requestOptions;

    if (statusCode == 401 && requestOptions.extra['retried'] != true) {
      try {
        final refreshToken = await _sessionService.getRefreshToken();
        if (refreshToken == null || refreshToken.isEmpty) {
          return handler.next(err);
        }

        final refreshDio = Dio(BaseOptions(baseUrl: requestOptions.baseUrl));
        final resp = await refreshDio.post(
          CoreConstants.refreshTokenEndpoint,
          data: RefreshTokenRequest(refreshToken: refreshToken).toJson(),
        );

        if (resp.statusCode == 200 && resp.data != null) {
          final data = BaseResponse<AuthResponse>.fromJson(
            resp.data,(json) => AuthResponse.fromJson(json as Map<String, dynamic>),
          );
          final newAccessToken = data.data?.accessToken;
          final newRefreshToken = data.data?.refreshToken;

          await _sessionService.saveSession(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
          );

          requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          requestOptions.extra['retried'] = true;

          final response = await _dio.fetch(requestOptions);
          return handler.resolve(response);
        }
      } catch (e) {
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
      _sessionExpireDialog();
    }

    return handler.next(err);
  }

  void _sessionExpireDialog() async {
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
