import 'package:dio/dio.dart';
import 'package:flutter_template/feature/auth/domain/model/auth_response.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';
import 'package:flutter_template/feature/auth/domain/model/login_request.dart';
import 'package:flutter_template/feature/auth/domain/model/register_request.dart';
import 'package:flutter_template/feature/auth/domain/model/refresh_token_request.dart';
import 'package:flutter_template/feature/auth/domain/model/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@LazySingleton()
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST("auth/register")
  Future<BaseResponse<AuthResponse>> register(@Body() RegisterRequest request);

  @POST("auth/login")
  Future<BaseResponse<AuthResponse>> login(@Body() LoginRequest request);

  @POST("auth/refresh")
  Future<BaseResponse<AuthResponse>> refreshToken(@Body() RefreshTokenRequest request);

  @GET("auth/me")
  Future<BaseResponse<UserModel>> getMe();
}
