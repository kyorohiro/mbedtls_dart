FROM ubuntu:20.04

# install vscode (code-server)
WORKDIR /works
COPY ./build_resource/code-server-3.0.0-linux-x86_64.tar.gz /works/code-server-3.0.0-linux-x86_64.tar.gz
RUN tar -xzf code-server-3.0.0-linux-x86_64.tar.gz -C ./ --strip-components 1
RUN /works/code-server --install-extension ms-vscode.cpptools

# install C
WORKDIR /works
RUN apt-get update
RUN apt-get install -y wget gnupg1
RUN apt-get install musl-dev -y
RUN apt-get install build-essential -y
RUN apt-get install cmake -y 
RUN apt-get install python3 -y

# install embedtls
COPY ./build_resource/mbedtls-2.16.5-apache.tgz /works/mbedtls-2.16.5-apache.tgz
RUN tar zxf mbedtls-2.16.5-apache.tgz
WORKDIR /works/mbedtls-2.16.5/build
#RUN cmake ..
RUN cmake -DUSE_SHARED_MBEDTLS_LIBRARY=On -DUSE_STATIC_MBEDTLS_LIBRARY=On ..
RUN make
RUN make install

# install Dart
RUN apt-get update
RUN apt-get install -y wget gnupg1
RUN apt-get install apt-transport-https
RUN sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN apt-get update
RUN apt-get -y install dart
RUN /works/code-server --install-extension Dart-Code.dart-code

ENV PATH=${PATH}:/lib/dart/bin
ENV PATH="${PATH}:/root/.pub-cache/bin"


CMD ["/works/code-server", "--auth","none", "--host","0.0.0.0","--port","8443", "/app"]
