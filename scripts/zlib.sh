#!/bin/bash

set -e

VERSION=2.1.3
curl -L https://github.com/zlib-ng/zlib-ng/archive/refs/tags/"$VERSION".tar.gz | tar -xz

mkdir build
pushd build

$CMAKE_CONFIGURE_BINARY ../zlib-ng-"$VERSION" -DZLIB_COMPAT=On -DZLIB_ENABLE_TESTS=Off -DWITH_GZFILEOP=Off $CMAKE_CONFIGURE_ARGS
cmake --build . $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS

rm -f "$OUTPUT_DIR"/lib/{libz.so*,libz*.dylib,zlib.lib}

popd

license zlib-ng "zlib-ng-$VERSION/LICENSE.md" zlib
wasm_add_cmake_configuration_args -DZLIB_LIBRARY="$OUTPUT_DIR"/lib/libza.a -DZLIB_INCLUDE_DIR="$OUTPUT_DIR"/include
