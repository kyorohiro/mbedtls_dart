library kycrypt_md5;
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;

abstract class Md5Builder {
  Md5 create();
}

abstract class Md5 {
  void starts();
  void update(ky.Buffer buffer, int len);

  ///
  /// The required [buffer] 's size is 16 
  void end(ky.Buffer buffer);
  void despose();
}
