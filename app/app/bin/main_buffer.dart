import 'package:info.kyorohiro.mbedtls/buffer_io.dart' as ky;
import 'dart:ffi' as ffi;

final ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open('/app/libc/libmd5.so');

void main(List<String> args) {
  var builder = ky.BufferBuilder(dylib);
  var b = builder.create(10);
  print(b.buffer);
  b.dispose();
}