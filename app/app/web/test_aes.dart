import 'dart:js' as js;
import 'dart:typed_data';
import 'package:info.kyorohiro.mbedtls/buffer.dart';
import 'package:test/test.dart';
import 'package:info.kyorohiro.mbedtls/buffer_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/aes.dart' as ky;
import 'package:info.kyorohiro.mbedtls/aes_wasm.dart' as ky;


import 'dart:convert' as conv;


Future<Null> main() async {
  print("============TEST HASH ================");
  group('hash', () {   
    setUp(() {
    });


  test('AES CBC Test Encode', () {
    var bufferBuilder = ky.BufferBuilderWasm();;
    var aesBuilder = ky.AESBuilderWasm();
    //
    var buffer = bufferBuilder.createFromString('helloworld012345');
    var key = bufferBuilder.createFromHex('2b7e151628aed2a6abf7158809cf4f3c2b7e151628aed2a6abf7158809cf4f3c');
    var iv =  bufferBuilder.createFromHex('000102030405060708090a0b0c0d0e0f');
    var output = bufferBuilder.create(16);
    var aes = aesBuilder.create();
    aes.setKeyForEncode(key, 256);
    aes.encryptAtCBC(iv, buffer, buffer.len, output);
    aes.despose();
    expect(output.toHex(), 'bbcebf78673fccf2dfce4e4c6034517e');
  });
  test('AES CBC Test Decode', () {
    var bufferBuilder = ky.BufferBuilderWasm();;
    var aesBuilder = ky.AESBuilderWasm();
    //
    var buffer = bufferBuilder.createFromHex('bbcebf78673fccf2dfce4e4c6034517e');
    var key = bufferBuilder.createFromHex('2b7e151628aed2a6abf7158809cf4f3c2b7e151628aed2a6abf7158809cf4f3c');
    var iv =  bufferBuilder.createFromHex('000102030405060708090a0b0c0d0e0f');
    var output = bufferBuilder.create(16);
    var aes = aesBuilder.create();
    aes.setKeyForDecode(key, 256);
    aes.decryptAtCBC(iv, buffer, buffer.len, output);
    aes.despose();
    print("-------------\n");
    print(" ${output.toHex()}\n");
    expect(output.toString(), 'helloworld012345');
    print("-------------\n");

  });

  test('AES ECB Test Encode', () {
    var bufferBuilder = ky.BufferBuilderWasm();;
    var aesBuilder = ky.AESBuilderWasm();
    //
    var buffer = bufferBuilder.createFromString('helloworld012345');
    var key = bufferBuilder.createFromHex('2b7e151628aed2a6abf7158809cf4f3c2b7e151628aed2a6abf7158809cf4f3c');
    var output = bufferBuilder.create(16);
    var aes = aesBuilder.create();
    expect(key.len, 32);
    aes.setKeyForEncode(key, 256);
    aes.encryptAtECB(buffer, output);
    aes.despose();
    expect(output.toHex(), 'dd908ded44d50472b656183c1b37183d');
  });

  test('AES ECB Test Decode', () {
    var bufferBuilder = ky.BufferBuilderWasm();;
    var aesBuilder = ky.AESBuilderWasm();
    //
    var buffer = bufferBuilder.createFromHex('dd908ded44d50472b656183c1b37183d');
    var key = bufferBuilder.createFromHex('2b7e151628aed2a6abf7158809cf4f3c2b7e151628aed2a6abf7158809cf4f3c');
    var output = bufferBuilder.create(16);
    var aes = aesBuilder.create();
    aes.setKeyForDecode(key, 256);
    aes.decryptAtECB(buffer, output);
    aes.despose();
    expect(output.toString(), 'helloworld012345');
  });

  });
}