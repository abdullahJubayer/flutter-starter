import 'package:flutter_template/feature/auth/domain/model/auth_response.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';
import 'package:flutter_template/feature/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<BaseResponse<AuthResponse>> call({
    required String email,
    required String password,
    required String phone,
  }) {
    return _repository.login(
      email: email,
      password: password,
      phone: phone,
    );
  }
}

