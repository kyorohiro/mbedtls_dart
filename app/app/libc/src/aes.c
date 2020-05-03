
#include <stddef.h>
#include <stdlib.h>
#include <mbedtls/aes.h>
#include <aes.h>

KyAES* KyAES_alloc() {
    return malloc(sizeof(KyAES));
}

void KyAES_init(KyAES *context) {
    mbedtls_aes_init((mbedtls_aes_context*)context);
}

int  KyAES_setKeyForEncode(KyAES *context, unsigned char *key, unsigned int keybits){
    return mbedtls_aes_setkey_enc((mbedtls_aes_context*)context, key, keybits);
}

int  KyAES_setKeyForDecode(KyAES *context, unsigned char *key, unsigned int keybits){
    return mbedtls_aes_setkey_dec((mbedtls_aes_context*)context, key, keybits);
}

int KyAES_encryptAtCBC(KyAES *context, unsigned char iv[16], 
    const unsigned char *input, size_t ilen, unsigned char *output) {
    return mbedtls_aes_crypt_cbc((mbedtls_aes_context*)context, MBEDTLS_AES_ENCRYPT, ilen, iv, input, output);
}

int KyAES_decryptAtCBC(KyAES *context, unsigned char iv[16], 
    const unsigned char *input, size_t ilen, unsigned char *output) {
    return mbedtls_aes_crypt_cbc((mbedtls_aes_context*)context, MBEDTLS_AES_DECRYPT, ilen, iv, input, output);
}

void KyAES_free(KyAES *context) {
    mbedtls_aes_free((mbedtls_aes_context*)context);
}
