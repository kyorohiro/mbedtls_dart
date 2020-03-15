#include <stddef.h>
typedef void KyBuffer;
KyBuffer* KyBuffer_new(size_t len);
void KyBuffer_free(KyBuffer* buffer);
