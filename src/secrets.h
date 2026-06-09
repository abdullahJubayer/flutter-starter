#ifndef SECRETS_H
#define SECRETS_H

// Secure native secret store.
// Storing keys in compiled C/C++ binaries makes them significantly harder 
// to reverse-engineer compared to obfuscated Java/Dart code.
inline const char* get_native_secret() {
    return "NATIVE_SECURE_API_KEY_xyz987654321_PROD";
}

#endif
