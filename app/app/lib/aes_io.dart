import 'dart:ffi' as ffi;

import 'package:info.kyorohiro.mbedtls/buffer_io.dart';
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;
import 'package:info.kyorohiro.mbedtls/aes.dart' as ky;

typedef KyAES_alloc_func = ffi.Pointer<ffi.Uint8> Function();
typedef KyAES_alloc = ffi.Pointer<ffi.Uint8> Function();

typedef KyAES_free_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KyAES_free = void Function(ffi.Pointer<ffi.Uint8> context);

typedef KyAES_init_func = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef KyAES_init = void Function(ffi.Pointer<ffi.Uint8> context);


typedef KyAES_setKeyForEncode_func = ffi.Int32 Function(ffi.Pointer<ffi.Uint8> context,
              ffi.Pointer<ffi.Uint8> key, ffi.Int32 keybits);
typedef KyAES_setKeyForEncode = int Function(ffi.Pointer<ffi.Uint8> context,
              ffi.Pointer<ffi.Uint8> key, int keybits);

typedef KyAES_setKeyForDecode_func = ffi.Int32 Function(ffi.Pointer<ffi.Uint8> context,
              ffi.Pointer<ffi.Uint8> key, ffi.Int32 keybits);
typedef KyAES_setKeyForDecode = int Function(ffi.Pointer<ffi.Uint8> context,
              ffi.Pointer<ffi.Uint8> key, int keybits);

typedef KyAES_encryptAtCBC_func = ffi.Int32 Function(ffi.Pointer<ffi.Uint8> context,
              ffi.Pointer<ffi.Uint8> iv, ffi.Pointer<ffi.Uint8> input, ffi.Int32 ilen, 
              ffi.Pointer<ffi.Uint8> output);
typedef KyAES_encryptAtCBC = int Function(ffi.Pointer<ffi.Uint8> context,
              ffi.Pointer<ffi.Uint8> iv, ffi.Pointer<ffi.Uint8> input, int ilen, 
              ffi.Pointer<ffi.Uint8> output);

typedef KyAES_decryptAtCBC_func = ffi.Int32 Function(ffi.Pointer<ffi.Uint8> context,
              ffi.Pointer<ffi.Uint8> iv, ffi.Pointer<ffi.Uint8> input, ffi.Int32 ilen, 
              ffi.Pointer<ffi.Uint8> output);
typedef KyAES_decryptAtCBC = int Function(ffi.Pointer<ffi.Uint8> context,
              ffi.Pointer<ffi.Uint8> iv, ffi.Pointer<ffi.Uint8> input, int ilen, 
              ffi.Pointer<ffi.Uint8> output);

typedef KyAES_decryptAtECB_func = ffi.Int32 Function(ffi.Pointer<ffi.Uint8> context,
              ffi.Pointer<ffi.Uint8> input, ffi.Pointer<ffi.Uint8> output);
typedef KyAES_decryptAtECB = int Function(ffi.Pointer<ffi.Uint8> context,
              ffi.Pointer<ffi.Uint8> input, ffi.Pointer<ffi.Uint8> output);
typedef KyAES_encryptAtECB_func = ffi.Int32 Function(ffi.Pointer<ffi.Uint8> context,
              ffi.Pointer<ffi.Uint8> input, ffi.Pointer<ffi.Uint8> output);
typedef KyAES_encryptAtECB = int Function(ffi.Pointer<ffi.Uint8> context,
              ffi.Pointer<ffi.Uint8> input, ffi.Pointer<ffi.Uint8> output);

class RawAES {

  KyAES_alloc _allocRawAES;
  KyAES_free _freeRawAES;
  KyAES_init _initRawAES;
  KyAES_setKeyForEncode _setKeyForEncode;
  KyAES_setKeyForDecode _setKeyForDecode;
  KyAES_decryptAtCBC _decryptAtCBC;
  KyAES_encryptAtCBC _encryptAtCBC;
  KyAES_decryptAtECB _decryptAtECB;
  KyAES_encryptAtECB _encryptAtECB;

