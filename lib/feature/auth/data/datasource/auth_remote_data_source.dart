import 'package:flutter_template/feature/auth/data/dto/login_request_dto.dart';
import 'package:flutter_template/feature/auth/domain/model/auth_response.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';

abstract class AuthRemoteDataSource {
  Future<BaseResponse<AuthResponse>> login(LoginRequestDto request);
}

