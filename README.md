# flutter_template

A Flutter project template with a clean authentication architecture, automatic token refresh, comprehensive logging, and session management.

## Getting Started

This project is a starting point for a Flutter application with enterprise-level features.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---

## 🔧 Flutter & Dart Versions

This project requires specific Flutter and Dart versions for compatibility.

### Version Requirements

- **Flutter**: 3.19.0 or higher
- **Dart**: 3.3.0 or higher

### Check Current Versions

```bash
flutter --version
dart --version
```

### Using FVM (Flutter Version Manager)

FVM allows you to manage multiple Flutter SDK versions easily.

#### Install FVM

```bash
# Using Homebrew (macOS/Linux)
brew tap leoafonso/fvm
brew install fvm

# Using Chocolatey (Windows)
choco install fvm
```

#### Setup FVM in this Project

```bash
# Set Flutter version for this project
fvm install 3.19.0
fvm use 3.19.0

# Or use the `.fvmrc` file if it exists
fvm use
```

#### Run Flutter Commands with FVM

```bash
# Instead of: flutter pub get
fvm flutter pub get

# Instead of: flutter run
fvm flutter run

# Instead of: flutter build apk
fvm flutter build apk
```

## 📋 Features

- **Clean Architecture Auth Flow**: UI, domain, and data layers are separated for login and future auth features
- **Use Case Driven Login**: The login screen calls a Riverpod notifier, which calls a domain use case
- **Repository + Datasource Split**: The repository delegates to a remote datasource for API access
- **Automatic Token Refresh**: Seamlessly refresh access tokens without user intervention
- **Comprehensive Logging**: Structured logging for API requests, responses, and errors
- **Session Management**: Automatic session expiration handling with user-friendly dialogs
- **Dio Interceptor**: Request/response interception for authentication and logging
- **Secure Token Storage**: Flutter Secure Storage for sensitive credentials

---

## 📚 Libraries Used

The template uses a small set of packages grouped by responsibility:

### State Management
- `flutter_riverpod`
- `riverpod_annotation`
- `riverpod_generator`
- `riverpod_lint`

### Dependency Injection
- `get_it`
- `injectable`
- `injectable_generator`

### Networking
- `dio`
- `retrofit`
- `retrofit_generator`

### Storage and Secure Env
- `shared_preferences`
- `flutter_secure_storage`
- `flutter_secure_dotenv`
- `flutter_secure_dotenv_generator`

### Routing and Localization
- `auto_route`
- `auto_route_generator`
- `flutter_localizations`

### UI and Utilities
- `flutter_svg`
- `lottie`
- `fluttertoast`
- `google_fonts`
- `cached_network_image`
- `url_launcher`
- `path_provider`
- `skeletonizer`
- `flutter_widget_from_html`
- `flutter_expandable_fab`
- `font_awesome_flutter`
- `intl`
- `collection`
- `logging`
- `logger`

---

## 🧱 Architecture Overview

This template uses a clean architecture structure for auth and login:

```text
Presentation/UI
  └─ feature/auth/ui/login/login_screen.dart
       ↓
State/Controller
  └─ feature/auth/ui/provider/auth_notifier.dart
       ↓
Domain
  └─ feature/auth/domain/usecase/login_usecase.dart
       └─ feature/auth/domain/repository/auth_repository.dart
       ↓
Data
  └─ feature/auth/data/repository/auth_repository_impl.dart
       └─ feature/auth/data/datasource/auth_remote_data_source_impl.dart
            └─ core/network/api_client.dart
                 ↓
               Backend API
```

### Login Request Flow

```text
LoginScreen
  → validates form input
  → calls AuthNotifier.login(...)
  → LoginUseCase
  → AuthRepository
  → AuthRemoteDataSource
  → ApiClient / Dio
  → API response
  → state update (loading / success / error)
  → toast or navigation in the UI
```

### Layer Responsibilities

- **`login_screen.dart`**: collects input, validates the form, and reacts to success/error
- **`auth_notifier.dart`**: controls loading state and orchestrates the login call
- **`login_usecase.dart`**: contains the business action for login
- **`auth_repository.dart`**: defines the contract for auth operations
- **`auth_repository_impl.dart`**: implements the contract and delegates to data sources
- **`auth_remote_data_source.dart`**: performs the remote API call
- **`api_client.dart`**: defines the Retrofit endpoints

## 🚀 App Startup Process

The app startup flow is split between `lib/main.dart`, `lib/core/app/bootstrapper_app.dart`, and `lib/core/app/my_app.dart`.

### Startup sequence

```text
main.dart
  → WidgetsFlutterBinding.ensureInitialized()
  → BootstrapperApp.init()
  → bootstrap.loadAppConfig()
  → ProviderScope(overrides: appConfigProvider)
  → MyApp
  → MaterialApp.router(builder: FToastBuilder + optional DEV banner)
```

### Why `bootstrap.loadAppConfig()` is used

`bootstrap.loadAppConfig()` reads the saved theme and locale from storage before the app is rendered.
This means the first frame already respects the user’s preferences instead of briefly showing a default theme or language and then switching later.

