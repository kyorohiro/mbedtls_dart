import 'dart:js' as js;
import 'dart:typed_data';
import 'buffer.dart' as ky;
import 'buffer_wasm.dart' as ky;
import 'sha512.dart' as ky;


//KySHA512_alloc = Module.cwrap('KySHA512_alloc', 'number', [])
//KySHA512_init = Module.cwrap('KySHA512_init', '', [])
//KySHA512_starts = Module.cwrap('KySHA512_starts', '', ['number'])
//KySHA512_update = Module.cwrap('KySHA512_update', '', ['number','number','number'])
//KySHA512_end = Module.cwrap('KySHA512_end', '', ['number','number'])
//KySHA512_free = Module.cwrap('KySHA512_free', '', ['number','number'])
class RawSHA512 {
  final js.JsFunction _alloc = js.context['KySHA512_alloc'];
  final js.JsFunction _init = js.context['KySHA512_init'];
  final js.JsFunction _start = js.context['KySHA512_starts'];
  final js.JsFunction _update = js.context['KySHA512_update'];
  final js.JsFunction _end = js.context['KySHA512_end'];
  final js.JsFunction _free = js.context['KySHA512_free'];

  int alloc() {
    return _alloc.apply([]);
  }
  void  init(int pointer) {
    _init.apply([pointer]);
  }

  void start(int pointer) {
    _start.apply([pointer]);
  }

  Uint8List update(int pointer, int bufferPointer, int len) {
    return _update.apply([pointer, bufferPointer, len]);
  }

  Uint8List end(int pointer, int outputPointer) {
    return _end.apply([pointer, outputPointer]);
  }

  void free(int pointer){
    _free.apply([pointer]);
  }
}


class SHA512BuilderWasm extends ky.SHA512Builder {
  RawSHA512 _raw;
  SHA512BuilderWasm(){
    _raw = RawSHA512();
  }

  @override
  ky.SHA512 create() {
    return  SHA512Wasm(_raw);
  }
}

class SHA512Wasm extends ky.SHA512 {
  final RawSHA512 raw;
  int _pointer;
  SHA512Wasm(this.raw) {
    _pointer = raw.alloc();
    raw.init(_pointer);
    starts();
  }
  @override
  void despose() {
    raw.free(_pointer);
  }

  @override
  void end(ky.Buffer buffer) {
    raw.end(_pointer, (buffer as ky.BufferWasm).pointer);
  }

  @override
  void starts() {
    raw.start(_pointer);
  }

  @override
  void update(ky.Buffer buffer, int len) {
    raw.update(_pointer, (buffer as ky.BufferWasm).pointer ,len);
  }

}

