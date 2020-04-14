import 'dart:js' as js;
import 'dart:typed_data';
import 'package:info.kyorohiro.mbedtls/buffer.dart';
import 'package:test/test.dart';
import 'package:info.kyorohiro.mbedtls/buffer_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/md5_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha1_wasm.dart' as ky;
import 'dart:convert' as conv;

void main() {
  group('A group of tests', () {   
    setUp(() {
    });

    test('BufferTest', () {
      
      var builder = ky.BufferBuilderWasm();
      var b = builder.create(10);
      print(b.buffer);
      b.dispose();
      var buffer = builder.create(10);
      buffer.buffer.setRange(0, 10, [0,1,2,3,4,5,6,7,8,9]);
      expect(buffer.buffer, [0,1,2,3,4,5,6,7,8,9]);
      for(var i = 0;i<10;i++) {
        expect(i, buffer.buffer[i]);  
        //expect(i, (buffer as ky.BufferIo).rawBuffer.elementAt(i).value);      
      }
      buffer.dispose();
    });

    test('MD5 Test', () {
      var bufferBuilder = ky.BufferBuilderWasm();
      var builder = ky.Md5BuilderWasm();
      var buffer = bufferBuilder.create(100);
      var outputBuffer = bufferBuilder.create(16);
      var md5 = builder.create();
      buffer.buffer.setAll(0, conv.utf8.encode('hello'));
      md5.start();
      md5.update(buffer, 5);
      md5.end(outputBuffer);
      expect(outputBuffer.toHex(), '5d41402abc4b2a76b9719d911017c592');      
    });

    test('SHA1 Test', () {
      var bufferBuilder = ky.BufferBuilderWasm();
      var builder = ky.SHA1BuilderWasm();
      var buffer = bufferBuilder.create(100);
      var outputBuffer = bufferBuilder.create(20);
      var sha1 = builder.create();
      buffer.buffer.setAll(0, conv.utf8.encode('hello'));
      sha1.start();
      sha1.update(buffer, 5);
      sha1.end(outputBuffer);
      expect(outputBuffer.toHex(), '5d41402abc4b2a76b9719d911017c592');      
    });
  });
}