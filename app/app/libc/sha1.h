#include <stddef.h>
#include <mbedtls/sha1.h>

typedef struct {
    mbedtls_sha1_context base;
} KySHA1;
// 20byte
KySHA1* KySHA1_alloc();
void KySHA1_init(KySHA1 *context);
void KySHA1_start(KySHA1 *context);
void KySHA1_update(KySHA1 *context, const unsigned char *input, size_t ilen);
void KySHA1_end(KySHA1 *context, unsigned char output[20]);
void KySHA1_free(KySHA1 *context);
