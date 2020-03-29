import 'dart:js' as js;
import 'dart:typed_data';
import 'package:info.kyorohiro.mbedtls/buffer_wasm.dart' as ky;

main(){
  print("Hello,World!!");
  var b = ky.BufferBuilder().create(10);
  print(b.buffer);
  b.dispose();
}