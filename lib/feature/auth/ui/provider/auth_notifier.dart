import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_template/core/di/injection_container.dart';
import 'package:flutter_template/feature/auth/domain/model/auth_response.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';
import 'package:flutter_template/feature/auth/domain/usecase/login_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_state.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final LoginUseCase _loginUseCase = sl<LoginUseCase>();

  @override
  AuthState build() {
    return const AuthState();
  }

  Future<BaseResponse<AuthResponse>> login({
    required String email,
    required String password,
    required String phone,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _loginUseCase(
        email: email,
        password: password,
        phone: phone,
      );

      state = state.copyWith(
        isLoading: false,
        user: response.data,
        error: response.status ? null : response.error,
      );
      return response;
    } catch (error) {
      final message = _extractErrorMessage(error);
      state = state.copyWith(isLoading: false, error: message);
      return BaseResponse<AuthResponse>(
        status: false,
        message: message,
        data: null,
      );
    }
  }

  Future<BaseResponse<AuthResponse>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    final response = BaseResponse<AuthResponse>(
      status: false,
      message: 'Not implemented',
      data: null,
    );
    state = state.copyWith(isLoading: false, error: response.error);
    return response;
  }

  Future<BaseResponse<AuthResponse>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    final response = BaseResponse<AuthResponse>(
      status: false,
      message: 'Not implemented',
      data: null,
    );
    state = state.copyWith(isLoading: false, error: response.error);
    return response;
  }

  Future<BaseResponse<AuthResponse>> resendVerification({
    required String email,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    final response = BaseResponse<AuthResponse>(
      status: false,
      message: 'Not implemented',
      data: null,
    );
    state = state.copyWith(isLoading: false, error: response.error);
    return response;
  }

  String _extractErrorMessage(Object error) {
    if (error is DioException) {
      final responseData = error.response?.data;
      if (responseData is Map<String, dynamic>) {
        return BaseResponse.fromError(responseData).error;
      }

      return error.message ?? 'Login failed. Please try again.';
    }

    return error.toString();
  }
}
