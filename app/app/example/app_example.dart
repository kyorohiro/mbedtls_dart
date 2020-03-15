import 'dart:ffi' as ffi;

ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open('/app/libc/md5.so');
typedef KyBuffer_new_func = ffi.Pointer<ffi.Uint8> Function(ffi.Uint64);
typedef KyBuffer_new = ffi.Pointer<ffi.Uint8> Function(int);

typedef KyBuffer_free_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> buffer);
typedef KyBuffer_free = void Function(ffi.Pointer<ffi.Uint8> buffer);


final KyBuffer_new newBuffer = dylib
    .lookup<ffi.NativeFunction<KyBuffer_new_func>>('KyBuffer_new')
    .asFunction();

final KyBuffer_free freeBuffer = dylib
    .lookup<ffi.NativeFunction<KyBuffer_free_func>>('KyBuffer_free')
    .asFunction();


main(List<String> args) {
  

}