import 'dart:js' as js;
import 'dart:typed_data';
import 'buffer.dart' as ky;
import 'buffer_wasm.dart' as ky;
import 'sha256.dart' as ky;


//KySHA256_alloc = Module.cwrap('KySHA256_alloc', 'number', [])
//KySHA256_init = Module.cwrap('KySHA256_init', '', [])
//KySHA256_starts = Module.cwrap('KySHA256_starts', '', ['number'])
//KySHA256_update = Module.cwrap('KySHA256_update', '', ['number','number','number'])
//KySHA256_end = Module.cwrap('KySHA256_end', '', ['number','number'])
//KySHA256_free = Module.cwrap('KySHA256_free', '', ['number','number'])
class RawSHA256 {
  final js.JsFunction _alloc = js.context['KySHA256_alloc'];
  final js.JsFunction _init = js.context['KySHA256_init'];
  final js.JsFunction _start = js.context['KySHA256_starts'];
  final js.JsFunction _update = js.context['KySHA256_update'];
  final js.JsFunction _end = js.context['KySHA256_end'];
  final js.JsFunction _free = js.context['KySHA256_free'];

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


class SHA256BuilderWasm extends ky.SHA256Builder {
  RawSHA256 _raw;
  SHA256BuilderWasm(){
    _raw = RawSHA256();
  }

  @override
  ky.SHA256 create() {
    return  SHA256Wasm(_raw);
  }
}

class SHA256Wasm extends ky.SHA256 {
  final RawSHA256 raw;
  int _pointer;
  SHA256Wasm(this.raw) {
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

