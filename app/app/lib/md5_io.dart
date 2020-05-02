import 'dart:ffi' as ffi;

import 'dart:typed_data';

import 'package:info.kyorohiro.mbedtls/buffer_io.dart';
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;
import 'package:info.kyorohiro.mbedtls/md5.dart' as ky;

typedef KyMd5_alloc_func = ffi.Pointer<ffi.Uint8> Function();
typedef KyMd5_alloc = ffi.Pointer<ffi.Uint8> Function();

typedef KyMd5_free_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KyMd5_free = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KyMd5_init_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KyMd5_init = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KyMd5_starts_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KyMd5_starts = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KyMd5_update_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> input, ffi.Int32 len);
typedef KyMd5_update = void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> input, int len);

typedef KyMd5_end_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> outout);
typedef KyMd5_end = void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> outout);

class RawMd5 {
  KyMd5_alloc _allocRawMd5;
  KyMd5_free _freeRawMd5;
  KyMd5_free _initRawMd5;
  KyMd5_free _startRawMd5;
  KyMd5_update _updateRawMd5;
  KyMd5_end _endRawMd5;

  RawMd5(ffi.DynamicLibrary dylib) {
    _allocRawMd5 = dylib
      .lookup<ffi.NativeFunction<KyMd5_alloc_func>>('KyMd5_alloc')
      .asFunction();
    _freeRawMd5 = dylib
      .lookup<ffi.NativeFunction<KyMd5_free_func>>('KyMd5_free')
      .asFunction();
    _initRawMd5 = dylib
      .lookup<ffi.NativeFunction<KyMd5_init_func>>('KyMd5_init')
      .asFunction();
    _startRawMd5 = dylib
      .lookup<ffi.NativeFunction<KyMd5_free_func>>('KyMd5_starts')
      .asFunction();
    _updateRawMd5 = dylib
      .lookup<ffi.NativeFunction<KyMd5_update_func>>('KyMd5_update')
      .asFunction();
    _endRawMd5 = dylib
      .lookup<ffi.NativeFunction<KyMd5_end_func>>('KyMd5_end')
      .asFunction();
  }

  ffi.Pointer<ffi.Uint8> alloc() {
    return _allocRawMd5();
  }

  void init(ffi.Pointer<ffi.Uint8> _context){
    _initRawMd5(_context);
  }

  void start(ffi.Pointer<ffi.Uint8> _context){
    _startRawMd5(_context);
  }

  void update(ffi.Pointer<ffi.Uint8> _context,ky.Buffer buffer,int len){
    _updateRawMd5(_context, (buffer as BufferIo).rawBuffer,len);
  }

  void end(ffi.Pointer<ffi.Uint8> _context, ky.Buffer buffer){
    _endRawMd5(_context, (buffer as BufferIo).rawBuffer);
  }

  void free(ffi.Pointer<ffi.Uint8> _context){
    _freeRawMd5(_context);
  }
}


class Md5BuilderIO extends ky.Md5Builder {
  RawMd5 _raw;
  Md5BuilderIO (final ffi.DynamicLibrary dylib){
    _raw = RawMd5(dylib);
  }
  @override
  ky.Md5 create(){
    return Md5Io(_raw);
  }
}

class Md5Io extends ky.Md5{
  ffi.Pointer<ffi.Uint8> _context;
  final RawMd5 _raw;
  Md5Io(this._raw){
    _context = _raw.alloc();
    _raw.init(_context);
    starts();
  }

  void starts(){
    _raw.start(_context);
  }

  void update(ky.Buffer buffer,int len){
    _raw.update(_context, buffer, len);
  }

  void end(ky.Buffer buffer){
    _raw.end(_context, buffer);
  }

  void despose(){
    _raw.free(_context);
  }
}

