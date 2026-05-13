class SecureEnv {
  Future<void> load({required String fileName}) async {
    // Intentionally minimal: the app reads env values through this facade.
    // The secure-dotenv package can be wired in here once its generated API
    // is available in the project.
  }

  Map<String, String> get env => {
    'BASE_URL': 'http://localhost:8080/',
    'NEW_URL': const String.fromEnvironment('BASE_URL', defaultValue: ''),
  };
}

final secureEnv = SecureEnv();
