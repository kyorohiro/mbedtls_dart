// 
// gcc main_hash.c -lmbedcrypto 
// // gcc main_hash.c -lmbedtls -lmbedcrypto -lmbedx509
//
#include<stdio.h>
#include "mbedtls/md5.h"
#include "mbedtls/sha256.h"
#include "mbedtls/platform.h"
int main(int argc, char const *argv[])
{
    {
    printf("MD5\n");
    unsigned char digest[16];
    mbedtls_md5_ret((unsigned char*)"hello",3, digest);
    for(int i=0;i<16;i++){
        mbedtls_printf("%02x",digest[i]);
    }
    mbedtls_printf("\n");
    }
    {
    printf("SHA256\n");
    unsigned char digest[32];
    mbedtls_sha256_ret((unsigned char*)"hello",3, digest, 0);
    for(int i=0;i<32;i++){
        mbedtls_printf("%02x",digest[i]);
    }
    mbedtls_printf("\n");
    }
}
