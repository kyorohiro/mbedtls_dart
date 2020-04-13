import 'dart:js' as js;
import 'dart:typed_data';
import 'package:info.kyorohiro.mbedtls/buffer.dart';
import 'package:test/test.dart';
import 'package:info.kyorohiro.mbedtls/buffer_wasm.dart' as ky;


void main() {
  group('A group of tests', () {   
    setUp(() {
    });

    test('BufferTest', () {
      
      var builder = ky.BufferBuilderWasm();
      var b = builder.create(10);
      print(b.buffer);
      b.dispose();
      var buffer = builder.create(10);
      buffer.buffer.setRange(0, 10, [0,1,2,3,4,5,6,7,8,9]);
      expect(buffer.buffer, [0,1,2,3,4,5,6,7,8,9]);
      for(var i = 0;i<10;i++) {
        expect(i, buffer.buffer[i]);  
        //expect(i, (buffer as ky.BufferIo).rawBuffer.elementAt(i).value);      
      }
      buffer.dispose();
    });
  });
}