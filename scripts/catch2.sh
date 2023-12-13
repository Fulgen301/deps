#!/bin/bash

set -e

VERSION=v3.4.0

git clone --depth 1 --branch $VERSION https://github.com/catchorg/Catch2 Catch2

mkdir build
pushd build

$CMAKE_CONFIGURE_BINARY ../Catch2 -DBUILD_TESTING=Off $CMAKE_CONFIGURE_ARGS
cmake --build . $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS

popd

license Catch2 Catch2/LICENSE.txt
