import 'package:dio/dio.dart';
import 'package:flutter_template/core/storage/i_local_storage_service.dart';
import 'package:flutter_template/core/auth/i_session_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class DioClient {
  final ILocalStorageService _sharePerf;
  final ISessionService _sessionService;
  final Dio _dio;

  DioClient({
    required ILocalStorageService sharePerf,
    required ISessionService sessionService,
  })
      : _sharePerf = sharePerf,
        _sessionService = sessionService,
        _dio = Dio(
          BaseOptions(
            baseUrl: '',
            contentType: "application/json",
          ),
        );

  /// Perform a GET request and return Dio [Response<T>].
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      // Optional: handle specific status codes (e.g., unauthorized)
      if (e.response?.statusCode == 401) {
        try {
          _sessionService.removeSession();
        } catch (_) {}
      }
      rethrow;
    }
  }

  /// Perform a POST request and return Dio [Response<T>].
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        try {
          _sessionService.removeSession();
        } catch (_) {}
      }
      rethrow;
    }
  }

  /// Perform a PUT request and return Dio [Response<T>].
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        try {
          _sessionService.removeSession();
        } catch (_) {}
      }
      rethrow;
    }
  }

  /// Perform a DELETE request and return Dio [Response<T>].
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        try {
          _sessionService.removeSession();
        } catch (_) {}
      }
      rethrow;
    }
  }

  // Future<void> getRefreshToken() async {
  //   try {
  //     final response = await _dio.post(
  //       'ApiConstant.refreshToken',
  //       data: {
  //         "refreshToken": _sharePerf.getRefreshToken(),
  //         "accessToken": _sharePerf.getToken(),
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       // final data = Login.fromJson(jsonDecode(response.data));
  //       // if (data.refreshToken != null && data.token != null) {
  //       //   _sharePerf.setToken(token: data.token ?? '');
  //       //   _sharePerf.setRefreshToken(token: data.refreshToken ?? '');
  //       // }
  //     } else {
  //       _sharePerf.removeSession();
  //     }
  //   } catch (e) {
  //     _sharePerf.removeSession();
  //   }
  // }
}
