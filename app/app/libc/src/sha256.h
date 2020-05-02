#include <stddef.h>
#include <mbedtls/sha256.h>

typedef struct {
    mbedtls_sha256_context base;
} KySHA256;

// 20byte
KySHA256* KySHA256_alloc();
void KySHA256_init(KySHA256 *context);
void KySHA256_starts(KySHA256 *context);
void KySHA256_update(KySHA256 *context, const unsigned char *input, size_t ilen);
void KySHA256_end(KySHA256 *context, unsigned char output[20]);
void KySHA256_free(KySHA256 *context);
