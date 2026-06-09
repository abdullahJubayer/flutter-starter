import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'native_bridge_loader.dart';

// =============================================================================
// HOW TO ADD ANOTHER NATIVE METHOD:
// =============================================================================
// 1. C++ Side (src/native_bridge.cpp):
//    Add your C++ function inside the `extern "C"` block.
//    Example:
//      __attribute__((visibility("default"))) __attribute__((used))
//      int32_t native_add(int32_t a, int32_t b) { return a + b; }
//
// 2. Dart Bindings (Here):
//    - Define the C function signature using FFI types (e.g. Int32, Pointer<Utf8>).
//    - Define the matching Dart signature using standard Dart types.
//    - Look up the function in the library using `_lib.lookup`.
//    - Expose a public static Dart wrapper function.
// =============================================================================

// FFI Signatures (C-types mapping to Dart-types)
typedef NativeGetSecretC = Pointer<Utf8> Function();
typedef NativeGetSecretDart = Pointer<Utf8> Function();

typedef NativeFreeStringC = Void Function(Pointer<Utf8> str);
typedef NativeFreeStringDart = void Function(Pointer<Utf8> str);

class NativeBridge {
  NativeBridge._();

  // Lazy load the dynamic library using our platform-specific loader
  static final DynamicLibrary _lib = openNativeLibrary();

  // Look up native functions
  static final NativeGetSecretDart _getSecret = _lib
      .lookup<NativeFunction<NativeGetSecretC>>('native_get_secret')
      .asFunction<NativeGetSecretDart>();

  static final NativeFreeStringDart _freeString = _lib
      .lookup<NativeFunction<NativeFreeStringC>>('native_free_string')
      .asFunction<NativeFreeStringDart>();

  /// Retrieves the native secret compiled in the native binary.
  /// 
  /// Automatically manages memory safety by releasing the native-allocated 
  /// string using the FFI bridge cleanup.
  static String getSecret() {
    final resultPtr = _getSecret();
    try {
      return resultPtr.toDartString();
    } finally {
      if (resultPtr != nullptr) {
        _freeString(resultPtr); // Free dynamic C-string copy to prevent memory leaks
      }
    }
  }
}
