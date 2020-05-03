import 'dart:math';
import 'dart:typed_data';

// buffer
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;
import 'package:info.kyorohiro.mbedtls/buffer_io.dart' as ky;

// aes
import 'package:info.kyorohiro.mbedtls/aes.dart' as ky;
import 'package:info.kyorohiro.mbedtls/aes_io.dart' as ky;

import 'package:test/test.dart';

//import 'dart:ffi' as ffi show DynamicLibrary;
import 'dart:ffi' as ffi;
import 'dart:convert' as conv show utf8;
void main() {
  final ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open('/app/libc/build/libkycrypt.so');
  
  test('AES CBsC Test', () {
    var bufferBuilder = ky.BufferBuilderIo(dylib);
    var builder = ky.AESBuilderIO(dylib);
    //
    var buffer = bufferBuilder.create(100);
    buffer.buffer.setAll(0, conv.utf8.encode('hello'));
    //
    var key = bufferBuilder.create(1);
    buffer.buffer.setAll(0, conv.utf8.encode('hello'));

    var outputBuffer = bufferBuilder.create(16);
    var aes = builder.create();
    //aes.setKeyForEncode(key, keybits)
    
    //expect(outputBuffer.toHex(), '5d41402abc4b2a76b9719d911017c592');
    
  });
}
