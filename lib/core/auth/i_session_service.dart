/// Service for managing user session (authentication tokens).
abstract class ISessionService {
  /// Save session data.
  Future<void> saveSession({String? accessToken, String? refreshToken});

  /// Get access token.
  Future<String?> getAccessToken();

  /// Get refresh token.
  Future<String?> getRefreshToken();

  /// Remove all session data (access and refresh tokens).
  /// Call this when session expires or user logs out.
  Future<void> removeSession();
}

