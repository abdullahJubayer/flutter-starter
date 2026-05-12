import 'package:flutter_template/core/network/api_client.dart';
import 'package:flutter_template/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_template/feature/auth/data/dto/login_request_dto.dart';
import 'package:flutter_template/feature/auth/domain/model/auth_response.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<BaseResponse<AuthResponse>> login(LoginRequestDto request) {
    return _apiClient.login(request.toJson());
  }
}

