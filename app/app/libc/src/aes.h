#include <stddef.h>
#include <mbedtls/aes.h>

typedef struct {
    mbedtls_aes_context base;
} KyAES;

KyAES* KyAES_alloc();
void KyAES_init(KyAES *context);
int KyAES_setKeyForEncode(KyAES *context, unsigned char *key, unsigned int keybits);
int KyAES_setKeyForDecode(KyAES *context, unsigned char *key, unsigned int keybits);
int KyAES_encryptAtCBC(KyAES *context, unsigned char iv[16], 
    const unsigned char *input, size_t ilen, unsigned char *output);
int KyAES_decryptAtCBC(KyAES *context, unsigned char iv[16], 
    const unsigned char *input, size_t ilen, unsigned char *output);
void KyAES_free(KyAES *context);
