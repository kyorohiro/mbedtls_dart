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
  final dylib = ffi.DynamicLibrary.open('/app/libc/build/libkycrypt.so');
  
  test('AES CBC Test Encode', () {
    var bufferBuilder = ky.BufferBuilderIo(dylib);
    var aesBuilder = ky.AESBuilderIO(dylib);
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
    var bufferBuilder = ky.BufferBuilderIo(dylib);
    var aesBuilder = ky.AESBuilderIO(dylib);
    //
    var buffer = bufferBuilder.createFromHex('bbcebf78673fccf2dfce4e4c6034517e');
    var key = bufferBuilder.createFromHex('2b7e151628aed2a6abf7158809cf4f3c2b7e151628aed2a6abf7158809cf4f3c');
    var iv =  bufferBuilder.createFromHex('000102030405060708090a0b0c0d0e0f');
    var output = bufferBuilder.create(16);
    var aes = aesBuilder.create();
    aes.setKeyForDecode(key, 256);
    aes.decryptAtCBC(iv, buffer, buffer.len, output);
    aes.despose();
    expect(output.toString(), 'helloworld012345');
  });

  test('AES ECB Test Encode', () {
    var bufferBuilder = ky.BufferBuilderIo(dylib);
    var aesBuilder = ky.AESBuilderIO(dylib);
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
    var bufferBuilder = ky.BufferBuilderIo(dylib);
    var aesBuilder = ky.AESBuilderIO(dylib);
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


}
