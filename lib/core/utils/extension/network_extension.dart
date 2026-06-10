
import 'package:flutter_template/core/network/api_exception_mapper.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';

extension SafeCall on Future<dynamic> {
  Future<BaseResponse<T>> guardCall<T>() async {
    try {
      return await this as BaseResponse<T>;
    } catch (e, st) {
      return ApiExceptionMapper.toBaseResponse<T>(e, st);
    }
  }
}