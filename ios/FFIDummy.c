#include <stdint.h>

// Forward declaration of a symbol from our static library
extern char* native_get_secret(void);

// This dummy function references the static library symbol,
// forcing the linker to include native_bridge.o instead of stripping it.
void native_bridge_linker_keep_alive(void) {
    native_get_secret();
}
