#!/bin/bash

set -e

VERSION=2.13.1

curl -L https://download-mirror.savannah.gnu.org/releases/freetype/freetype-"$VERSION".tar.gz | tar -xz

mkdir build
pushd build

$CMAKE_CONFIGURE_BINARY ../freetype-"$VERSION" -DCMAKE_DISABLE_FIND_PACKAGE_BrotliDec=TRUE -DCMAKE_DISABLE_FIND_PACKAGE_BZip2=TRUE "$@" $CMAKE_CONFIGURE_ARGS
cmake --build . $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS

popd
license freetype "freetype-$VERSION/docs/FTL.TXT"
