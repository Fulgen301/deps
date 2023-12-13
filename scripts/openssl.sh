#!/bin/bash

set -e

VERSION=3.1.1

curl -L https://www.openssl.org/source/openssl-"$VERSION".tar.gz | tar -xz

mkdir build
pushd build

if [ "$OS" = "WASM" ]; then
    configure_cmd=emconfigure
fi

CFLAGS="$C_XX_FLAGS" CXXFLAGS="$C_XX_FLAGS" LDFLAGS="$LINK_FLAGS" $configure_cmd ../openssl-"$VERSION"/config --prefix="$OUTPUT_DIR" --libdir=lib no-dso no-module no-shared no-tests
$MAKE_CMD
$MAKE_CMD install_sw

popd

license OpenSSL "openssl-$VERSION/LICENSE.txt"
