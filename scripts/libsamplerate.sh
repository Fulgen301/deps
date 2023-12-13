#!/bin/bash

set -e

VERSION=0.2.2

curl -L "https://github.com/libsndfile/libsamplerate/releases/download/$VERSION/libsamplerate-$VERSION.tar.xz" | tar -xJ

mkdir build
pushd build

$CMAKE_CONFIGURE_BINARY "../libsamplerate-$VERSION" \
-DBUILD_TESTING=Off \
-DLIBSAMPLERATE_EXAMPLES=Off \
$CMAKE_CONFIGURE_ARGS

cmake --build . $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS

popd

license libsamplerate "libsamplerate-$VERSION/COPYING" 'BSD 2-Clause'
wasm_add_cmake_configuration_args -DLIBSAMPLERATE_INCLUDE_DIR="$OUTPUT_DIR"/include
