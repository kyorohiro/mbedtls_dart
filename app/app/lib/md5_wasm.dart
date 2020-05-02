import 'dart:js' as js;
import 'dart:typed_data';
import 'buffer.dart' as ky;
import 'buffer_wasm.dart' as ky;
import 'md5.dart' as ky;


//KyMd5_alloc = Module.cwrap('KyMd5_alloc', 'number', [])
//KyMd5_init = Module.cwrap('KyMd5_init', '', [])
//KyMd5_starts = Module.cwrap('KyMd5_starts', '', ['number'])
//KyMd5_update = Module.cwrap('KyMd5_update', '', ['number','number','number'])
//KyMd5_end = Module.cwrap('KyMd5_end', '', ['number','number'])
//KyMd5_free = Module.cwrap('KyMd5_free', '', ['number','number'])
class RawMd5 {
  final js.JsFunction _alloc = js.context['KyMd5_alloc'];
  final js.JsFunction _init = js.context['KyMd5_init'];
  final js.JsFunction _start = js.context['KyMd5_starts'];
  final js.JsFunction _update = js.context['KyMd5_update'];
  final js.JsFunction _end = js.context['KyMd5_end'];
  final js.JsFunction _free = js.context['KyMd5_free'];

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


class Md5BuilderWasm extends ky.Md5Builder {
  RawMd5 _raw;
  Md5BuilderWasm(){
    _raw = RawMd5();
  }

  @override
  ky.Md5 create() {
    print("---B1");
    return  Md5Wasm(_raw);
  }
}

class Md5Wasm extends ky.Md5 {
  final RawMd5 raw;
  int _pointer;
  Md5Wasm(this.raw) {
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