### Why `ProviderScope` uses `overrides`

`ProviderScope` injects the loaded `AppConfig` into `appConfigProvider` through `overrides`.
That makes the initial theme and locale available to Riverpod providers immediately, so `themeProvider` and `localeProvider` can build the UI with the correct runtime values from the start.

### Why the `toastBuilder` approach is used

In `MyApp`, `MaterialApp.router` uses a `builder` that wraps the routed content with `FToastBuilder()`.
This keeps toast rendering available app-wide without needing to add toast setup to every screen.
The same builder also adds the `DEV` banner in non-production builds, so both toast support and environment labeling are handled in one place.

---

## 🔐 Secure Environment Setup

This template uses a secure environment workflow for API configuration and other sensitive values.

### Recommended workflow

1. Add the secure env dependencies in `pubspec.yaml`:

   ```yaml
   dependencies:
     flutter_secure_dotenv: ^2.0.0

   dev_dependencies:
     build_runner: ^2.4.14
     flutter_secure_dotenv_generator: ^2.0.0
   ```

2. Generate or receive the temporary `encryption_key.json` only as a transfer step.
3. Copy the key into a local gitignored env file such as `lib/core/config/env.dart`.
4. Delete `encryption_key.json` immediately after copying it, or keep it fully gitignored.
5. Keep the env access behind a small wrapper like `lib/core/config/secure_env.dart` so the rest of the app does not depend on raw key files.

### Important security note

- Never ship `encryption_key.json` inside the APK or IPA bundle.
- A JSON file in the app package is plaintext and can be extracted with a simple unzip.
- The key is still present in the compiled binary, so this only raises the effort required to recover it.
- `--obfuscate` can make extraction harder, but it cannot make client-side secrets impossible to find.
- For maximum protection, fetch the key from a server at runtime instead of bundling it with the app.

### Suggested ignore rules

```gitignore
encryption_key.json
lib/core/config/env.dart
```

---

## 📝 Logger Usage

The project includes a custom logging system that works in both debug and release modes.

### Basic Logger Usage

```dart
import 'package:flutter_template/core/logger/app_logging.dart';

// Info level logging
logger.i(
  message: 'User login successful',
  tag: 'Auth',
);

// Debug level logging
logger.d(
  message: 'Checking token validity',
  tag: 'Token',
);

// Warning level logging
logger.w(
  message: 'Token expiration time is less than 5 minutes',
  tag: 'Token',
);

// Error level logging
logger.e(
  error: Exception('Network timeout'),
  message: 'Failed to fetch user data',
  tag: 'Network',
  stackTrace: StackTrace.current,
);
```

### Logger Parameters

- **message** (String?): The log message content
- **tag** (String?): Category/tag for filtering logs (e.g., 'Auth', 'Network', 'API')
- **error** (Object?): Associated exception or error object
- **stackTrace** (StackTrace?): Stack trace for debugging

### API Request/Response Logging

The Dio interceptor automatically logs all API requests and responses:

```
🔥 API Request - [API Request]
  Url: https://api.example.com/login
  Headers: {"Authorization": "Bearer token..."}
  Data: {"email": "user@example.com", "password": "***"}
  Params: {}

✅ API Response - [API Response]
  Url: https://api.example.com/login
  Response: {"statusCode": 200, "accessToken": "new_token", "refreshToken": "refresh_token"}

❌ API Error - [API Error]
  Url: https://api.example.com/data
  Status Code: 401
  Error: Unauthorized
```

### Logger Configuration

The logger is initialized in the app's bootstrapper:

```dart
// In lib/core/app/bootstrapper_app.dart
await initLogger();
```

- **Debug Mode**: Logs all levels (DEBUG, INFO, WARNING, ERROR) to console
- **Release Mode**: Logging is disabled (Level.OFF)

---

## 🔐 Refresh Token Flow

The project implements an automatic token refresh mechanism to handle expired access tokens seamlessly.

This works alongside the login architecture above: once login succeeds, tokens are stored and later requests are protected by the interceptor.

### How It Works

```
API Request
    ↓
Add Authorization Header (if token exists)
    ↓
Send Request
    ↓
Response with 401 (Unauthorized)?
    ├─ YES → Has Refresh Token?
    │        ├─ YES → Call Refresh Endpoint
    │        │         ├─ Success → Get new tokens
    │        │         │            ├─ Save new Access Token
    │        │         │            ├─ Save new Refresh Token
    │        │         │            └─ Retry Original Request
    │        │         │
    │        │         └─ Failed → Remove Session
    │        │
    │        └─ NO → Show Session Expire Dialog
    │
    └─ NO → Return Response
```

### Step-by-Step Process

#### 1. **Interceptor Detects 401 Error**

```dart
@override
void onError(DioException err, ErrorInterceptorHandler handler) async {
  final statusCode = err.response?.statusCode;
  
  if (statusCode == 401 && requestOptions.extra['retried'] != true) {
    // Attempt token refresh
  }
}
```

