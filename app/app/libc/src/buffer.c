#include <stddef.h>
#include <malloc.h>
#include "buffer.h"

KyBuffer* KyBuffer_alloc(size_t len){
    return (KyBuffer*)malloc(len);
}

void KyBuffer_free(KyBuffer* buffer){
    free(buffer);
}