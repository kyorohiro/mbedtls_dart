import 'dart:js' as js;
import 'dart:typed_data';
import 'buffer.dart';

//
js.JsObject Module = js.context["Module"];
js.JsFunction hello =  Module.callMethod('cwrap',['hello']);
js.JsFunction sum =  Module.callMethod('cwrap',['sum','number',["number", "number"]]);
js.JsFunction sum_double =  Module.callMethod('cwrap',['sum_double','number',["number", "number"]]);

js.JsFunction alloc_buffer =  Module.callMethod('cwrap',['KyBuffer_alloc','number',["number"]]);
js.JsFunction get_buffer = js.context['KyBuffer_get_buffer'];// from util.js
js.JsFunction free_buffer =  Module.callMethod('cwrap',['KyBuffer_free','number',["number"]]);


class KyBufferWasmDirect extends Buffer {
  int _len;
  int _pointer;
  Uint8List _buffer;

  KyBufferWasmDirect(int len):super(len) {
    _len = len;
    _pointer = alloc_buffer.apply([len]);
    _buffer = get_buffer.apply([_pointer,len]);
  }
  @override
  Uint8List get buffer => _buffer;

  @override
  int get len => _len;

  @override
  void dispose() {
    free_buffer.apply([_pointer]);
  }
}