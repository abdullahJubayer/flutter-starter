# flutter_template

A Flutter project template with clean authentication architecture, automatic token refresh, comprehensive logging, and session management.

---

## 📋 Table of Contents

1. [Requirements](#-requirements)
2. [Project Setup](#-project-setup)
3. [Environment Configuration](#-environment-configuration)
4. [Architecture Overview](#-architecture-overview)
5. [App Startup Process](#-app-startup-process)
6. [Authentication & Token Flow](#-authentication--token-flow)
7. [Token Storage](#-token-storage)
8. [Logger Usage](#-logger-usage)
9. [NDK Native Secret](#-ndk-native-secret)
10. [Device Preview](#-device-preview)
11. [Security Gate](#-security-gate)
12. [Libraries Used](#-libraries-used)
13. [Best Practices](#-best-practices)
14. [Additional Resources](#-additional-resources)

---

## ✅ Requirements

| Tool    | Minimum Version |
|---------|----------------|
| Flutter | 3.19.0         |
| Dart    | 3.3.0          |

### Check Current Versions

```bash
flutter --version
dart --version
```

---

## 🚀 Project Setup

### Step 1 — Install FVM (Flutter Version Manager)

FVM lets you manage multiple Flutter SDK versions per project.

```bash
# macOS / Linux
brew tap leoafonso/fvm
brew install fvm

# Windows
choco install fvm
```

### Step 2 — Pin the Flutter Version

```bash
fvm install 3.19.0
fvm use 3.19.0
```

> If the project has an `.fvmrc` file, run `fvm use` and it picks the version automatically.

### Step 3 — Install Dependencies

```bash
fvm flutter pub get
```

### Step 4 — Run the App

```bash
fvm flutter run
```

> Replace every `flutter` command with `fvm flutter` throughout the project to use the pinned version.

---

## 🔐 Environment Configuration

The project uses `envied` to embed environment variables at build time. Environment files live under `environments/`:

| File | Purpose |
|------|---------|
| `environments/.env.dev` | Development values (git-ignored) |
| `environments/.env.prod` | Production values (git-ignored) |
| `environments/.env.example` | Committed template for teammates |

### Step 1 — Copy the example file

```bash
cp environments/.env.example environments/.env.dev
# Fill in your values
```

### Step 2 — Generate for Development

```bash
dart run build_runner build --delete-conflicting-outputs \
  --define=envied_generator:envied=path=environments/.env.dev
```

### Step 3 — Run or Build (Dev)

```bash
flutter run
flutter build apk --debug
```

### Step 4 — Generate for Production

```bash
dart run build_runner build --delete-conflicting-outputs \
  --define=envied_generator:envied=path=environments/.env.prod
```

### Step 5 — Build Release Artifacts

```bash
flutter build apk --release
flutter build ios --release
```

> Re-run the matching `build_runner` command each time env values change.

---

## 🧱 Architecture Overview

The template follows clean architecture, separating UI, domain, and data layers.

```
Presentation / UI
  └─ feature/auth/ui/login/login_screen.dart
        ↓
State / Controller
  └─ feature/auth/ui/provider/auth_notifier.dart
        ↓
Domain
  └─ feature/auth/domain/usecase/login_usecase.dart
  └─ feature/auth/domain/repository/auth_repository.dart
        ↓
Data
  └─ feature/auth/data/repository/auth_repository_impl.dart
  └─ feature/auth/data/datasource/auth_remote_data_source_impl.dart
        ↓
Network
  └─ core/network/api_client.dart  →  Backend API
```

### Layer Responsibilities

| Layer | File | Responsibility |
|-------|------|----------------|
| UI | `login_screen.dart` | Collects input, validates form, reacts to state |
| State | `auth_notifier.dart` | Controls loading state, orchestrates login call |
| Domain | `login_usecase.dart` | Contains the business logic for login |
| Contract | `auth_repository.dart` | Defines the interface for auth operations |
| Data | `auth_repository_impl.dart` | Implements the contract, delegates to datasource |
| Remote | `auth_remote_data_source.dart` | Performs the actual API call |
| Network | `api_client.dart` | Defines Retrofit endpoints |

### Login Request Flow

```
LoginScreen
  → validates form input
  → calls AuthNotifier.login(...)
  → LoginUseCase
  → AuthRepository
  → AuthRemoteDataSource
  → ApiClient / Dio
  → API response
  → state update (loading / success / error)
  → toast or navigation
```

---

## ⚡ App Startup Process

Startup is split across `main.dart`, `bootstrapper_app.dart`, and `my_app.dart`.

```
main.dart
  → WidgetsFlutterBinding.ensureInitialized()
  → BootstrapperApp.init()
  → bootstrap.loadAppConfig()        ← reads saved theme & locale before first frame
  → ProviderScope(overrides: appConfigProvider)
  → MyApp
  → MaterialApp.router(builder: FToastBuilder + optional DEV banner)
```

**Why `loadAppConfig()` runs before rendering:** it reads the saved theme and locale from storage so the very first frame already reflects the user's preferences — no flash of default styles.

**Why `ProviderScope` uses `overrides`:** it injects the loaded `AppConfig` into `appConfigProvider`, making the initial theme and locale available to all Riverpod providers from the start.

**Why `FToastBuilder` is in the root builder:** it keeps toast support app-wide without adding setup to every screen, and also injects the `DEV` banner in non-production builds — both handled in one place.

---

## 🔐 Authentication & Token Flow

### Refresh Token Flow

Once login succeeds, tokens are stored and all subsequent requests are protected by the Dio interceptor.

```
API Request
  ↓
Add Authorization header (if token exists)
  ↓
Send Request
  ↓
401 Unauthorized?
  ├─ YES → Has Refresh Token?
  │         ├─ YES → Call refresh endpoint
  │         │         ├─ Success → Save new tokens → Retry original request
  │         │         └─ Failed  → Remove session → Show session expired dialog
  │         └─ NO  → Show session expired dialog
  └─ NO  → Return response normally
```

### How Each Step Works

**Step 1 — Interceptor catches 401:**

```dart
@override
void onError(DioException err, ErrorInterceptorHandler handler) async {
  final statusCode = err.response?.statusCode;

  if (statusCode == 401 && requestOptions.extra['retried'] != true) {
    // Attempt token refresh
  }
}
```

**Step 2 — Retrieve the refresh token:**

```dart
final refreshToken = await _secureStorage.read(key: CoreConstants.refreshTokenKey);
if (refreshToken == null || refreshToken.isEmpty) {
  return handler.next(err); // No refresh token, propagate error
}
```

**Step 3 — Call the refresh endpoint:**

```dart
// A separate Dio instance (no interceptors) prevents infinite loops
final refreshDio = Dio(BaseOptions(baseUrl: requestOptions.baseUrl));
final resp = await refreshDio.post(
  CoreConstants.refreshTokenEndpoint,
  data: {'refreshToken': refreshToken},
);
```

**Step 4 — Save new tokens:**

```dart
if (resp.statusCode == 200) {
  final data = resp.data as Map<String, dynamic>;
  final newAccessToken = data['accessToken'] as String? ?? '';
  final newRefreshToken = data['refreshToken'] as String?;

  await _sharePref.setData(CoreConstants.accessTokenKey, newAccessToken);
  await _secureStorage.write(key: CoreConstants.refreshTokenKey, value: newRefreshToken);
}
```

**Step 5 — Retry the original request:**

```dart
requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
requestOptions.extra['retried'] = true; // Prevents infinite refresh loop
final response = await _dio.fetch(requestOptions);
return handler.resolve(response);
```

**Step 6 — Handle refresh failure:**

```dart
catch (e) {
  logger.e(tag: 'Token Refresh', error: e, message: 'Refresh token failed');
  try {
    await _sessionService.removeSession();
  } catch (_) {}
  // Session expired dialog is shown next
}
```

### Session Expired Dialog

When refresh fails, a non-dismissible dialog guides the user back to login:

```dart
void sessionExpireDialog() async {
  final context = appRouter.navigatorKey.currentContext;
  if (context != null && context.mounted) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => SessionExpireDialog(
        onConfirm: () {
          Navigator.pop(context);
          appRouter.replaceAll([const LoginRoute()]);
        },
      ),
    );
  }
}
```

Dialog features: non-dismissible, clear "Session Expired" message, single OK button, redirects to login on confirm.

---

## 🔒 Token Storage

| Token | Storage | Reason |
|-------|---------|--------|
| Access Token | `SharedPreferences` | Short-lived, less sensitive |
| Refresh Token | `Flutter Secure Storage` | Long-lived, highly sensitive |

```dart
// Read access token
final accessToken = await sharePref.getData(CoreConstants.accessTokenKey);

// Read refresh token
final refreshToken = await secureStorage.read(key: CoreConstants.refreshTokenKey);
```

---

## 📝 Logger Usage

The project includes a custom logger that works in debug mode and is silenced in release mode.

### Log Levels

```dart
import 'package:flutter_template/core/logger/app_logging.dart';

logger.d(message: 'Checking token validity', tag: 'Token');          // Debug
logger.i(message: 'User login successful', tag: 'Auth');              // Info
logger.w(message: 'Token expiring in < 5 minutes', tag: 'Token');     // Warning
logger.e(
  error: Exception('Network timeout'),
  message: 'Failed to fetch user data',
  tag: 'Network',
  stackTrace: StackTrace.current,
);                                                                     // Error
```

### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `message` | `String?` | The log message |
| `tag` | `String?` | Category for filtering (e.g. `'Auth'`, `'Network'`) |
| `error` | `Object?` | Associated exception |
| `stackTrace` | `StackTrace?` | Stack trace for debugging |

### API Request/Response Logging

The Dio interceptor automatically logs all network activity:

```
🔥 API Request - [API Request]
  Url: https://api.example.com/login
  Headers: {"Authorization": "Bearer token..."}
  Data: {"email": "user@example.com", "password": "***"}

✅ API Response - [API Response]
  Url: https://api.example.com/login
  Response: {"statusCode": 200, "accessToken": "...", "refreshToken": "..."}

❌ API Error - [API Error]
  Url: https://api.example.com/data
  Status Code: 401
  Error: Unauthorized
```

### Log Behavior by Build Mode

| Mode | Behavior |
|------|---------|
| Debug | All levels logged to console |
| Release | Logging disabled (`Level.OFF`) |

> Logger is initialized in `BootstrapperApp` via `await initLogger()`.

---

## 🔑 NDK Native Secret

Sensitive keys can be embedded in the native C/C++ layer (Android NDK / iOS xcframework), keeping them out of Dart source and making extraction harder.

> ⚠️ **This is obfuscation, not true security.** Keys in binaries can still be extracted with reverse-engineering tools (Ghidra, Hopper, strings). Never treat client-side secrets as truly confidential.

### Step 1 — Create the Secret Header

```bash
mkdir -p ndk_secret
cat > ndk_secret/secrets.h <<'EOF'
#ifndef SECRETS_H
#define SECRETS_H

inline const char* get_native_secret() {
    return "YOUR_SECURE_KEY_HERE";
}

#endif
EOF
```

### Step 2 — Create the Native Bridge (C++)

```cpp
#include <cstring>
#include <cstdlib>
#include "secrets.h"

extern "C"
char* native_get_secret() {
    const char* secret = get_native_secret();
    size_t len = strlen(secret) + 1;
    char* result = (char*) malloc(len);
    if (result) {
        snprintf(result, len, "%s", secret);
    }
    return result;
}
```

### Step 3 — Call from Dart via FFI

```dart
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

typedef NativeGetSecret = Pointer<Utf8> Function();
typedef DartGetSecret = Pointer<Utf8> Function();

class NativeBridge {
  static final DynamicLibrary _lib = Platform.isAndroid
      ? DynamicLibrary.open("libnative_bridge.so")
      : DynamicLibrary.process();

  static final DartGetSecret _getSecret = _lib
      .lookup<NativeFunction<NativeGetSecret>>('native_get_secret')
      .asFunction();

  static String getSecret() {
    final ptr = _getSecret();
    return ptr.toDartString();
  }
}
```

### Step 4 — Build

```bash
# Android
flutter clean
flutter pub get
flutter run

# iOS
./scripts/build_ios.sh
cd ios && pod install && cd ..
flutter run
```

---

## 🖥️ Device Preview

`device_preview` lets you preview the app across different screen sizes directly from a debug build.

- Package: https://pub.dev/packages/device_preview
- **Active in:** debug / profile builds
- **Disabled in:** release builds

### Integration Points

`main.dart`:
```dart
DevicePreview(
  enabled: !kReleaseMode,
  builder: (context) => const MyApp(),
)
```

`my_app.dart` (`MaterialApp.router`):
```dart
useInheritedMediaQuery: true,
builder: DevicePreview.appBuilder,
locale: DevicePreview.locale(context) ?? locale,
```

### Usage

Run in debug mode (`flutter run`) — a Device Preview panel appears on the side. Pick any device, orientation, or locale to test your layout.

> **Troubleshooting:** If simulated sizes don't appear, verify `useInheritedMediaQuery: true` and `DevicePreview.appBuilder` are both set (they are by default in this template).

---

## 🛡️ Security Gate

`SafeDevice` runs lightweight checks at startup (release only) to reduce risk on compromised devices.

- Package: https://pub.dev/packages/safe_device
- **Active in:** release builds only

### What It Checks

| Check | Platform |
|-------|----------|
| Root / Jailbreak status | Android & iOS |
| Real device vs emulator | Android & iOS |
| Developer mode enabled | Android |
| Mock location enabled | Android |

### Behavior by Build Mode

| Mode | Device Preview | Security Gate |
|------|---------------|---------------|
| Debug / Profile | ✅ ON | ❌ Not enforced |
| Release | ❌ OFF | ✅ Enforced |

### iOS Note

`safe_device` is pinned to `1.1.6` in `pubspec.yaml` to avoid a known Xcode compile issue in newer versions. If you hit an Xcode error after upgrading, run:

```bash
flutter clean
rm -rf ios/Pods ios/Podfile.lock
cd ios && pod repo update && pod install && cd ..
flutter pub get
```

### Key Files

- `lib/core/app/security_gate.dart` — guard logic and warning UI
- `lib/core/app/my_app.dart` — composes `SecurityGate` around `MaterialApp.router`

---

## 📚 Libraries Used

### State Management
`flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`, `riverpod_lint`

### Dependency Injection
`get_it`, `injectable`, `injectable_generator`

### Networking
`dio`, `retrofit`, `retrofit_generator`

### Storage & Environment
`shared_preferences`, `flutter_secure_storage`, `flutter_secure_dotenv`, `flutter_secure_dotenv_generator`

### Routing & Localization
`auto_route`, `auto_route_generator`, `flutter_localizations`

### UI & Utilities
`flutter_svg`, `lottie`, `fluttertoast`, `google_fonts`, `cached_network_image`, `url_launcher`, `path_provider`, `skeletonizer`, `flutter_widget_from_html`, `flutter_expandable_fab`, `font_awesome_flutter`, `intl`, `collection`, `logging`, `logger`

---

## ✅ Best Practices

1. **Always use the project logger** — never `print()` or `log()`
2. **Add meaningful tags** to every logger call for easy filtering
3. **Include stack traces** when logging errors
4. **Never log sensitive data** — no passwords, no full tokens
5. **Use the right log level:**
   - `d()` — debug info during development
   - `i()` — important events (user actions, key state changes)
   - `w()` — unusual behavior or degraded performance
   - `e()` — exceptions and failures

---

## 📦 Key File Reference

| File | Path |
|------|------|
| Login Screen | `lib/feature/auth/ui/login/login_screen.dart` |
| Auth Notifier | `lib/feature/auth/ui/provider/auth_notifier.dart` |
| Login Use Case | `lib/feature/auth/domain/usecase/login_usecase.dart` |
| Auth Repository | `lib/feature/auth/domain/repository/auth_repository.dart` |
| Auth Repository Impl | `lib/feature/auth/data/repository/auth_repository_impl.dart` |
| Auth Remote Datasource | `lib/feature/auth/data/datasource/auth_remote_data_source.dart` |
| API Client | `lib/core/network/api_client.dart` |
| Dio Interceptor | `lib/core/network/interceptor.dart` |
| Logger | `lib/core/logger/app_logging.dart` |
| Session Expire Dialog | `lib/core/widget/session_expire_dialog.dart` |
| App Routes | `lib/core/app_route/app_route.dart` |
| Constants | `lib/core/constants/core_constants.dart` |
| Security Gate | `lib/core/app/security_gate.dart` |

---

## 🔗 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dio](https://pub.dev/packages/dio)
- [Auto Route](https://pub.dev/packages/auto_route)
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
- [Logging Package](https://pub.dev/packages/logging)
- [Device Preview](https://pub.dev/packages/device_preview)
- [Safe Device](https://pub.dev/packages/safe_device)