#include <stddef.h>
#include <mbedtls/sha512.h>

typedef struct {
    mbedtls_sha512_context base;
} KySHA512;

// 20byte
KySHA512* KySHA512_alloc();
void KySHA512_init(KySHA512 *context);
void KySHA512_starts(KySHA512 *context);
void KySHA512_update(KySHA512 *context, const unsigned char *input, size_t ilen);
void KySHA512_end(KySHA512 *context, unsigned char output[64]);
void KySHA512_free(KySHA512 *context);
