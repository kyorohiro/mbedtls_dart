library kycrypt_buffer;

import 'dart:typed_data';
import 'dart:convert' as conv show utf8;

abstract class BufferBuilder {
  Buffer create(int len);

  Buffer createFromString(String text) {
    var codes = conv.utf8.encode(text);
    var buffer = create(codes.length);
    buffer.buffer.setRange(0, codes.length, codes);
    return buffer;
  }
  Buffer createFromHex(String hexString) {
    var buffer = create(hexString.length~/2);
    var codes = conv.utf8.encode(hexString);
    int hex(int i) {
      if(0x30 <=i && i<=0x39){
        return i- 0x30;
      }
      if(0x41 <=i && i<=0x46){
        return i- 0x41 +10;
      }
      if(0x61 <=i && i<=0x66){
        return i- 0x61 +10;
      }else {
        throw "wrong value";
      }
    }
    for (var i=0,o=0;i<codes.length;i+=2,o++) {
      var v1 = hex(codes[i+0]);
      var v2 = hex(codes[i+1]);
      buffer.buffer[o] = (0x0f & v2) | (0xf0 & (v1<<4));
    }
    return buffer;
  }
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
      ret.write(((c>>4)&0x0F).toRadixString(16));
      ret.write((c & 0x0F).toRadixString(16));
    }
    return ret.toString();
  }

  @override
  String toString(){
    return conv.utf8.decode(buffer.buffer.asUint8List());
  }
}