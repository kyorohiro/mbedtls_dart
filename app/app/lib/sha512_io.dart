import 'dart:ffi' as ffi;

import 'dart:typed_data';

import 'package:info.kyorohiro.mbedtls/buffer_io.dart';
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha512.dart' as ky;

typedef KySHA512_alloc_func = ffi.Pointer<ffi.Uint8> Function();
typedef KySHA512_alloc = ffi.Pointer<ffi.Uint8> Function();

typedef KySHA512_free_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KySHA512_free = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KySHA512_init_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KySHA512_init = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KySHA512_starts_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KySHA512_starts = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KySHA512_update_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> input, ffi.Int32 len);
typedef KySHA512_update = void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> input, int len);

typedef KySHA512_end_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> outout);
typedef KySHA512_end = void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> outout);

class RawSHA512 {
  KySHA512_alloc _allocRawSHA512;
  KySHA512_free _freeRawSHA512;
  KySHA512_free _initRawSHA512;
  KySHA512_free _startRawSHA512;
  KySHA512_update _updateRawSHA512;
  KySHA512_end _endRawSHA512;

  RawSHA512(ffi.DynamicLibrary dylib) {
    _allocRawSHA512 = dylib
      .lookup<ffi.NativeFunction<KySHA512_alloc_func>>('KySHA512_alloc')
      .asFunction();
    _freeRawSHA512 = dylib
      .lookup<ffi.NativeFunction<KySHA512_free_func>>('KySHA512_free')
      .asFunction();
    _initRawSHA512 = dylib
      .lookup<ffi.NativeFunction<KySHA512_init_func>>('KySHA512_init')
      .asFunction();
    _startRawSHA512 = dylib
      .lookup<ffi.NativeFunction<KySHA512_free_func>>('KySHA512_starts')
      .asFunction();
    _updateRawSHA512 = dylib
      .lookup<ffi.NativeFunction<KySHA512_update_func>>('KySHA512_update')
      .asFunction();
    _endRawSHA512 = dylib
      .lookup<ffi.NativeFunction<KySHA512_end_func>>('KySHA512_end')
      .asFunction();
  }

  ffi.Pointer<ffi.Uint8> alloc() {
    return _allocRawSHA512();
  }

  void init(ffi.Pointer<ffi.Uint8> _context){
    _initRawSHA512(_context);
  }

  void start(ffi.Pointer<ffi.Uint8> _context){
    _startRawSHA512(_context);
  }

  void update(ffi.Pointer<ffi.Uint8> _context,ky.Buffer buffer,int len){
    _updateRawSHA512(_context, (buffer as BufferIo).rawBuffer,len);
  }

  void end(ffi.Pointer<ffi.Uint8> _context, ky.Buffer buffer){
    _endRawSHA512(_context, (buffer as BufferIo).rawBuffer);
  }

  void free(ffi.Pointer<ffi.Uint8> _context){
    _freeRawSHA512(_context);
  }
}


class SHA512BuilderIO extends ky.SHA512Builder {
  RawSHA512 _raw;
  SHA512BuilderIO (final ffi.DynamicLibrary dylib){
    _raw = RawSHA512(dylib);
  }
  @override
  ky.SHA512 create(){
    return SHA512Io(_raw);
  }
}

class SHA512Io extends ky.SHA512{
  ffi.Pointer<ffi.Uint8> _context;
  final RawSHA512 _raw;
  SHA512Io(this._raw){
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

