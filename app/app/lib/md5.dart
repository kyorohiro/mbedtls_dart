import 'dart:ffi' as ffi;

import 'dart:typed_data';

import 'package:info.kyorohiro.mbedtls/buffer_io.dart';

ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open('/app/libc/libmd5.so');
typedef KyMd5_new_func = ffi.Pointer<ffi.Uint8> Function();
typedef KyMd5_new = ffi.Pointer<ffi.Uint8> Function();

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

final KyMd5_new newRawMd5 = dylib
    .lookup<ffi.NativeFunction<KyMd5_new_func>>('KyMd5_new')
    .asFunction();

final KyMd5_free freeRawMd5 = dylib
    .lookup<ffi.NativeFunction<KyMd5_free_func>>('KyMd5_free')
    .asFunction();

final KyMd5_free initRawMd5 = dylib
    .lookup<ffi.NativeFunction<KyMd5_init_func>>('KyMd5_init')
    .asFunction();

final KyMd5_free startRawMd5 = dylib
    .lookup<ffi.NativeFunction<KyMd5_free_func>>('KyMd5_start')
    .asFunction();

final KyMd5_update updateRawMd5 = dylib
    .lookup<ffi.NativeFunction<KyMd5_update_func>>('KyMd5_update')
    .asFunction();

final KyMd5_end endRawMd5 = dylib
    .lookup<ffi.NativeFunction<KyMd5_end_func>>('KyMd5_end')
    .asFunction();


class Md5 {
  ffi.Pointer<ffi.Uint8> _context;
  Md5(){
    _context = newRawMd5();
    initRawMd5(_context);
  }

  void start(){
    startRawMd5(_context);
  }

  void update(Buffer buffer,int index, int len){
    updateRawMd5(_context, buffer.rawBuffer.elementAt(index),len);
  }

  void end(Buffer buffer){
    endRawMd5(_context, buffer.rawBuffer);
  }

  void despose(){
    freeRawMd5(_context);
  }
}
