#!/bin/bash

set -e

VERSION=3.0.0
until curl -L https://downloads.sourceforge.net/project/libjpeg-turbo/"$VERSION"/libjpeg-turbo-"$VERSION".tar.gz | tar -xz; do sleep 1; done

mkdir build
pushd build

$CMAKE_CONFIGURE_BINARY ../libjpeg-turbo-"$VERSION" -DENABLE_SHARED=Off -DWITH_JPEG8=On -DWITH_TURBOJPEG=Off $CMAKE_CONFIGURE_ARGS
cmake --build . $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS


popd

license libjpeg-turbo "libjpeg-turbo-$VERSION/LICENSE.md"
