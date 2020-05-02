// 
// gcc main_hash.c  /usr/local/lib/libmbedcrypto.a 
//
#include "sha512.h"
#include "mbedtls/sha512.h"
#include <stdlib.h>
#include <stddef.h>

KySHA512* KySHA512_alloc() {
    return malloc(sizeof(KySHA512));
}
void KySHA512_init(KySHA512 *context){
    mbedtls_sha1_init((mbedtls_sha512_context*)context);
}
void KySHA512_starts(KySHA512 *context) {
    mbedtls_sha1_starts((mbedtls_sha512_context*)context);
}
void KySHA512_update(KySHA512 *context, const unsigned char *input, size_t ilen) {
    mbedtls_sha1_update((mbedtls_sha512_context*)context, input, ilen);
}
void KySHA512_end(KySHA512 *context, unsigned char output[64]){
    mbedtls_sha1_finish((mbedtls_sha512_context*)context, output);
}
void KySHA512_free(KySHA512 *context) {
    free(context);
}

