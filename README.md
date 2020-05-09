Coder Server 's develop environment  for mbed TLS 

# support now

for wasm and io

- allocate buffer
- md5
- sha1
- sha256
- sha512
- aes cbc
- aes ecb



# preperation

Get code-server-3.0.0-linux-x86_64.tar.gz from https://github.com/cdr/code-server/releases/download/3.0.0/code-server-3.0.0-linux-x86_64.tar.gz  And copy to app/build_resource/code-server-3.0.0-linux-x86_64.tar.gz

Get mbedtls-2.16.5-apache.tgz from https://tls.mbed.org/download/start/mbedtls-2.16.5-apache.tgz And copy to app/build_resource/mbedtls-2.16.5-apache.tgz

[ref]
https://github.com/cdr/code-server/releases

https://tls.mbed.org/tech-updates/releases/mbedtls-2.16.5-and-2.7.14-released

# create env

```
$ docker-compose build
$ docker-compose up -d
```

--> http://0.0.0.0:8443/ 

* change 0.0.0.0 to your docker-machine's ip




# build 

on code-server's terminal 

```
$ bash
$ cd libc
$ sh build.sh
$ cd ..
$ dart test/buffer_test.dart
$ webdev serve --hostname=0.0.0.0 web 
..
..
```

