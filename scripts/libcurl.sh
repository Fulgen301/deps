#!/bin/bash

set -e

VERSION=8.4.0

curl -L https://curl.haxx.se/download/curl-"$VERSION".tar.xz | tar -xJ

mkdir build
pushd build

OS_OPTIONS=""

if [ "$OS" = "Mac" ]; then
	OS_OPTIONS=-DCURL_USE_SECTRANSP=On
elif [ "$OS" = "Windows" ]; then
	OS_OPTIONS="-DCURL_USE_SCHANNEL=On -DENABLE_UNICODE=On"
fi

$CMAKE_CONFIGURE_BINARY ../curl-"$VERSION" -DBUILD_CURL_EXE=Off -DHTTP_ONLY=On -DENABLE_MANUAL=Off -DCURL_USE_LIBSSH2=Off -DURL_USE_LIBSSH=Off $OS_OPTIONS $CMAKE_CONFIGURE_ARGS
cmake --build . $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS


popd

license curl "curl-$VERSION/COPYING"
