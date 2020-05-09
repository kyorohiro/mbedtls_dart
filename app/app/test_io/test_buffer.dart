import 'dart:math';
import 'dart:typed_data';

// buffer
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;
import 'package:info.kyorohiro.mbedtls/buffer_io.dart' as ky;


import 'package:test/test.dart';

//import 'dart:ffi' as ffi show DynamicLibrary;
import 'dart:ffi' as ffi;
import 'dart:convert' as conv show utf8;
void main() {
  final ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open('/app/libc/build/libkycrypt.so');
  
  group('XXX', () {
   
    setUp(() {
    });

    test('Buffer Create', () {
      
      var builder = ky.BufferBuilderIo(dylib);
      var b = builder.create(10);
      print(b.buffer);
      b.dispose();
      var buffer = builder.create(10);
      buffer.buffer.setRange(0, 10, [0,1,2,3,4,5,6,7,8,9]);
      expect(buffer.buffer, [0,1,2,3,4,5,6,7,8,9]);
      for(var i = 0;i<10;i++) {
        expect(i, buffer.buffer[i]);  
        expect(i, (buffer as ky.BufferIo).rawBuffer.elementAt(i).value);      
      }
      buffer.dispose();
    });
    test('Buffer HEX', () {
      var builder = ky.BufferBuilderIo(dylib);
      var b = builder.createFromHex('ABCDEF0123456789');
      expect(b.toHex(), 'abcdef0123456789');
      b.dispose();
    });
  });
}
