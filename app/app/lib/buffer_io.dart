import 'dart:ffi' as ffi;

import 'dart:typed_data';

import 'package:info.kyorohiro.mbedtls/buffer.dart';

typedef KyBuffer_alloc_func = ffi.Pointer<ffi.Uint8> Function(ffi.Uint64);
typedef KyBuffer_alloc = ffi.Pointer<ffi.Uint8> Function(int);

typedef KyBuffer_free_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> buffer);
typedef KyBuffer_free = void Function(ffi.Pointer<ffi.Uint8> buffer);

class RawBuffer {
  //final ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open('/app/libc/libmd5.so');
  KyBuffer_alloc _alloc;
  KyBuffer_free _free ;
  
  RawBuffer(final ffi.DynamicLibrary dylib){
    _alloc = dylib
        .lookup<ffi.NativeFunction<KyBuffer_alloc_func>>('KyBuffer_alloc')
        .asFunction();

    _free = dylib
        .lookup<ffi.NativeFunction<KyBuffer_free_func>>('KyBuffer_free')
        .asFunction();
  }

  KyBuffer_alloc get rawAlloc => _alloc;
  KyBuffer_free get rawFree => _free;

  int alloc(int len) {
    return _alloc(len).address;
  }

  Uint8List get_buffer(int pointer, int len) {
    return ffi.Pointer<ffi.Uint8>.fromAddress(pointer).asTypedList(len);
  }

  void free(int pointer){
    _free(ffi.Pointer.fromAddress(pointer));
  }
}

class BufferBuilder {
  RawBuffer _raw;
  BufferBuilder(final ffi.DynamicLibrary dylib){
    _raw = RawBuffer(dylib);
  }
  Buffer create(int len) {
    return KyBufferIo(_raw, len);
  }
}

class KyBufferIo extends Buffer {
  ffi.Pointer<ffi.Uint8> _rawBuffer;
  Uint8List _buffer;
  int _len;
  final RawBuffer _raw;

  KyBufferIo(this._raw, int len):super(len) {
    _len = len;
    _rawBuffer = _raw._alloc(len);
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
      _raw._free(_rawBuffer);
    }
    _rawBuffer = null;
  }
}