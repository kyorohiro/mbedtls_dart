// 
// gcc main_hash.c  /usr/local/lib/libmbedcrypto.a 
//
#include "sha1.h"
#include "mbedtls/sha1.h"
#include <stdlib.h>
#include <stddef.h>

KySHA1* KySHA1_alloc() {
    return malloc(sizeof(KySHA1));
}
void KySHA1_init(KySHA1 *context){
    mbedtls_sha1_init((mbedtls_sha1_context*)context);
}
void KySHA1_starts(KySHA1 *context) {
    mbedtls_sha1_starts((mbedtls_sha1_context*)context);
}
void KySHA1_update(KySHA1 *context, const unsigned char *input, size_t ilen) {
    mbedtls_sha1_update((mbedtls_sha1_context*)context, input, ilen);
}
void KySHA1_end(KySHA1 *context, unsigned char output[20]){
    mbedtls_sha1_finish((mbedtls_sha1_context*)context, output);
}
void KySHA1_free(KySHA1 *context) {
    free(context);
}

