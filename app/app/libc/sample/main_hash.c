// 
// gcc -Wall -Werror -fpic -I. -c main_hash.c -o main_hash.o
// gcc main_hash.o /usr/local/lib/libmbedcrypto.a  
//
#include<stdio.h>
#include "mbedtls/md5.h"
#include "mbedtls/sha256.h"
#include "mbedtls/platform.h"



int main(int argc, char const *argv[])
{
    {
        // MD5
        printf("MD5\n");
        unsigned char digest[16];
        mbedtls_md5_ret((unsigned char*)"hello",3, digest);
        for(int i=0;i<16;i++){
            printf("%02x",digest[i]);
        }
        printf("\n");
    }
    {
        // SHA256
        printf("SHA256\n");
        unsigned char digest[32];
        mbedtls_sha256_ret((unsigned char*)"hello",3, digest, 0);
        for(int i=0;i<32;i++){
            mbedtls_printf("%02x",digest[i]);
        }
        mbedtls_printf("\n");
    }
}

