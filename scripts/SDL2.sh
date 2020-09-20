#!/bin/bash

set -e

VERSION=2.0.12

curl -L https://www.libsdl.org/release/SDL2-"$VERSION".tar.gz | tar xz

mkdir build
pushd build

cmake ../SDL2-"$VERSION" -DBUILD_SHARED_LIBS=Off $CMAKE_CONFIGURE_ARGS
cmake --build . $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS

LIBS=("$PWD"/"${OUTDIR}"*"$LIBSUFFIX")
popd
pushd SDL2-"$VERSION"
INCLUDES=("$PWD"/include/*)
popd