#### 2. **Retrieve Refresh Token**

```dart
final refreshToken = await _secureStorage.read(key: CoreConstants.refreshTokenKey);
if (refreshToken == null || refreshToken.isEmpty) {
  return handler.next(err); // No refresh token available
}
```

#### 3. **Call Refresh Endpoint**

```dart
final refreshDio = Dio(BaseOptions(baseUrl: requestOptions.baseUrl));
final resp = await refreshDio.post(
  CoreConstants.refreshTokenEndpoint,
  data: {'refreshToken': refreshToken},
);
```

**Note**: A separate Dio instance without interceptors is used to prevent infinite loops.

#### 4. **Save New Tokens**

```dart
if (resp.statusCode == 200) {
  final data = resp.data as Map<String, dynamic>;
  final newAccessToken = data['accessToken'] as String? ?? '';
  final newRefreshToken = data['refreshToken'] as String?;

  // Save to storage
  await _sharePref.setData(CoreConstants.accessTokenKey, newAccessToken);
  await _secureStorage.write(key: CoreConstants.refreshTokenKey, value: newRefreshToken);
}
```

#### 5. **Retry Original Request**

```dart
requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
requestOptions.extra['retried'] = true;
final response = await _dio.fetch(requestOptions);
return handler.resolve(response);
```

The original request is retried with the new access token. The `retried` flag prevents infinite refresh loops.

#### 6. **Handle Refresh Failure**

If the refresh token is invalid or expired, the session is removed and a dialog is shown:

```dart
catch (e) {
  logger.e(
    tag: 'Token Refresh',
    error: e,
    message: 'Refresh token failed',
  );
  try {
    await _sessionService.removeSession();
  } catch (_) {}
}
```

### Session Expiration Dialog

When a 401 error occurs and token refresh fails, a user-friendly dialog appears:

```dart
void sessionExpireDialog() async {
  final context = appRouter.navigatorKey.currentContext;
  if (context != null && context.mounted) {
    showDialog(
      barrierDismissible: false, // User cannot dismiss by tapping outside
      context: context,
      builder: (BuildContext context) {
        return SessionExpireDialog(
          onConfirm: () {
            Navigator.pop(context);
            appRouter.replaceAll([const LoginRoute()]); // Navigate to login
          },
        );
      },
    );
  }
}
```

**SessionExpireDialog Features**:
- ✅ Non-dismissible (user must click OK)
- ✅ Clear message: "Session Expired"
- ✅ Instructions: "Your session has expired. Please login again."
- ✅ Single action button: "OK"
- ✅ Navigates to login screen on confirmation

---

## 🔄 Token Storage

Tokens are stored securely using different storage methods:

| Token Type | Storage Method | Location | Notes |
|------------|----------------|----------|-------|
| **Access Token** | SharedPreferences | `_sharePref` | Short-lived, less sensitive |
| **Refresh Token** | Flutter Secure Storage | `_secureStorage` | Long-lived, highly sensitive |

### Accessing Tokens

```dart
// Get Access Token
final accessToken = await sharePref.getData(CoreConstants.accessTokenKey);

// Get Refresh Token
final refreshToken = await secureStorage.read(key: CoreConstants.refreshTokenKey);
```

---

## 📦 Related Files

- **Login Screen**: `lib/feature/auth/ui/login/login_screen.dart`
- **Auth Notifier**: `lib/feature/auth/ui/provider/auth_notifier.dart`
- **Login Use Case**: `lib/feature/auth/domain/usecase/login_usecase.dart`
- **Auth Repository**: `lib/feature/auth/domain/repository/auth_repository.dart`
- **Auth Repository Impl**: `lib/feature/auth/data/repository/auth_repository_impl.dart`
- **Auth Remote Datasource**: `lib/feature/auth/data/datasource/auth_remote_data_source.dart`
- **Auth API Client**: `lib/core/network/api_client.dart`
- **Secure Env Helper**: `lib/core/config/secure_env.dart`
- **Interceptor**: `lib/core/network/interceptor.dart`
- **Logger**: `lib/core/logger/app_logging.dart`
- **Session Expire Dialog**: `lib/core/widget/session_expire_dialog.dart`
- **Routes**: `lib/core/app_route/app_route.dart`
- **Constants**: `lib/core/constants/core_constants.dart`

---

## 🚀 Best Practices

1. **Always use the logger** instead of `print()` or `log()`
2. **Add meaningful tags** to logger calls for easy filtering
3. **Include stack traces** when logging errors
4. **Never log sensitive data** like passwords or full tokens
5. **Use appropriate log levels**:
   - `d()` - Debug information during development
   - `i()` - Important information (user actions, key events)
   - `w()` - Warnings (unusual behavior, degraded performance)
   - `e()` - Errors (exceptions, failures)

---

## 📚 Additional Resources

- [Dio Documentation](https://pub.dev/packages/dio)
- [Auto Route Documentation](https://pub.dev/packages/auto_route)
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
- [Logging Package](https://pub.dev/packages/logging)

