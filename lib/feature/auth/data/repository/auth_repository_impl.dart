import '../datasource/auth_remote_data_source.dart';
import '../dto/login_request_dto.dart';
import '../../domain/model/auth_response.dart';
import '../../domain/model/base_response.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<BaseResponse<AuthResponse>> login(
      {required String email,
      required String password,
      required String phone}) async {
    return _remoteDataSource.login(
      LoginRequestDto(email: email, password: password, phone: phone),
    );
  }

  @override
  Future<BaseResponse<AuthResponse>> register(
      {required String firstName,
      required String lastName,
      required String phone,
      required String email,
      required String password,
      required String passwordConfirmation,
      required String role}) async {
    return BaseResponse(status: false, message: 'Not implemented', data: null);
  }

  @override
  Future<BaseResponse<AuthResponse>> verifyOtp(
      {required String email, required String otp}) async {
    return BaseResponse(status: false, message: 'Not implemented', data: null);
  }

  @override
  Future<BaseResponse<AuthResponse>> resendVerification(
      {required String email}) async {
    return BaseResponse(status: false, message: 'Not implemented', data: null);
  }
}
