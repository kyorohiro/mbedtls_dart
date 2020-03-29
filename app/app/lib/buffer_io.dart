import 'dart:ffi' as ffi;

import 'dart:typed_data';

import 'package:info.kyorohiro.mbedtls/buffer.dart';

typedef KyBuffer_alloc_func = ffi.Pointer<ffi.Uint8> Function(ffi.Uint64);
typedef KyBuffer_alloc = ffi.Pointer<ffi.Uint8> Function(int);

typedef KyBuffer_free_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> buffer);
typedef KyBuffer_free = void Function(ffi.Pointer<ffi.Uint8> buffer);

class RawBuffer {
  final ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open('/app/libc/libmd5.so');
  KyBuffer_alloc _raw_alloc;
  KyBuffer_free _raw_free ;
  
  RawBuffer(){
    _raw_alloc = dylib
        .lookup<ffi.NativeFunction<KyBuffer_alloc_func>>('KyBuffer_alloc')
        .asFunction();

    _raw_free = dylib
        .lookup<ffi.NativeFunction<KyBuffer_free_func>>('KyBuffer_free')
        .asFunction();
  }

  int alloc(int len) {
    return _raw_alloc(len).address;
  }

  Uint8List get_buffer(int pointer, int len) {
    return ffi.Pointer<ffi.Uint8>.fromAddress(pointer).asTypedList(len);
  }

  void free(int pointer){
    _raw_free(ffi.Pointer.fromAddress(pointer));
  }
}

RawBuffer raw = RawBuffer();
class KyBufferIo extends Buffer {
  ffi.Pointer<ffi.Uint8> _rawBuffer;
  Uint8List _buffer;
  int _len;

  KyBufferIo(int len):super(len) {
    _len = len;
    _rawBuffer = raw._raw_alloc(len);
    _buffer = _rawBuffer.asTypedList(len);
  }

  ffi.Pointer<ffi.Uint8> get rawBuffer => _rawBuffer;

  @override
  Uint8List get buffer => _buffer;

  @override
  int get len => _len;

  @override
  void dispose(){
    if(_rawBuffer != null) {
      raw._raw_free(_rawBuffer);
    }
    _rawBuffer = null;
  }
}