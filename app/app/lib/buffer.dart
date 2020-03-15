import 'dart:ffi' as ffi;

import 'dart:typed_data';

ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open('/app/libc/md5.so');
typedef KyBuffer_new_func = ffi.Pointer<ffi.Uint8> Function(ffi.Uint64);
typedef KyBuffer_new = ffi.Pointer<ffi.Uint8> Function(int);

typedef KyBuffer_free_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> buffer);
typedef KyBuffer_free = void Function(ffi.Pointer<ffi.Uint8> buffer);


final KyBuffer_new newRawBuffer = dylib
    .lookup<ffi.NativeFunction<KyBuffer_new_func>>('KyBuffer_new')
    .asFunction();

final KyBuffer_free freeRawBuffer = dylib
    .lookup<ffi.NativeFunction<KyBuffer_free_func>>('KyBuffer_free')
    .asFunction();


class Buffer {
  ffi.Pointer<ffi.Uint8> _rawBuffer;

  Buffer.newBuffer(int len) {
    _rawBuffer = newRawBuffer(len);
  }

  void dispose(){
    if(_rawBuffer != null) {
      freeRawBuffer(_rawBuffer);
    }
    _rawBuffer = null;
  }
}