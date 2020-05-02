
KyBuffer_alloc = Module.cwrap('KyBuffer_alloc', 'number', ['number'])
KyBuffer_free = Module.cwrap('KyBuffer_free','number',["number"])
KyBuffer_get_buffer = function(index, len) {
    return new Uint8Array(Module.HEAP8.buffer, index, len);
}

KyMd5_alloc = Module.cwrap('KyMd5_alloc', 'number', [])
KyMd5_init = Module.cwrap('KyMd5_init', '', ['number'])
KyMd5_starts = Module.cwrap('KyMd5_starts', '', ['number'])
KyMd5_update = Module.cwrap('KyMd5_update', '', ['number','number','number'])
KyMd5_end = Module.cwrap('KyMd5_end', '', ['number','number'])
KyMd5_free = Module.cwrap('KyMd5_free', '', ['number','number'])


KySHA1_alloc = Module.cwrap('KySHA1_alloc', 'number', [])
KySHA1_init = Module.cwrap('KySHA1_init', '', ['number'])
KySHA1_starts = Module.cwrap('KySHA1_starts', '', ['number'])
KySHA1_update = Module.cwrap('KySHA1_update', '', ['number','number','number'])
KySHA1_end = Module.cwrap('KySHA1_end', '', ['number','number'])
KySHA1_free = Module.cwrap('KySHA1_free', '', ['number','number'])

KySHA256_alloc = Module.cwrap('KySHA256_alloc', 'number', [])
KySHA256_init = Module.cwrap('KySHA256_init', '', ['number'])
KySHA256_starts = Module.cwrap('KySHA256_starts', '', ['number'])
KySHA256_update = Module.cwrap('KySHA256_update', '', ['number','number','number'])
KySHA256_end = Module.cwrap('KySHA256_end', '', ['number','number'])
KySHA256_free = Module.cwrap('KySHA256_free', '', ['number','number'])

KySHA512_alloc = Module.cwrap('KySHA512_alloc', 'number', [])
KySHA512_init = Module.cwrap('KySHA512_init', '', ['number'])
KySHA512_starts = Module.cwrap('KySHA512_starts', '', ['number'])
KySHA512_update = Module.cwrap('KySHA512_update', '', ['number','number','number'])
KySHA512_end = Module.cwrap('KySHA512_end', '', ['number','number'])
KySHA512_free = Module.cwrap('KySHA512_free', '', ['number','number'])
