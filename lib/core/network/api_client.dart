import 'package:dio/dio.dart';
import 'package:flutter_template/feature/auth/domain/model/auth_response.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@LazySingleton()
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST("login")
  Future<BaseResponse<AuthResponse>> login(@Body() Map<String, dynamic> map);

  @POST("register")
  Future<BaseResponse<AuthResponse>> register(@Body() Map<String, dynamic> map);

  @POST("email/verify")
  Future<BaseResponse<AuthResponse>> verifyOtp(
    @Body() Map<String, dynamic> map,
  );
}
