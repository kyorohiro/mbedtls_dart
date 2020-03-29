import 'dart:js' as js;
import 'dart:typed_data';
import 'package:info.kyorohiro.mbedtls/buffer_wasm.dart' as ky;

main(){
  print("Hello,World!!");
  var b = ky.BufferBuilderWasm().create(10);
  print(b.buffer);
  b.dispose();
}