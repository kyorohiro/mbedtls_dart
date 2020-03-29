import 'dart:js' as js;
import 'dart:typed_data';
import 'package:info.kyorohiro.mbedtls/buffer_wasm.dart' as ky;

/*
js.JsObject Module = js.context["Module"];
js.JsFunction hello =  Module.callMethod('cwrap',['hello']);
js.JsFunction sum =  Module.callMethod('cwrap',['sum','number',["number", "number"]]);
js.JsFunction sum_double =  Module.callMethod('cwrap',['sum_double','number',["number", "number"]]);

js.JsFunction new_buffer =  Module.callMethod('cwrap',['KyBuffer_new','number',["number"]]);
js.JsFunction get_buffer = js.context['KyBuffer_get_buffer'];// from util.js
js.JsFunction free_buffer =  Module.callMethod('cwrap',['KyBuffer_free','number',["number"]]);
*/
main(){
  print("Hello,World!!");
  ky.BufferWasm b = new ky.BufferWasm(10);
  print(b.buffer);
  b.dispose();
  /*
  int pointer = new_buffer.apply([10]);
  Uint8List buffer = get_buffer.apply([pointer, 10]);
  print(buffer);
  free_buffer.apply([pointer]);
  */
}