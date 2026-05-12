class CoreConstants {
  static const String defaultLanguageCode = 'en';

  // Key used to store selected language code in local storage
  static const String languageCodeKey = 'language_code';
  // Access token key (stored in shared preferences)
  static const String accessTokenKey = 'access_token';
  // Refresh token key (stored in secure storage)
  static const String refreshTokenKey = 'refresh_token';
  // Refresh token endpoint (adjust to your backend)
  static const String refreshTokenEndpoint = '/auth/refresh';
}
