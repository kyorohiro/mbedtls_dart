import 'dart:js' as js;
import 'dart:typed_data';
import 'package:info.kyorohiro.mbedtls/buffer.dart';
import 'package:test/test.dart';
import 'package:info.kyorohiro.mbedtls/buffer_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/md5_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha1_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha256_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha512_wasm.dart' as ky;

import 'dart:convert' as conv;


Future<Null> main() async {
  print("============TEST HASH ================");
  group('hash', () {   
    setUp(() {
    });

    test('MD5 Test', () {
      var bufferBuilder = ky.BufferBuilderWasm();
      var builder = ky.Md5BuilderWasm();
      var buffer = bufferBuilder.create(100);
      var outputBuffer = bufferBuilder.create(16);
      var md5 = builder.create();
      buffer.buffer.setAll(0, conv.utf8.encode('hello'));
      md5.starts();
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
      sha1.starts();
      sha1.update(buffer, 5);
      sha1.end(outputBuffer);
      expect(outputBuffer.toHex(), 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d');     
    });
    //
    test('SHA256 Test', () {
      var bufferBuilder = ky.BufferBuilderWasm();
      var builder = ky.SHA256BuilderWasm();
      var buffer = bufferBuilder.create(100);
      var outputBuffer = bufferBuilder.create(32);
      var sha1 = builder.create();
      buffer.buffer.setAll(0, conv.utf8.encode('hello'));
      sha1.starts();
      sha1.update(buffer, 5);
      sha1.end(outputBuffer);
      expect(outputBuffer.toHex(), '2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824');    
    });
    //
    test('SHA512 Test', () {
      var bufferBuilder = ky.BufferBuilderWasm();
      var builder = ky.SHA512BuilderWasm();
      var buffer = bufferBuilder.create(100);
      var outputBuffer = bufferBuilder.create(64);
      var sha1 = builder.create();
      buffer.buffer.setAll(0, conv.utf8.encode('hello'));
      sha1.starts();
      sha1.update(buffer, 5);
      sha1.end(outputBuffer);
      expect(outputBuffer.toHex(), '9b71d224bd62f3785d96d46ad3ea3d73319bfbc2890caadae2dff72519673ca72323c3d99ba5c11d7c7acc6e14b8c5da0c4663475c2e5c3adef46f73bcdec043');
    });
    //

  });
}