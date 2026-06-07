import 'dart:async';
import 'package:flutter_template/core/auth/i_session_service.dart';
import 'package:flutter_template/core/di/injection_container.dart';
import 'package:flutter_template/core/utils/extension/error_extensions.dart';
import 'package:flutter_template/feature/auth/domain/model/auth_response.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';
import 'package:flutter_template/feature/auth/domain/model/login_request.dart';
import 'package:flutter_template/feature/auth/domain/model/register_request.dart';
import 'package:flutter_template/feature/auth/domain/model/user_model.dart';
import 'package:flutter_template/feature/auth/domain/repository/auth_repository.dart';
import 'package:flutter_template/feature/auth/domain/usecase/login_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth_state.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final LoginUseCase _loginUseCase = sl<LoginUseCase>();
  late final AuthRepository _authRepository = sl<AuthRepository>();

  @override
  AuthState build() {
    // Automatically attempt to restore session on initialization
    Future.microtask(() => getMe());
    return const AuthState();
  }

  Future<BaseResponse<AuthResponse>> login(LoginRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _loginUseCase(request);

      if (response.status && response.data != null) {
        await sl<ISessionService>().saveSession(
          accessToken: response.data!.accessToken,
          refreshToken: response.data!.refreshToken,
        );
      }

      state = state.copyWith(
        isLoading: false,
        user: response.data,
        error: response.status ? null : response.error,
      );
      return response;
    } catch (error) {
      final message = error.extractErrorMessage();
      state = state.copyWith(isLoading: false, error: message);
      return BaseResponse<AuthResponse>(
        status: false,
        message: message,
        data: null,
      );
    }
  }

  Future<BaseResponse<AuthResponse>> register(RegisterRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _authRepository.register(request);
      state = state.copyWith(isLoading: false);
      return BaseResponse<AuthResponse>(status: true);
    } catch (error) {
      final message = error.extractErrorMessage();
      state = state.copyWith(isLoading: false, error: message);
      return BaseResponse<AuthResponse>(status: false, message: message);
    }
  }

  Future<BaseResponse<UserModel>> getMe() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authRepository.getMe();
      if (response.status && response.data != null) {
        final accessToken = await sl<ISessionService>().getAccessToken();
        final refreshToken = await sl<ISessionService>().getRefreshToken();
        state = state.copyWith(
          isLoading: false,
          user: AuthResponse(
            user: response.data,
            accessToken: accessToken,
            refreshToken: refreshToken,
          ),
        );
      } else {
        state = state.copyWith(isLoading: false, error: response.error);
      }
      return response;
    } catch (error) {
      final message = error.extractErrorMessage();
      state = state.copyWith(isLoading: false, error: message);
      return BaseResponse<UserModel>(
        status: false,
        message: message,
        data: null,
      );
    }
  }

  Future<void> logout() async {
    await sl<ISessionService>().removeSession();
    state = const AuthState();
  }
}
