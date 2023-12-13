#!/bin/bash

set -e

VERSION=1.31.3
until curl -L https://downloads.sourceforge.net/sourceforge/mpg123/mpg123-"$VERSION".tar.bz2 | tar -xj; do sleep 1; done

mkdir build
pushd build

$CMAKE_CONFIGURE_BINARY ../mpg123-"$VERSION"/ports/cmake -DBUILD_LIBOUT123=Off -DBUILD_PROGRAMS=Off -DNETWORK=Off $CMAKE_CONFIGURE_ARGS
cmake --build . $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS

popd

license libmpg123 "mpg123-$VERSION/COPYING" "LGPL-2.1"
