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
    mbedtls_sha1_init((mbedtls_sha256_context*)context);
}
void KySHA256_starts(KySHA256 *context) {
    mbedtls_sha1_starts((mbedtls_sha256_context*)context);
}
void KySHA256_update(KySHA256 *context, const unsigned char *input, size_t ilen) {
    mbedtls_sha1_update((mbedtls_sha256_context*)context, input, ilen);
}
void KySHA256_end(KySHA256 *context, unsigned char output[20]){
    mbedtls_sha1_finish((mbedtls_sha256_context*)context, output);
}
void KySHA256_free(KySHA256 *context) {
    free(context);
}

