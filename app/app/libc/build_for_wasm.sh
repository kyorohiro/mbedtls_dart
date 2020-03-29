#!/bin/bash

find . -name "*.o" | xargs rm
emcc buffer.c -o buffer.o -s EXPORTED_FUNCTIONS="['_KyBuffer_new','_KyBuffer_free']" -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' 
emcc md5.c -o md5.o -s EXPORTED_FUNCTIONS="['KyMd5_init','KyMd5_start','KyMD5_update','KyMd5_end','KyMd5_free']" -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' -I/works/mbedtls-2.16.5/include/
emcc buffer.o md5.o -o kycrypty.js -lmbedcrypto  -L/works/mbedtls-2.16.5/library 
