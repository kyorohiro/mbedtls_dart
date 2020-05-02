// 
// gcc main_hash.c  /usr/local/lib/libmbedcrypto.a 
//
#include "md5.h"
#include "mbedtls/md5.h"
#include <stdlib.h>
#include <stddef.h>

KyMD5* KyMd5_alloc(){
    return malloc(sizeof(KyMD5));
}

void KyMd5_init(KyMD5 *context){
    mbedtls_md5_init((mbedtls_md5_context*)context);
}

void KyMd5_starts(KyMD5 *context){
    mbedtls_md5_starts((mbedtls_md5_context*)context);
}
void KyMd5_update(KyMD5 *context, const unsigned char *input, size_t ilen){
    mbedtls_md5_update((mbedtls_md5_context*)context, input, ilen);
}

void KyMd5_end(KyMD5 *context, unsigned char output[16]){
    mbedtls_md5_finish((mbedtls_md5_context*)context, output);
}

void KyMd5_free(KyMD5 *context){
    free(context);
}