import 'dart:js' as js;
import 'dart:typed_data';
import 'buffer.dart' as ky;
import 'buffer_wasm.dart' as ky;
import 'sha1.dart' as ky;


//KySHA1_alloc = Module.cwrap('KySHA1_alloc', 'number', [])
//KySHA1_init = Module.cwrap('KySHA1_init', '', [])
//KySHA1_starts = Module.cwrap('KySHA1_starts', '', ['number'])
//KySHA1_update = Module.cwrap('KySHA1_update', '', ['number','number','number'])
//KySHA1_end = Module.cwrap('KySHA1_end', '', ['number','number'])
//KySHA1_free = Module.cwrap('KySHA1_free', '', ['number','number'])
class RawSHA1 {
  final js.JsFunction _alloc = js.context['KySHA1_alloc'];
  final js.JsFunction _init = js.context['KySHA1_init'];
  final js.JsFunction _start = js.context['KySHA1_starts'];
  final js.JsFunction _update = js.context['KySHA1_update'];
  final js.JsFunction _end = js.context['KySHA1_end'];
  final js.JsFunction _free = js.context['KySHA1_free'];

  int alloc() {
    print("----B2a");
    print(_alloc);
     print("----B2b");
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


class SHA1BuilderWasm extends ky.SHA1Builder {
  RawSHA1 _raw;
  SHA1BuilderWasm(){
    _raw = RawSHA1();
  }

  @override
  ky.SHA1 create() {
    print("---B1");
    return  SHA1Wasm(_raw);
  }
}

class SHA1Wasm extends ky.SHA1 {
  final RawSHA1 raw;
  int _pointer;
  SHA1Wasm(this.raw) {
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
