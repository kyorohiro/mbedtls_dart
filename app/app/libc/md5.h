#include <stddef.h>
#include <mbedtls/md5.h>

typedef struct {
    mbedtls_md5_context base;
} KyMD5;

KyMD5* Md5_new();
void KyMd5_init(KyMD5 *context);
void KyMd5_start(KyMD5 *context);
void KyMD5_update(KyMD5 *context, const unsigned char *input, size_t ilen);
void KyMd5_end(KyMD5 *context, unsigned char output[16]);
void KyMd5_free(KyMD5 *context);
