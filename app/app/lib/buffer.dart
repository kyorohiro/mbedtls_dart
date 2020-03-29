
import 'dart:typed_data';

abstract class Buffer {
  int _len;
  Buffer(int len) {
    _len = len;
  }
  Uint8List get buffer;
  int get len => _len;
  void dispose();
}