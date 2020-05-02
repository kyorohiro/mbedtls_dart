library kycrypt_sha1;
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;

abstract class SHA1Builder {
  SHA1 create();
}

abstract class SHA1 {
  void starts();
  void update(ky.Buffer buffer, int len);

  ///
  /// The required [buffer] 's size is 16 
  void end(ky.Buffer buffer);
  void despose();
}
