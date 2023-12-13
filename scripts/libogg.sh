#!/bin/bash

set -e

VERSION=1.3.5

curl -L https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-"$VERSION".tar.gz | tar -xz

mkdir build
pushd build

$CMAKE_CONFIGURE_BINARY ../*ogg-* $CMAKE_CONFIGURE_ARGS
cmake --build . $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS

popd

license libogg *ogg-*/COPYING
