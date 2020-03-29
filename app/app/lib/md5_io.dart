import 'dart:ffi' as ffi;

import 'dart:typed_data';

import 'package:info.kyorohiro.mbedtls/buffer_io.dart';
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;

typedef KyMd5_alloc_func = ffi.Pointer<ffi.Uint8> Function();
typedef KyMd5_alloc = ffi.Pointer<ffi.Uint8> Function();

typedef KyMd5_free_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KyMd5_free = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KyMd5_init_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KyMd5_init = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KyMd5_start_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KyMd5_start = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KyMd5_update_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> input, ffi.Int32 len);
typedef KyMd5_update = void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> input, int len);

typedef KyMd5_end_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> outout);
typedef KyMd5_end = void Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> outout);

class Md5 {
  KyMd5_alloc _allocRawMd5;
  KyMd5_free _freeRawMd5;
  KyMd5_free _initRawMd5;
  KyMd5_free _startRawMd5;
  KyMd5_update _updateRawMd5;
  KyMd5_end _endRawMd5;
  ffi.Pointer<ffi.Uint8> _context;

  Md5(ffi.DynamicLibrary dylib) {
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
      .lookup<ffi.NativeFunction<KyMd5_free_func>>('KyMd5_start')
      .asFunction();
    _updateRawMd5 = dylib
      .lookup<ffi.NativeFunction<KyMd5_update_func>>('KyMd5_update')
      .asFunction();
    _endRawMd5 = dylib
      .lookup<ffi.NativeFunction<KyMd5_end_func>>('KyMd5_end')
      .asFunction();
    _context = _allocRawMd5();
    _initRawMd5(_context);
  }


  void start(){
    _startRawMd5(_context);
  }

  void update(ky.Buffer buffer,int index, int len){
    _updateRawMd5(_context, (buffer as BufferIo).rawBuffer.elementAt(index),len);
  }

  void end(ky.Buffer buffer){
    _endRawMd5(_context, (buffer as BufferIo).rawBuffer);
  }

  void despose(){
    _freeRawMd5(_context);
  }
}

/*
class Md5 {
  ffi.Pointer<ffi.Uint8> _context;
  Md5(){
    _context = allocRawMd5();
    initRawMd5(_context);
  }

  void start(){
    startRawMd5(_context);
  }

  void update(KyBufferIo buffer,int index, int len){
    updateRawMd5(_context, buffer.rawBuffer.elementAt(index),len);
  }

  void end(KyBufferIo buffer){
    endRawMd5(_context, buffer.rawBuffer);
  }

  void despose(){
    freeRawMd5(_context);
  }
}
*/
