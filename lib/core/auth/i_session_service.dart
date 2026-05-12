/// Service for managing user session (authentication tokens).
abstract class ISessionService {
  /// Remove all session data (access and refresh tokens).
  /// Call this when session expires or user logs out.
  Future<void> removeSession();
}