  RawAES(ffi.DynamicLibrary dylib) {
     _allocRawAES = dylib
      .lookup<ffi.NativeFunction<KyAES_alloc_func>>('KyAES_alloc')
      .asFunction();
     _freeRawAES = dylib
      .lookup<ffi.NativeFunction<KyAES_free_func>>('KyAES_free')
      .asFunction();
     _initRawAES = dylib
      .lookup<ffi.NativeFunction<KyAES_free_func>>('KyAES_init')
      .asFunction();
     _setKeyForEncode = dylib
      .lookup<ffi.NativeFunction<KyAES_setKeyForEncode_func>>('KyAES_setKeyForEncode')
      .asFunction();
     _setKeyForDecode = dylib
      .lookup<ffi.NativeFunction<KyAES_setKeyForDecode_func>>('KyAES_setKeyForDecode')
      .asFunction();
     _encryptAtCBC = dylib
      .lookup<ffi.NativeFunction<KyAES_encryptAtCBC_func>>('KyAES_encryptAtCBC')
      .asFunction();
     _decryptAtCBC = dylib
      .lookup<ffi.NativeFunction<KyAES_encryptAtCBC_func>>('KyAES_decryptAtCBC')
      .asFunction();
     _decryptAtECB = dylib
      .lookup<ffi.NativeFunction<KyAES_decryptAtECB_func>>('KyAES_decryptAtECB')
      .asFunction();
     _encryptAtECB = dylib
      .lookup<ffi.NativeFunction<KyAES_encryptAtECB_func>>('KyAES_encryptAtECB')
      .asFunction();
  }

  ffi.Pointer<ffi.Uint8> alloc() {
    return _allocRawAES();
  }

  void free(ffi.Pointer<ffi.Uint8> _context){
    _freeRawAES(_context);
  }

  void init(ffi.Pointer<ffi.Uint8> _context){
    _initRawAES(_context);
  }

  int setKeyForDecode(ffi.Pointer<ffi.Uint8> _context, ky.Buffer key, int keybits) {
    return _setKeyForDecode(_context, (key as BufferIo).rawBuffer,keybits);
  }

  int setKeyForEncode(ffi.Pointer<ffi.Uint8> _context, ky.Buffer key, int keybits) {
    return _setKeyForEncode(_context, (key as BufferIo).rawBuffer,keybits);
  }

  int encryptAtCBC(ffi.Pointer<ffi.Uint8> context,
              ky.Buffer iv, ky.Buffer input, int ilen, 
              ky.Buffer output) {
    return _encryptAtCBC(context, (iv as BufferIo).rawBuffer, (input as BufferIo).rawBuffer,ilen, (output as BufferIo).rawBuffer);
  }

  int decryptAtCBC(ffi.Pointer<ffi.Uint8> context,
              ky.Buffer iv, ky.Buffer input, int ilen, 
              ky.Buffer output) {
    return _decryptAtCBC(context, (iv as BufferIo).rawBuffer, (input as BufferIo).rawBuffer,ilen, (output as BufferIo).rawBuffer);
  }
  int encryptAtECB(ffi.Pointer<ffi.Uint8> context,
              ky.Buffer input, ky.Buffer output) {
    return _encryptAtECB(context, (input as BufferIo).rawBuffer, (output as BufferIo).rawBuffer);
  }

  int decryptAtECB(ffi.Pointer<ffi.Uint8> context,
              ky.Buffer input, ky.Buffer output) {
    return _decryptAtECB(context, (input as BufferIo).rawBuffer, (output as BufferIo).rawBuffer);
  }
}

//
//
//


class AESBuilderIO extends ky.AESBuilder {
  RawAES _raw;
  AESBuilderIO (final ffi.DynamicLibrary dylib){
    _raw = RawAES(dylib);
  }
  @override
  ky.AES create(){
    return AESIo(_raw);
  }
}

class AESIo extends ky.AES{
  ffi.Pointer<ffi.Uint8> _context;
  final RawAES _raw;
  AESIo(this._raw){
    _context = _raw.alloc();
    _raw.init(_context);
  }

  @override
  void despose(){
    _raw.free(_context);
  }

  @override
  int decryptAtCBC(ky.Buffer iv, ky.Buffer input, int ilen, ky.Buffer output) {
    return _raw.decryptAtCBC(_context, iv, input, ilen, output);
  }

  @override
  int encryptAtCBC(ky.Buffer iv, ky.Buffer input, int ilen, ky.Buffer output) {
    return _raw.encryptAtCBC(_context, iv, input, ilen, output);
  }

  @override
  int setKeyForDecode(ky.Buffer key, int keybits) {
    return _raw.setKeyForDecode(_context, key, keybits);
  }

  @override
  int setKeyForEncode(ky.Buffer key, int keybits) {
    return _raw.setKeyForEncode(_context, key, keybits);
  }

  @override
  int decryptAtECB(ky.Buffer input, ky.Buffer output) {
    return _raw.decryptAtECB(_context, input, output);
  }

  @override
  int encryptAtECB(ky.Buffer input, ky.Buffer output) {
    return _raw.encryptAtECB(_context, input, output);
  }
}



