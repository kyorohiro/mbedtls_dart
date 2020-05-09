import 'dart:js' as js;
import 'dart:typed_data';
import 'package:info.kyorohiro.mbedtls/buffer.dart';
import 'package:test/test.dart';
import 'package:info.kyorohiro.mbedtls/buffer_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/md5_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha1_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha256_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha512_wasm.dart' as ky;

import 'dart:convert' as conv;

import 'test_buffer.dart' as tbuffer;
import 'test_hash.dart' as thash;
import 'test_aes.dart' as taes;
 main() async {
  tbuffer.main();
  thash.main();
  taes.main();
}