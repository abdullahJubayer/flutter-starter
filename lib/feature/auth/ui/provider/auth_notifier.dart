import 'dart:async';
import 'package:flutter_template/core/auth/i_session_service.dart';
import 'package:flutter_template/core/di/injection_container.dart';
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
    Future.microtask(() => getMe());
    return const AuthState();
  }

  Future<BaseResponse<AuthResponse>> login(LoginRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _loginUseCase(request);
    if (response.status && response.data != null) {
      await sl<ISessionService>().saveSession(
        accessToken: response.data!.accessToken,
        refreshToken: response.data!.refreshToken,
      );

      state = state.copyWith(
        isLoading: false,
        user: response.data?.user,
        error: response.status ? null : response.error,
      );
      return response;
    } else {
      state = state.copyWith(isLoading: false, error: response.error);
      return response;
    }
  }

  Future<BaseResponse<AuthResponse>> register(RegisterRequest request) async {
    state = state.copyWith(isLoading: true);
    final response = await _authRepository.register(request);
    if (response.status) {
      return response;
    } else {
      state = state.copyWith(isLoading: false, error: response.error);
      return response;
    }
  }

  Future<BaseResponse<UserModel>> getMe() async {
    state = state.copyWith(isLoading: true, error: null);
    final response = await _authRepository.getMe();
    if (response.status && response.data != null) {
      state = state.copyWith(isLoading: false, user: response.data);
      return response;
    } else {
      state = state.copyWith(isLoading: false, error: response.error);
      return response;
    }
  }

  Future<void> logout() async {
    await sl<ISessionService>().removeSession();
    state = const AuthState();
  }
}
