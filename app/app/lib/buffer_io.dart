import 'dart:ffi' as ffi;

import 'dart:typed_data';

import 'package:info.kyorohiro.mbedtls/buffer.dart';

ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open('/app/libc/libmd5.so');
typedef KyBuffer_alloc_func = ffi.Pointer<ffi.Uint8> Function(ffi.Uint64);
typedef KyBuffer_alloc = ffi.Pointer<ffi.Uint8> Function(int);

typedef KyBuffer_free_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> buffer);
typedef KyBuffer_free = void Function(ffi.Pointer<ffi.Uint8> buffer);


final KyBuffer_alloc alloc = dylib
    .lookup<ffi.NativeFunction<KyBuffer_alloc_func>>('KyBuffer_alloc')
    .asFunction();

final KyBuffer_free free = dylib
    .lookup<ffi.NativeFunction<KyBuffer_free_func>>('KyBuffer_free')
    .asFunction();


class KyBufferIo extends Buffer {
  ffi.Pointer<ffi.Uint8> _rawBuffer;
  Uint8List _buffer;
  int _len;

  KyBufferIo(int len):super(len) {
    _len = len;
    _rawBuffer = alloc(len);
    _buffer = _rawBuffer.asTypedList(len);
  }

  Uint8List get buffer => _buffer;
  ffi.Pointer<ffi.Uint8> get rawBuffer => _rawBuffer;

  @override
  int get len => _len;

  @override
  void dispose(){
    if(_rawBuffer != null) {
      free(_rawBuffer);
    }
    _rawBuffer = null;
  }
}