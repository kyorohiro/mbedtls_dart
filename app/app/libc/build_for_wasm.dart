import 'dart:io' as io;
/**
#!/bin/bash

find . -name "*.o" | xargs rm
find . -name "*.wasm" | xargs rm
emcc buffer.c -o buffer.o 
emcc md5.c -o md5.o -I/works/mbedtls-2.16.5/include/
emcc buffer.o md5.o -o kycrypt.js -lmbedcrypto -L/works/mbedtls-2.16.5/library -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' -s EXPORTED_FUNCTIONS="['_KyBuffer_alloc','_KyBuffer_free','_KyMd5_alloc','_KyMd5_alloc','_KyMd5_init','_KyMd5_starts','_KyMd5_update','_KyMd5_end','_KyMd5_free']"

cat kycrypt_buffer.js >> kycrypt.js
cp kycrypt.js ../web/kycrypt.js
cp kycrypt.wasm ../web/kycrypt.wasm
*/
// emcc build/buffer.o build/md5.o -o build/kycrypt.js -lmbedcrypto -L/works/mbedtls-2.16.5/library -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' -s EXPORTED_FUNCTIONS="['_KyBuffer_alloc','_KyBuffer_free','_KyMd5_alloc','_KyMd5_alloc','_KyMd5_init','_KyMd5_starts','_KyMd5_update','_KyMd5_end','_KyMd5_free']"


var files= [
  'src/buffer.c', 'src/md5.c', 'src/sha1.c', 'src/sha256.c', 'src/sha512.c', 'src/aes.c'
];

var funcs = [
  '_KyBuffer_alloc',
  '_KyBuffer_free',
  //
  '_KyMd5_alloc',
  '_KyMd5_init',
  '_KyMd5_starts',
  '_KyMd5_update',
  '_KyMd5_end',
  '_KyMd5_free',
  //
  '_KySHA1_alloc',
  '_KySHA1_init',
  '_KySHA1_starts',
  '_KySHA1_update',
  '_KySHA1_end',
  '_KySHA1_free',
  //
  '_KySHA256_alloc',
  '_KySHA256_init',
  '_KySHA256_starts',
  '_KySHA256_update',
  '_KySHA256_end',
  '_KySHA256_free',
  //
  '_KySHA512_alloc',
  '_KySHA512_init',
  '_KySHA512_starts',
  '_KySHA512_update',
  '_KySHA512_end',
  '_KySHA512_free',
  //
  '_KyAES_alloc',
  '_KyAES_init',
  '_KyAES_setKeyForEncode',
  '_KyAES_setKeyForDecode',
  '_KyAES_encryptAtCBC',
  '_KyAES_decryptAtCBC',
  '_KyAES_encryptAtECB',
  '_KyAES_decryptAtECB',
  '_KyAES_free'
  //
];

void rm_obj(){
   io.Process.runSync('rm', ['build/*.o']);
   io.Process.runSync('rm', ['build/*.wasm']);
   io.Process.runSync('rm', ['build/kycrypt.js']);
}

void gcc_obj(String filename){
  print("gcc obj :　${filename}\n");
  var args = [
     '-I/works/mbedtls-2.16.5/include/', '-I.src',
     '-c', filename,
     '-o', filename.replaceAll('.c', '.o').replaceAll("src", "build")
  ];
  var result = io.Process.runSync('emcc', args);
  print(">>> ${result.stderr}");
  print(">>> ${result.stdout}");
  print(">>> ${result.exitCode}");
}

void link_obj(List<String> files) {

  var objs =  files.map((v)=> v.replaceAll('.c', '.o').replaceAll("src", "build"));
  var exps = funcs.map((v){
    return "'"+v+"'";
  }).join(",");
  var exp= 'EXPORTED_FUNCTIONS=['+exps+']';

  var  args = [
    '-shared', 
    '-o','./build/kycrypt.js', 
    '-l','mbedcrypto',
    '-L','/works/mbedtls-2.16.5/library', 
    '-s',"EXTRA_EXPORTED_RUNTIME_METHODS=['cwrap']",
    '-s',exp
  ];
  args.addAll(objs); 
  print("${args}");
  var result = io.Process.runSync('emcc', args);
  print(">>> ${result.stderr}");
  print(">>> ${result.stdout}");
  print(">>> ${result.exitCode}");
}

void copy_package(){
   var input = io.File("./src/kycrypty_util.js");
   var output = io.File("./build/kycrypt.js");
   print("^^^^D1");
   output.writeAsStringSync("\n",mode: io.FileMode.append);
   print("^^^^D2");
   output.writeAsStringSync(input.readAsStringSync(),mode: io.FileMode.append);
   print("^^^^D3");
   output.writeAsStringSync("\n",mode: io.FileMode.append);
   print("^^^^D4");
   
   var result = io.Process.runSync('cp', ['./build/kycrypt.js','../web/kycrypt.js']);
   print(">>> ${result.stderr}");
   print(">>> ${result.stdout}");
   print(">>> ${result.exitCode}");
   result = io.Process.runSync('cp', ['./build/kycrypt.wasm','../web/kycrypt.wasm']);
   print(">>> ${result.stderr}");
   print(">>> ${result.stdout}");
   print(">>> ${result.exitCode}");

}
void main() {

  rm_obj();
  for(var f in files) {
    gcc_obj(f);
  }
  link_obj(files);
  copy_package();
}