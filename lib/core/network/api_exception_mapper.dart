import 'package:dio/dio.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';

class ApiExceptionMapper {
  static BaseResponse<T> toBaseResponse<T>(
    Object error, [
    StackTrace? stackTrace,
  ]) {

    if (error is DioException) {
      return _handleDioException(error);
    } else if (error is TypeError || error is FormatException) {
      return BaseResponse.fromParseError(error);
    } else {
      return BaseResponse(
        status: false,
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Handles specific [DioException] types.
  static BaseResponse<T> _handleDioException<T>(DioException error) {
    switch (error.type) {
      case DioExceptionType.badResponse:
        final responseData = error.response?.data;
        if (responseData is Map<String, dynamic>) {
          return BaseResponse<T>.fromError(responseData);
        }
        return BaseResponse(
          status: false,
          message: _getHttpErrorMessage(error.response?.statusCode),
        );

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return BaseResponse(
          status: false,
          message:
              'Connection timed out. Please check your network and try again.',
        );

      case DioExceptionType.connectionError:
        return BaseResponse(
          status: false,
          message: 'Connection error. Please check your internet connection.',
        );

      case DioExceptionType.cancel:
        return BaseResponse(
          status: false,
          message: 'The request was cancelled.',
        );

      case DioExceptionType.unknown:
        if (error.error is TypeError || error.error is FormatException) {
          return BaseResponse.fromParseError(error.error!);
        }
        return BaseResponse(
          status: false,
          message: error.message ?? 'An unexpected network error occurred.',
        );
      default:
        return BaseResponse(
          status: false,
          message: error.message ?? 'An unexpected network error occurred.',
        );
    }
  }

  /// Returns a user-friendly message for a given HTTP status code.
  static String _getHttpErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request. Please check your input.';
      case 401:
        return 'Authentication failed. Please log in again.';
      case 403:
        return 'You do not have permission to perform this action.';
      case 404:
        return 'The requested resource was not found.';
      case 422:
        return 'The submitted data was invalid.';
      case 500:
        return 'Internal server error. Please try again later.';
      default:
        return 'An error occurred (Code: $statusCode).';
    }
  }
}
