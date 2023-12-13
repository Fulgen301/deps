#!/bin/bash

set -e

VERSION=2.2.0

until curl -L https://downloads.sourceforge.net/glew/glew-"$VERSION".tgz | tar -xz; do sleep 1; done

pushd glew-"$VERSION"/build

$CMAKE_CONFIGURE_BINARY ./cmake -DBUILD_UTILS=Off $CMAKE_CONFIGURE_ARGS
cmake --build . --target glew_s $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS

popd

license GLEW "glew-$VERSION/LICENSE.txt"
