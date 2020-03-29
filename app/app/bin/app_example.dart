import 'package:info.kyorohiro.mbedtls/buffer_io.dart' as ky;

main(List<String> args) {
  var b = ky.KyBufferIo(10);
  print(b.buffer);
  b.dispose();
}