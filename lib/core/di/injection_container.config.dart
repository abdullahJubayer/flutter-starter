// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'package:flutter_template/core/auth/i_session_service.dart' as _i842;
import 'package:flutter_template/core/auth/session_service.dart' as _i205;
import 'package:flutter_template/core/network/api_client.dart' as _i557;
import 'package:flutter_template/core/network/dio_client.dart' as _i667;
import 'package:flutter_template/core/storage/i_local_storage_service.dart'
    as _i385;
import 'package:flutter_template/feature/auth/data/datasource/auth_remote_data_source.dart'
    as _i837;
import 'package:flutter_template/feature/auth/data/datasource/auth_remote_data_source_impl.dart'
    as _i775;
import 'package:flutter_template/feature/auth/data/repository/auth_repository_impl.dart'
    as _i902;
import 'package:flutter_template/feature/auth/domain/repository/auth_repository.dart'
    as _i441;
import 'package:flutter_template/feature/auth/domain/usecase/login_usecase.dart'
    as _i913;
import 'injection_modules.dart' as _i835;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i205.SessionService>(() => registerModule.sessionService);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i667.DioClient>(
      () => _i667.DioClient(
        sharePerf: gh<_i385.ILocalStorageService>(),
        sessionService: gh<_i842.ISessionService>(),
      ),
    );
    gh.lazySingleton<_i557.ApiClient>(() => _i557.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i837.AuthRemoteDataSource>(
      () => _i775.AuthRemoteDataSourceImpl(apiClient: gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i441.AuthRepository>(
      () => _i902.AuthRepositoryImpl(
        remoteDataSource: gh<_i837.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i913.LoginUseCase>(
      () => _i913.LoginUseCase(gh<_i441.AuthRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i835.RegisterModule {}
