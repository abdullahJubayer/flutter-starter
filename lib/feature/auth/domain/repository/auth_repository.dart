import 'package:flutter_template/feature/auth/domain/model/auth_response.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';

abstract class AuthRepository {
  Future<BaseResponse<AuthResponse>> login({
    required String email,
    required String password,
    required String phone,
  });

  Future<BaseResponse<AuthResponse>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
  });

  Future<BaseResponse<AuthResponse>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<BaseResponse<AuthResponse>> resendVerification({
    required String email,
  });
}
