import 'dart:io' as io;

/**
#!/bin/sh

find . -name "*.o" | xargs rm
gcc -Wall -Werror -fpic -I. -c buffer.c -o buffer.o 
gcc -Wall -Werror -fpic -I. -c md5.c -o md5.o
gcc -Wall -Werror -fpic -I. -c sha1.c -o sha1.o
gcc -shared -o libkycrypt.so sha1.o md5.o buffer.o /usr/local/lib/libmbedcrypto.a 

 */

var files= [
  'src/buffer.c', 'src/md5.c', 'src/sha1.c', 'src/sha256.c', 'src/sha512.c', 'src/aes.c'
];

void rm_obj(){
   io.Process.runSync('rm', ['*.o']);
}

void gcc_obj(String filename){
  var args = [
     '-Wall', '-Werror', '-fpic', '-I./src',
     '-c', filename,
    '-o', filename.replaceAll('.c', '.o').replaceAll("src", "build")
  ];
  print("gcc ${args}");
  var r = io.Process.runSync('gcc', args);
  print(r.stdout);
  print(r.stderr);
}

void link_obj(List<String> files) {
  var objs = files.map((v)=> v.replaceAll('.c', '.o').replaceAll("src", "build"));
  var  args = <String>[];
  args.addAll(['-shared', '-o', 'build/libkycrypt.so']);
  args.addAll(objs); 
  args.addAll(['/usr/local/lib/libmbedcrypto.a']);
  print("gcc ${args}");
  var r = io.Process.runSync('gcc', args);
  print(r.stdout);
  print(r.stderr);
}

void main() {
  rm_obj();
  for(var f in files) {
    gcc_obj(f);
  }
  link_obj(files);

}