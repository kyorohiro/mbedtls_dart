import 'dart:ffi' as ffi;

import 'dart:typed_data';

import 'package:info.kyorohiro.mbedtls/buffer_io.dart';
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha1.dart' as ky;

typedef KySHA1_alloc_func = ffi.Pointer<ffi.Uint8> Function();
typedef KySHA1_alloc = ffi.Pointer<ffi.Uint8> Function();

typedef KySHA1_free_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KySHA1_free = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KySHA1_init_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KySHA1_init = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KySHA1_starts_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KySHA1_starts = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KySHA1_update_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> input, ffi.Int32 len);
typedef KySHA1_update = void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> input, int len);

typedef KySHA1_end_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> outout);
typedef KySHA1_end = void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> outout);

class RawSHA1 {
  KySHA1_alloc _allocRawSHA1;
  KySHA1_free _freeRawSHA1;
  KySHA1_free _initRawSHA1;
  KySHA1_free _startRawSHA1;
  KySHA1_update _updateRawSHA1;
  KySHA1_end _endRawSHA1;

  RawSHA1(ffi.DynamicLibrary dylib) {
    _allocRawSHA1 = dylib
      .lookup<ffi.NativeFunction<KySHA1_alloc_func>>('KySHA1_alloc')
      .asFunction();
    _freeRawSHA1 = dylib
      .lookup<ffi.NativeFunction<KySHA1_free_func>>('KySHA1_free')
      .asFunction();
    _initRawSHA1 = dylib
      .lookup<ffi.NativeFunction<KySHA1_init_func>>('KySHA1_init')
      .asFunction();
    _startRawSHA1 = dylib
      .lookup<ffi.NativeFunction<KySHA1_free_func>>('KySHA1_starts')
      .asFunction();
    _updateRawSHA1 = dylib
      .lookup<ffi.NativeFunction<KySHA1_update_func>>('KySHA1_update')
      .asFunction();
    _endRawSHA1 = dylib
      .lookup<ffi.NativeFunction<KySHA1_end_func>>('KySHA1_end')
      .asFunction();
  }

  ffi.Pointer<ffi.Uint8> alloc() {
    return _allocRawSHA1();
  }

  void init(ffi.Pointer<ffi.Uint8> _context){
    _initRawSHA1(_context);
  }

  void start(ffi.Pointer<ffi.Uint8> _context){
    _startRawSHA1(_context);
  }

  void update(ffi.Pointer<ffi.Uint8> _context,ky.Buffer buffer,int len){
    _updateRawSHA1(_context, (buffer as BufferIo).rawBuffer,len);
  }

  void end(ffi.Pointer<ffi.Uint8> _context, ky.Buffer buffer){
    _endRawSHA1(_context, (buffer as BufferIo).rawBuffer);
  }

  void free(ffi.Pointer<ffi.Uint8> _context){
    _freeRawSHA1(_context);
  }
}


class SHA1BuilderIO extends ky.SHA1Builder {
  RawSHA1 _raw;
  SHA1BuilderIO (final ffi.DynamicLibrary dylib){
    _raw = RawSHA1(dylib);
  }
  @override
  ky.SHA1 create(){
    return SHA1Io(_raw);
  }
}

class SHA1Io extends ky.SHA1{
  ffi.Pointer<ffi.Uint8> _context;
  final RawSHA1 _raw;
  SHA1Io(this._raw){
    _context = _raw.alloc();
    _raw.init(_context);
    starts();
  }

  @override
  void starts(){
    _raw.start(_context);
  }

  @override
  void update(ky.Buffer buffer,int len){
    _raw.update(_context, buffer, len);
  }

  @override
  void end(ky.Buffer buffer){
    _raw.end(_context, buffer);
  }

  @override
  void despose(){
    _raw.free(_context);
  }
}

