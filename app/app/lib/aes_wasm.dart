import 'dart:js' as js;
import 'dart:typed_data';
import 'buffer.dart' as ky;
import 'buffer_wasm.dart' as ky;
import 'aes.dart' as ky;


class RawAES {
  final js.JsFunction _alloc = js.context['KyAES_alloc'];
  final js.JsFunction _init = js.context['KyAES_init'];
  final js.JsFunction _setKeyForEncode= js.context['KyAES_setKeyForEncode'];
  final js.JsFunction _setKeyForDecode= js.context['KyAES_setKeyForDecode'];
  final js.JsFunction _encryptAtCBC = js.context['KyAES_encryptAtCBC'];
  final js.JsFunction _decryptAtCBC = js.context['KyAES_decryptAtCBC'];
  final js.JsFunction _encryptAtECB = js.context['KyAES_encryptAtECB'];
  final js.JsFunction _decryptAtECB = js.context['KyAES_decryptAtECB'];
  final js.JsFunction _free = js.context['KyAES_free'];

//KyAES_alloc = Module.cwrap('KyAES_alloc', 'number', [])
//KyAES_init = Module.cwrap('KyAES_init', '', ['number'])
//KyAES_setKeyForEncode = Module.cwrap('KyAES_setKeyForEncode', '', ['number','number','number'])
//KyAES_setKeyForDecode = Module.cwrap('KyAES_setKeyForDecode', '', ['number','number','number'])
//KyAES_encryptAtCBC = Module.cwrap('KyAES_encryptAtCBC', '', ['number','number','number','number','number'])
//KyAES_decryptAtCBC = Module.cwrap('KyAES_decryptAtCBC', '', ['number','number','number','number','number'])
//KyAES_free = Module.cwrap('KyAES_free', '', ['number','number'])

  int alloc() {
    return _alloc.apply([]);
  }

  void  init(int pointer) {
    _init.apply([pointer]);
  }

  int setKeyForEncode(int pointer, int bufferPointer, int len) {
    return _setKeyForEncode.apply([pointer, bufferPointer, len]);
  }

  int setKeyForDecode(int pointer, int bufferPointer, int len) {
    return _setKeyForDecode.apply([pointer, bufferPointer, len]);
  }

  int encryptAtCBC(int pointer, int ivPointer, int inputPointer, int ilen, 
              int outputPointer) {
      return _encryptAtCBC.apply([pointer, ivPointer, inputPointer, ilen, outputPointer]);
  }

  int decryptAtCBC(int pointer, int ivPointer, int inputPointer, int ilen, 
              int outputPointer) {
      return _decryptAtCBC.apply([pointer, ivPointer, inputPointer, ilen, outputPointer]);
  }

  int encryptAtECB(int pointer, int inputPointer, int outputPointer) {
      return _encryptAtECB.apply([pointer, inputPointer, outputPointer]);
  }

  int decryptAtECB(int pointer, int inputPointer, int outputPointer) {
      return _decryptAtECB.apply([pointer, inputPointer, outputPointer]);
  }

  void free(int pointer){
    _free.apply([pointer]);
  }
}



class AESBuilderWasm extends ky.AESBuilder {
  RawAES _raw;
  AESBuilderWasm(){
    _raw = RawAES();
  }

  @override
  ky.AES create() {
    print("---B1");
    return  AESWasm(_raw);
  }
}

class AESWasm extends ky.AES {
  final RawAES raw;
  int _pointer;
  AESWasm(this.raw) {
    _pointer = raw.alloc();
    raw.init(_pointer);
  }

  @override
  void despose() {
    raw.free(_pointer);
  }

  @override
  int decryptAtCBC(ky.Buffer iv, ky.Buffer input, int ilen, ky.Buffer output) {
    return raw.decryptAtCBC(_pointer, (iv as ky.BufferWasm).pointer, 
     (input as ky.BufferWasm).pointer, ilen, (output as ky.BufferWasm).pointer);
  }

  @override
  int encryptAtCBC(ky.Buffer iv, ky.Buffer input, int ilen, ky.Buffer output) {
    return raw.encryptAtCBC(_pointer, (iv as ky.BufferWasm).pointer, 
     (input as ky.BufferWasm).pointer, ilen, (output as ky.BufferWasm).pointer);
  }

  @override
  int setKeyForDecode(ky.Buffer key, int keybits) {
    return raw.setKeyForDecode(_pointer, (key as ky.BufferWasm).pointer, keybits);
  }

  @override
  int setKeyForEncode(ky.Buffer key, int keybits) {
    return raw.setKeyForEncode(_pointer, (key as ky.BufferWasm).pointer, keybits);
  }

  @override
  int decryptAtECB(ky.Buffer input, ky.Buffer output) {
    return raw.decryptAtECB(_pointer,
     (input as ky.BufferWasm).pointer, (output as ky.BufferWasm).pointer);
  }

  @override
  int encryptAtECB(ky.Buffer input, ky.Buffer output) {
    return raw.encryptAtECB(_pointer,
     (input as ky.BufferWasm).pointer, (output as ky.BufferWasm).pointer);
  }

}