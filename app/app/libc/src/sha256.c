// 
// gcc main_hash.c  /usr/local/lib/libmbedcrypto.a 
//
#include "sha256.h"
#include "mbedtls/sha256.h"
#include <stdlib.h>
#include <stddef.h>

KySHA256* KySHA256_alloc() {
    return malloc(sizeof(KySHA256));
}
void KySHA256_init(KySHA256 *context){
    mbedtls_sha256_init((mbedtls_sha256_context*)context);
}
void KySHA256_starts(KySHA256 *context) {
    mbedtls_sha256_starts((mbedtls_sha256_context*)context, 0);
}
void KySHA256_update(KySHA256 *context, const unsigned char *input, size_t ilen) {
    mbedtls_sha256_update((mbedtls_sha256_context*)context, input, ilen);
}
void KySHA256_end(KySHA256 *context, unsigned char output[32]){
    mbedtls_sha256_finish((mbedtls_sha256_context*)context, output);
}
void KySHA256_free(KySHA256 *context) {
    free(context);
}

