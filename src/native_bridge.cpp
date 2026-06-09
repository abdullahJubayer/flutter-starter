#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "secrets.h"

extern "C" {
    // -------------------------------------------------------------
    // Secret Retrieval Method
    // -------------------------------------------------------------

    // Exposes the secret stored in secrets.h.
    // Memory is allocated dynamically and must be freed by calling native_free_string.
    __attribute__((visibility("default"))) __attribute__((used))
    char* native_get_secret() {
        const char* secret = get_native_secret();
        size_t len = strlen(secret) + 1;
        char* result = (char*)malloc(len);
        if (result != nullptr) {
            snprintf(result, len, "%s", secret);
        }
        return result;
    }

    // Free the string allocated by native functions to prevent memory leaks.
    __attribute__((visibility("default"))) __attribute__((used))
    void native_free_string(char* str) {
        free(str);
    }
}
