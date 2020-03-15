library info.kyorohiro.mbedtls;

import 'dart:ffi' as ffi;

ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open("/usr/local/lib/libmbedcrypto.a");
