import 'dart:js' as js;
import 'dart:typed_data';
import 'buffer.dart';

js.JsObject Module = js.context["Module"];
js.JsFunction hello =  Module.callMethod('cwrap',['hello']);
js.JsFunction sum =  Module.callMethod('cwrap',['sum','number',["number", "number"]]);
js.JsFunction sum_double =  Module.callMethod('cwrap',['sum_double','number',["number", "number"]]);

js.JsFunction new_buffer =  Module.callMethod('cwrap',['KyBuffer_new','number',["number"]]);
js.JsFunction get_buffer = js.context['KyBuffer_get_buffer'];// from util.js
js.JsFunction free_buffer =  Module.callMethod('cwrap',['KyBuffer_free','number',["number"]]);


class KyBufferWasm extends KyBuffer {
  int _len;
  int _pointer;
  Uint8List _buffer;

  KyBufferWasm(int len) {
    _len = len;
    _pointer = new_buffer.apply([len]);
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