import 'dart:js' as js;
import 'dart:typed_data';


js.JsObject Module = js.context["Module"];
js.JsFunction hello =  Module.callMethod('cwrap',['hello']);
js.JsFunction sum =  Module.callMethod('cwrap',['sum','number',["number", "number"]]);
js.JsFunction sum_double =  Module.callMethod('cwrap',['sum_double','number',["number", "number"]]);

js.JsFunction new_buffer =  Module.callMethod('cwrap',['create_buffer','number',["number"]]);
js.JsFunction destroy_buffer =  Module.callMethod('cwrap',['create_buffer','number',["number"]]);
js.JsFunction get_buffer = js.context["get_buffer"];// from util.js
js.JsFunction free_buffer =  Module.callMethod('cwrap',['destroy_buffer','void',["number"]]);