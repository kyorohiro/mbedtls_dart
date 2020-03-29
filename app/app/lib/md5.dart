library kycrypt;
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;

abstract class Md5Builder {
  Md5 create();
}

abstract class Md5 {
  void start();
  void update(ky.Buffer buffer,int index, int len);
  void end(ky.Buffer buffer);
  void despose();
}
