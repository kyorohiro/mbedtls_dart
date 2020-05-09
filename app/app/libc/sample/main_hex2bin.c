#include<mbedtls/aes.h>
#include<stdio.h>
#include<string.h> // memset

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
int hex2bytes(char* input, int len, char* output) {
    if(len %2 == 1) {
        return -2;
    }

    for(int i=0,o=0;i<len;i+=2,o++) {
        unsigned char datam = input[i];
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
    }
    return 0;
}

int main(int argc, char const *argv[])
{
    printf("Hello, World!!\n");
    unsigned char input[] = "ABCDef";
    unsigned char output[sizeof(input)/2];
    hex2bytes(input, 6, output);
    for(int i=0;i<3;i++) {
        printf("%x\n", output[i]);
    }
    bytes2hex(output, 3, input);
    printf("%s\n", input);

    return 0;
}