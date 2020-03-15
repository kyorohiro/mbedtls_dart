// 
// gcc main_hash.c  /usr/local/lib/libmbedcrypto.a 
//
#include "md5.h"
#include "mbedtls/md5.h"
#include <stdlib.h>
#include <stddef.h>
//#include <stdio.h>
//#include "mbedtls/sha256.h"
//#include "mbedtls/platform.h"


//typedef struct {
//    mbedtls_md5_context base;
//} KyMD5;

KyMD5* KyMd5_new(){
    return malloc(sizeof(KyMD5));
}

void KyMd5_init(KyMD5 *context){
    mbedtls_md5_init((mbedtls_md5_context*)context);
}

void KyMd5_start(KyMD5 *context){
    mbedtls_md5_starts((mbedtls_md5_context*)context);
}
void KyMD5_update(KyMD5 *context, const unsigned char *input, size_t ilen){
    mbedtls_md5_update((mbedtls_md5_context*)context, input, ilen);
}

void KyMd5_end(KyMD5 *context, unsigned char output[16]){
    mbedtls_md5_finish((mbedtls_md5_context*)context, output);
}

void KyMd5_free(KyMD5 *context){
    free(context);
}
/*

int main(int argc, char const *argv[])
{
    unsigned char digest[16];
    //
    mbedtls_md5_ret((unsigned char*)"hello",3, digest);
    for(int i=0;i<16;i++){
        mbedtls_printf("%02x",digest[i]);
    }
    mbedtls_printf("\n");
    //

    KyMD5* ctx;
    ctx = Md5_new();
    Md5_init(ctx);
    Md5_start(ctx);
    MD5_input(ctx, "he",2);
    MD5_input(ctx, "l",1);
    Md5_end(ctx,digest);
    Md5_free(ctx);
    for(int i=0;i<16;i++){
        mbedtls_printf("%02x",digest[i]);
    }
    mbedtls_printf("\n");
}

*/