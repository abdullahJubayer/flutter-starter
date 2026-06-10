import 'package:flutter_template/core/network/api_client.dart';
import 'package:flutter_template/core/utils/extension/network_extension.dart';
import 'package:flutter_template/feature/auth/domain/model/auth_response.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';
import 'package:flutter_template/feature/auth/domain/model/login_request.dart';
import 'package:flutter_template/feature/auth/domain/model/register_request.dart';
import 'package:flutter_template/feature/auth/domain/model/refresh_token_request.dart';
import 'package:flutter_template/feature/auth/domain/model/user_model.dart';
import 'package:flutter_template/feature/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl(this._apiClient);

  @override
  Future<BaseResponse<AuthResponse>> login(LoginRequest request) {
    return _apiClient.login(request).guardCall();
  }

  @override
  Future<BaseResponse<AuthResponse>> register(RegisterRequest request) {
    return _apiClient.register(request).guardCall();
  }

  @override
  Future<BaseResponse<AuthResponse>> refreshToken(String token) {
    return _apiClient.refreshToken(RefreshTokenRequest(refreshToken: token)).guardCall();
  }

  @override
  Future<BaseResponse<UserModel>> getMe() {
    return _apiClient.getMe().guardCall();
  }
}
