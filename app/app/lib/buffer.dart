library kycrypt_buffer;

import 'dart:typed_data';

abstract class BufferBuilder {
  Buffer create(int len);
}

abstract class Buffer {
  int _len;
  Buffer(int len) {
    _len = len;
  }
  Uint8List get buffer;
  int get len => _len;
  void dispose();

  String toHex(){
    var ret = StringBuffer();
    for(var c in buffer) {
      ret.write(c.toRadixString(16));
    }
    return ret.toString();
  }
}