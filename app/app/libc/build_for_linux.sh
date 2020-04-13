#!/bin/sh

find . -name "*.o" | xargs rm
gcc -Wall -Werror -fpic -I. -c buffer.c -o buffer.o 
gcc -Wall -Werror -fpic -I. -c md5.c -o md5.o
gcc -shared -o libkycrypt.so md5.o buffer.o /usr/local/lib/libmbedcrypto.a 

