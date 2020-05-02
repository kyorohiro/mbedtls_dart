library kycrypt_sha512;
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;

abstract class SHA512Builder {
  SHA512 create();
}

abstract class SHA512 {
  void starts();
  void update(ky.Buffer buffer, int len);

  ///
  /// The required [buffer] 's size is 32
  void end(ky.Buffer buffer);
  void despose();
}

