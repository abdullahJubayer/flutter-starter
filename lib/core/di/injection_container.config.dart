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

import '../../feature/auth/data/repository/auth_repository_impl.dart' as _i648;
import '../../feature/auth/domain/repository/auth_repository.dart' as _i884;
import '../../feature/auth/domain/usecase/login_usecase.dart' as _i460;
import '../auth/i_session_service.dart' as _i842;
import '../auth/session_service.dart' as _i205;
import '../network/api_client.dart' as _i557;
import '../network/socket_service.dart' as _i917;
import '../storage/i_local_storage_service.dart' as _i385;
import '../storage/local_storage_service.dart' as _i744;
import '../storage/secure_storage_service.dart' as _i666;
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
    gh.singleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.singleton<_i385.ILocalStorageService>(
      () => _i666.SecureStorageService(gh<_i558.FlutterSecureStorage>()),
      instanceName: 'secure',
    );
    gh.lazySingleton<_i385.ILocalStorageService>(
      () => _i744.SharedPreferencesService(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i842.ISessionService>(
      () => _i205.SessionService(
        secureStorage: gh<_i385.ILocalStorageService>(instanceName: 'secure'),
      ),
    );
    gh.singleton<_i361.Dio>(
      () => registerModule.dio(gh<_i842.ISessionService>()),
    );
    gh.lazySingleton<_i917.SocketService>(
      () => _i917.SocketService(gh<_i842.ISessionService>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i557.ApiClient>(() => _i557.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i884.AuthRepository>(
      () => _i648.AuthRepositoryImpl(gh<_i557.ApiClient>()),
    );
    gh.factory<_i460.LoginUseCase>(
      () => _i460.LoginUseCase(gh<_i884.AuthRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i835.RegisterModule {}
