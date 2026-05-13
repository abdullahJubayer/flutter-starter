import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'i_session_service.dart';
import '../constants/core_constants.dart';
import '../storage/i_local_storage_service.dart';

/// Implementation of [ISessionService] for managing authentication tokens.
/// Clears both access tokens (from shared preferences) and refresh tokens (from secure storage).
@LazySingleton(as: ISessionService)
class SessionService implements ISessionService {
  final ILocalStorageService _localStorageService;
  final FlutterSecureStorage _secureStorage;

  SessionService({
    required ILocalStorageService localStorageService,
    required FlutterSecureStorage secureStorage,
  })  : _localStorageService = localStorageService,
        _secureStorage = secureStorage;

  @override
  Future<void> saveSession({String? accessToken, String? refreshToken}) async {
    if (accessToken != null) {
      await _localStorageService.setData(CoreConstants.accessTokenKey, accessToken);
    }
    if (refreshToken != null) {
      await _secureStorage.write(key: CoreConstants.refreshTokenKey, value: refreshToken);
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return _localStorageService.getData(CoreConstants.accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return _secureStorage.read(key: CoreConstants.refreshTokenKey);
  }

  @override
  Future<void> removeSession() async {
    try {
      // Remove access token from shared preferences
      await _localStorageService.remove(CoreConstants.accessTokenKey);
    } catch (_) {}

    try {
      // Remove refresh token from secure storage
      await _secureStorage.delete(key: CoreConstants.refreshTokenKey);
    } catch (_) {}
  }
}

