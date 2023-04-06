#!/bin/bash

set -e

VERSION=2.26.2
curl -L https://github.com/libsdl-org/SDL/releases/download/release-"$VERSION"/SDL2-"$VERSION".tar.gz | tar -xz

pushd SDL2-"$VERSION"
patch -p1 <"$PATCH_DIR/SDL2_macos_context_deletion_black_screen.patch"
popd

mkdir build
pushd build

perl -i -pe's/SDL2-static/SDL2/g' ../SDL2-"$VERSION"/CMakeLists.txt

cmake ../SDL2-"$VERSION" \
-DSDL_METAL=Off \
-DSDL_RENDER_METAL=Off \
-DSDL_TEST=Off \
$CMAKE_CONFIGURE_ARGS

cmake --build . $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS

popd

license SDL2 "SDL2-$VERSION/LICENSE.txt" zlib
