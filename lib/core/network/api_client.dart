import 'package:dio/dio.dart';
import 'package:flutter_template/feature/auth/data/dto/login_request_dto.dart';
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

  @POST("auth/register")
  Future<void> register(@Body() AuthResponse request);

  @POST("auth/register")
  Future<BaseResponse<AuthResponse>> login(@Body() LoginRequestDto request);

}
