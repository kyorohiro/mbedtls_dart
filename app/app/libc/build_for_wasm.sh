#!/bin/bash

find . -name "*.o" | xargs rm
find . -name "*.wasm" | xargs rm
emcc buffer.c -o buffer.o 
emcc md5.c -o md5.o -I/works/mbedtls-2.16.5/include/
emcc buffer.o md5.o -o kycrypt.js -lmbedcrypto  -L/works/mbedtls-2.16.5/library -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' -s EXPORTED_FUNCTIONS="['_KyBuffer_alloc','_KyBuffer_free']"

cat kycrypt_buffer.js >> kycrypt.js
cp kycrypt.js ../web/kycrypt.js
cp kycrypt.wasm ../web/kycrypt.wasm
