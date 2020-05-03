// 
// gcc -Wall -Werror -fpic -I. -c main_aes.c -o main_aes.o 
// gcc main_aes.o /usr/local/lib/libmbedcrypto.a  
//
#include<mbedtls/aes.h>
#include<stdio.h>
#include<string.h> // memset

int hex(unsigned char  datam);
int hex2bytes(unsigned char* input, int len, unsigned char* output);
int bytes2hex(unsigned char* input, int len, unsigned char* output);

void encrypt(){
    printf("\n--enc--\n");
    unsigned char iv[16];
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
    // 16 bytes
    hex2bytes((unsigned char*)"000102030405060708090a0b0c0d0e0f", 32, iv);

    mbedtls_aes_context context;
    mbedtls_aes_init(&context);
    mbedtls_aes_setkey_enc(&context, key, 256 );
    {
        int ret  = mbedtls_aes_crypt_cbc(&context, MBEDTLS_AES_ENCRYPT, inputLen, iv, buffer, output);
        bytes2hex(output, 16, outputHex);
        outputHex[32]='\0';
        printf("-e->%s<--\n",output);
        printf("-e->%s<--\n",outputHex);
        printf("-e->%d<--\n",ret);
    }
    {
        int ret  = mbedtls_aes_crypt_cbc(&context, MBEDTLS_AES_ENCRYPT, inputLen, iv, buffer, output);
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
    unsigned char iv[16];
    unsigned char key[32];
    unsigned char buffer[32];//16bytes
    unsigned char output[17];
    unsigned char outputHex[16*2+1];

    int inputLen = sizeof(buffer);
    int outputLen = 16;
    memset(output, 0, outputLen);
    memset(key, 0, 32);

    // 16 bytes
    hex2bytes((unsigned char*)"bbcebf78673fccf2dfce4e4c6034517e", 32, buffer);
    //hex2bytes((unsigned char*)"bbcebf78673fccf2dfce4e4c6034517e0000000000000000000000000000000000", 64, buffer);
    //hex2bytes((unsigned char*)"bbcebf78673fccf2dfce4e4c6034517e53e57bc89768c968f12e79bee1ddc03d", 64, buffer);
    // 32 bytes    
    hex2bytes((unsigned char*)"2b7e151628aed2a6abf7158809cf4f3c2b7e151628aed2a6abf7158809cf4f3c", 64, key);
    // 16 bytes
    hex2bytes((unsigned char*)"000102030405060708090a0b0c0d0e0f", 32, iv);

    mbedtls_aes_context context;
    mbedtls_aes_init(&context);
    mbedtls_aes_setkey_dec(&context, key, 256 );
    int ret  = mbedtls_aes_crypt_cbc(&context, MBEDTLS_AES_DECRYPT, inputLen, iv, buffer, output);
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
/*
int main()
{
    mbedtls_aes_context aes;
    mbedtls_aes_context aes2;

    unsigned char key[16] = "itzkbgulrcsjmnv";
    key[15] = 'x';

    unsigned char iv[16] = {0xb2, 0x4b, 0xf2, 0xf7, 0x7a, 0xc5, 0xec, 0x0c, 0x5e, 0x1f, 0x4d, 0xc1, 0xae, 0x46, 0x5e, 0x75};

    const unsigned char *input = (const unsigned char*) "Some string to b";
    unsigned char output[128] = {0};
    unsigned char output2[128] = {0};

    mbedtls_aes_setkey_enc( &aes, key, 16*8 );
    mbedtls_aes_crypt_cbc( &aes, MBEDTLS_AES_ENCRYPT, strlen((const char*)input), iv, input, output );

    mbedtls_aes_setkey_dec( &aes2, key, 16*8 );
    mbedtls_aes_crypt_cbc( &aes2, MBEDTLS_AES_DECRYPT, strlen((const char*)output), iv, output, output2 );
    printf("%s",output2);
}
*/
//
//
//

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