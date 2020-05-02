library kycrypt_sha256;
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;

abstract class SHA256Builder {
  SHA256 create();
}

abstract class SHA256 {
  void starts();
  void update(ky.Buffer buffer, int len);

  ///
  /// The required [buffer] 's size is 32
  void end(ky.Buffer buffer);
  void despose();
}

