import 'dart:ffi';
import 'dart:io' show Platform;

DynamicLibrary openNativeLibrary() {
  if (Platform.isAndroid) {
    return DynamicLibrary.open('libnative_bridge.so');
  }

  if (Platform.isIOS) {
    try {
      return DynamicLibrary.open('native_bridge.framework/native_bridge');
    } catch (_) {
      try {
        return DynamicLibrary.open('Frameworks/native_bridge.framework/native_bridge');
      } catch (_) {
        return DynamicLibrary.process();
      }
    }
  }

  throw UnsupportedError(
    'Native FFI is only supported on Android and iOS in this template.',
  );
}

