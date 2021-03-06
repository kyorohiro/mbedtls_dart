// 
// gcc -Wall -Werror -fpic -I. -c main_aes_ecb.c -o main_aes_ecb.o 
// gcc main_aes_ecb.o /usr/local/lib/libmbedcrypto.a  
//
#include<mbedtls/aes.h>
#include<stdio.h>
#include<string.h> // memset

int hex(unsigned char  datam);
int hex2bytes(unsigned char* input, int len, unsigned char* output);
int bytes2hex(unsigned char* input, int len, unsigned char* output);

void encrypt(){
    printf("\n--enc--\n");
    unsigned char key[32];
    unsigned char buffer[16] = "helloworld012345";//16bytes
    unsigned char output[16];
    unsigned char outputHex[16*2+1];

    int inputLen = sizeof(buffer);
    printf("inputLen=%d\n",inputLen);
    int outputLen = 16;//(inputLen/16 + 1) * 16;
    memset(output, 0, outputLen);
    memset(key, 0, 32);

    // 32 bytes
    hex2bytes((unsigned char*)"2b7e151628aed2a6abf7158809cf4f3c2b7e151628aed2a6abf7158809cf4f3c", 64, key);

    mbedtls_aes_context context;
    mbedtls_aes_init(&context);
    mbedtls_aes_setkey_enc(&context, key, 256 );
    {
        int ret  = mbedtls_aes_crypt_ecb(&context, MBEDTLS_AES_ENCRYPT, buffer, output);
        bytes2hex(output, 16, outputHex);
        outputHex[32]='\0';
        printf("-e->%s<--\n",output);
        printf("-e->%s<--\n",outputHex);
        printf("-e->%d<--\n",ret);
    }
    {
        int ret  = mbedtls_aes_crypt_ecb(&context, MBEDTLS_AES_ENCRYPT, buffer, output);
        bytes2hex(output, 16, outputHex);
        outputHex[32]='\0';
        printf("-e->%s<--\n",output);
        printf("-e->%s<--\n",outputHex);
        printf("-e->%d<--\n",ret);
    }
    mbedtls_aes_free(&context);
}

void dencrypt(){
    printf("\n--dec--\n");
    unsigned char key[32];
    unsigned char buffer[32];//16bytes
    unsigned char output[17];
    unsigned char outputHex[16*2+1];

    int outputLen = 16;
    memset(output, 0, outputLen);
    memset(key, 0, 32);

    // 16 bytes
    hex2bytes((unsigned char*)"bbcebf78673fccf2dfce4e4c6034517e", 32, buffer);
    // 32 bytes    
    hex2bytes((unsigned char*)"2b7e151628aed2a6abf7158809cf4f3c2b7e151628aed2a6abf7158809cf4f3c", 64, key);

    mbedtls_aes_context context;
    mbedtls_aes_init(&context);
    mbedtls_aes_setkey_dec(&context, key, 256 );
    int ret  = mbedtls_aes_crypt_ecb(&context, MBEDTLS_AES_DECRYPT, buffer, output);
    bytes2hex(output, 16, outputHex);
    output[16]='\0';
    outputHex[32]='\0';
    printf("-d->%s<--\n",output);
    printf("-d->%s<--\n",outputHex);
    printf("-d->%d<--\n",ret);
    mbedtls_aes_free(&context);
}


int main()
{
    encrypt();
    dencrypt();
}


int hex(unsigned char  datam) {
    if( '0'<= datam  && datam <= '9') {
        return datam - '0';
    } else if ( 'a'<= datam  && datam <= 'f') {
        return datam - 'a' + 10;
    } else if ( 'A'<= datam  && datam <= 'F') {
        return datam - 'A' + 10;
    } else {
        // failed to convert
        return -1;
    }  
}

int hex2bytes(unsigned char* input, int len, unsigned char* output) {
    if(len %2 == 1) {
        return -2;
    }

    for(int i=0,o=0;i<len;i+=2,o++) {
        int v1 = hex(input[i+0]);
        if(v1 < 0) {
            return -1;
        }
        int v2 = hex(input[i+1]);
        if(v2 < 0) {
            return -1;
        }
        output[o] =  (0xFF & (v1<<4)) | (0xFF & v2);
    }
    return 0;
}


int bytes2hex(unsigned char* input, int len, unsigned char* output) {
    for(int i=0,o=0;i<len;i++,o+=2) {
        unsigned char datam = input[i];
        int v1 = 0x0F & (datam >> 4);
        int v2 = 0x0F & datam;
        output[o] = (v1 <10?'0'+v1:(v1-10)+'a');
        output[o+1] = (v2 <10?'0'+v2:(v2-10)+'a');
        output[o+2] = '\0';
    }

    return 0;
}