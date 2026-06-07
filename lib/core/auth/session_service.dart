import 'package:injectable/injectable.dart';
import 'i_session_service.dart';
import '../constants/core_constants.dart';
import '../storage/i_local_storage_service.dart';

/// Implementation of [ISessionService] for managing authentication tokens.
/// Clears both access tokens (from shared preferences) and refresh tokens (from secure storage).
@Singleton(as: ISessionService)
class SessionService implements ISessionService {
  final ILocalStorageService _secureStorage;

  SessionService({
    @Named('secure')
    required ILocalStorageService secureStorage,
  }) : _secureStorage = secureStorage;

  @override
  Future<void> saveSession({String? accessToken, String? refreshToken}) async {
    if (accessToken != null) {
      await _secureStorage.setData(CoreConstants.accessTokenKey, accessToken);
    }
    if (refreshToken != null) {
      await _secureStorage.setData(CoreConstants.refreshTokenKey, refreshToken);
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return _secureStorage.getData(CoreConstants.accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return _secureStorage.getData(CoreConstants.refreshTokenKey);
  }

  @override
  Future<void> removeSession() async {
    try {
      // Remove access token from shared preferences
      await _secureStorage.remove(CoreConstants.accessTokenKey);
    } catch (_) {}

    try {
      // Remove refresh token from secure storage
      await _secureStorage.remove(CoreConstants.refreshTokenKey);
    } catch (_) {}
  }
}

