import 'dart:js' as js;
import 'dart:typed_data';
import 'buffer.dart';

//
//js.JsObject Module = js.context["Module"];
//js.JsFunction hello =  Module.callMethod('cwrap',['hello']);
//js.JsFunction sum =  Module.callMethod('cwrap',['sum','number',["number", "number"]]);
//js.JsFunction sum_double =  Module.callMethod('cwrap',['sum_double','number',["number", "number"]]);
//js.JsFunction new_buffer =  Module.callMethod('cwrap',['KyBuffer_new','number',["number"]]);
//js.JsFunction get_buffer = js.context['KyBuffer_get_buffer'];// from util.js
//js.JsFunction free_buffer =  Module.callMethod('cwrap',['KyBuffer_free','number',["number"]]);
js.JsFunction _alloc = js.context['KyBuffer_alloc'];
js.JsFunction _get_buffer = js.context['KyBuffer_get_buffer'];
js.JsFunction _free = js.context['KyBuffer_free'];

int alloc(int len) {
  return _alloc.apply([len]);
}

Uint8List get_buffer(int pointer, int len) {
  return _get_buffer.apply([pointer,len]);
}

void free(int pointer){
  _free.apply([pointer]);
}


class BufferWasm extends Buffer {
  int _len;
  int _pointer;
  Uint8List _buffer;

  BufferWasm(int len):super(len)  {
    _len = len;
    _pointer = alloc(len);
    _buffer = get_buffer(_pointer, len);
  }

  @override
  Uint8List get buffer => _buffer;

  @override
  int get len => _len;

  @override
  void dispose() {
    free(_pointer);
  }
}