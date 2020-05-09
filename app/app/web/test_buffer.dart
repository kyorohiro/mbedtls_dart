import 'dart:js' as js;
import 'dart:typed_data';
import 'package:info.kyorohiro.mbedtls/buffer.dart';
import 'package:test/test.dart' as test;
import 'package:info.kyorohiro.mbedtls/buffer_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/md5_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha1_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha256_wasm.dart' as ky;
import 'package:info.kyorohiro.mbedtls/sha512_wasm.dart' as ky;

import 'dart:convert' as conv;

Future<Null> main() async {
  print('============TEST BUFFER ================');
  test.test('BufferTest', () {
    
    var builder = ky.BufferBuilderWasm();
    var b = builder.create(10);
    print(b.buffer);
    b.dispose();
    var buffer = builder.create(10);
    buffer.buffer.setRange(0, 10, [0,1,2,3,4,5,6,7,8,9]);
    test.expect(buffer.buffer, [0,1,2,3,4,5,6,7,8,9]);
    for(var i = 0;i<10;i++) {
      test.expect(i, buffer.buffer[i]);  
      //expect(i, (buffer as ky.BufferIo).rawBuffer.elementAt(i).value);      
    }
    buffer.dispose();
    print('============//TEST BUFFER ================');
  });
  print('============/TEST BUFFER ================');
}