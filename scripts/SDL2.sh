#!/bin/bash

set -e

VERSION=2.28.1
curl -L https://github.com/libsdl-org/SDL/releases/download/release-"$VERSION"/SDL2-"$VERSION".tar.gz | tar -xz

pushd SDL2-"$VERSION"
python3 -c "import pathlib; p = pathlib.Path('cmake/sdlchecks.cmake'); p.write_bytes(p.read_bytes().replace(b'list(APPEND SDL_REQUIRES_PRIVATE SampleRate::samplerate)', b'list(APPEND EXTRA_LIBS samplerate)'))"
popd

mkdir build
pushd build

perl -i -pe's/SDL2-static/SDL2/g' ../SDL2-"$VERSION"/CMakeLists.txt

$CMAKE_CONFIGURE_BINARY ../SDL2-"$VERSION" \
-DSDL_LIBSAMPLERATE=On \
-DSDL_LIBSAMPLERATE_SHARED=Off \
-DSDL_METAL=Off \
-DSDL_RENDER_METAL=Off \
-DSDL_TEST=Off \
$CMAKE_CONFIGURE_ARGS

cmake --build . $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS

popd

license SDL2 "SDL2-$VERSION/LICENSE.txt" zlib
