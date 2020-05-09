library kycrypt_aes;
import 'package:info.kyorohiro.mbedtls/buffer.dart' as ky;

abstract class AESBuilder {
  AES create();
}

abstract class AES {
  // cbc 256->32 byte
  int setKeyForEncode(ky.Buffer key, int keybits);
  int setKeyForDecode(ky.Buffer key, int keybits);
  // cbc 256->16byte
  int encryptAtCBC(ky.Buffer iv, ky.Buffer input, int  ilen, ky.Buffer output);
  int decryptAtCBC(ky.Buffer iv, ky.Buffer input, int  ilen, ky.Buffer output);
  int encryptAtECB(ky.Buffer iv, ky.Buffer input, ky.Buffer output);
  int decryptAtECB(ky.Buffer iv, ky.Buffer input, ky.Buffer output);
  void despose();
}

