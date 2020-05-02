import 'dart:ffi' as ffi;

import 'dart:typed_data';

import 'package:info.kyorohiro.mbedtls/buffer_io.dart';
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha256.dart' as ky;

typedef KySHA256_alloc_func = ffi.Pointer<ffi.Uint8> Function();
typedef KySHA256_alloc = ffi.Pointer<ffi.Uint8> Function();

typedef KySHA256_free_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KySHA256_free = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KySHA256_init_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KySHA256_init = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KySHA256_starts_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KySHA256_starts = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KySHA256_update_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> input, ffi.Int32 len);
typedef KySHA256_update = void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> input, int len);

typedef KySHA256_end_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> outout);
typedef KySHA256_end = void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> outout);

class RawSHA256 {
  KySHA256_alloc _allocRawSHA256;
  KySHA256_free _freeRawSHA256;
  KySHA256_free _initRawSHA256;
  KySHA256_free _startRawSHA256;
  KySHA256_update _updateRawSHA256;
  KySHA256_end _endRawSHA256;

  RawSHA256(ffi.DynamicLibrary dylib) {
    _allocRawSHA256 = dylib
      .lookup<ffi.NativeFunction<KySHA256_alloc_func>>('KySHA256_alloc')
      .asFunction();
    _freeRawSHA256 = dylib
      .lookup<ffi.NativeFunction<KySHA256_free_func>>('KySHA256_free')
      .asFunction();
    _initRawSHA256 = dylib
      .lookup<ffi.NativeFunction<KySHA256_init_func>>('KySHA256_init')
      .asFunction();
    _startRawSHA256 = dylib
      .lookup<ffi.NativeFunction<KySHA256_free_func>>('KySHA256_starts')
      .asFunction();
    _updateRawSHA256 = dylib
      .lookup<ffi.NativeFunction<KySHA256_update_func>>('KySHA256_update')
      .asFunction();
    _endRawSHA256 = dylib
      .lookup<ffi.NativeFunction<KySHA256_end_func>>('KySHA256_end')
      .asFunction();
  }

  ffi.Pointer<ffi.Uint8> alloc() {
    return _allocRawSHA256();
  }

  void init(ffi.Pointer<ffi.Uint8> _context){
    _initRawSHA256(_context);
  }

  void start(ffi.Pointer<ffi.Uint8> _context){
    _startRawSHA256(_context);
  }

  void update(ffi.Pointer<ffi.Uint8> _context,ky.Buffer buffer,int len){
    _updateRawSHA256(_context, (buffer as BufferIo).rawBuffer,len);
  }

  void end(ffi.Pointer<ffi.Uint8> _context, ky.Buffer buffer){
    _endRawSHA256(_context, (buffer as BufferIo).rawBuffer);
  }

  void free(ffi.Pointer<ffi.Uint8> _context){
    _freeRawSHA256(_context);
  }
}


class SHA256BuilderIO extends ky.SHA256Builder {
  RawSHA256 _raw;
  SHA256BuilderIO (final ffi.DynamicLibrary dylib){
    _raw = RawSHA256(dylib);
  }
  @override
  ky.SHA256 create(){
    return SHA256Io(_raw);
  }
}

class SHA256Io extends ky.SHA256{
  ffi.Pointer<ffi.Uint8> _context;
  final RawSHA256 _raw;
  SHA256Io(this._raw){
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

