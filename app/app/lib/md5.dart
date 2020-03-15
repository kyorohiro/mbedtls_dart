import 'dart:ffi' as ffi;

import 'dart:typed_data';

ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open('/app/libc/libmd5.so');
typedef KyMd5_new_func = ffi.Pointer<ffi.Uint8> Function();
typedef KyMd5_new = ffi.Pointer<ffi.Uint8> Function();

typedef KyMd5_free_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KyMd5_free = void Function(ffi.Pointer<ffi.Uint8> context);

final KyMd5_new newRawMd5 = dylib
    .lookup<ffi.NativeFunction<KyMd5_new_func>>('KyMd5_new')
    .asFunction();

final KyMd5_free freeRawMd5 = dylib
    .lookup<ffi.NativeFunction<KyMd5_free_func>>('KyMd5_free')
    .asFunction();

class Md5 {
  ffi.Pointer<ffi.Uint8> _context;
  Md5(){
    _context = newRawMd5();
  }

  void despose(){
    freeRawMd5(_context);
  }
}
//final KyMd5_free freeRawMd5 = d