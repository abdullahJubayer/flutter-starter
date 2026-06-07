import 'package:flutter_template/feature/auth/domain/model/auth_response.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';
import 'package:flutter_template/feature/auth/domain/model/login_request.dart';
import 'package:flutter_template/feature/auth/domain/model/register_request.dart';
import 'package:flutter_template/feature/auth/domain/model/user_model.dart';

abstract class AuthRepository {
  Future<BaseResponse<AuthResponse>> login(LoginRequest request);

  Future<void> register(RegisterRequest request);

  Future<BaseResponse<AuthResponse>> refreshToken(String token);

  Future<BaseResponse<UserModel>> getMe();
}
