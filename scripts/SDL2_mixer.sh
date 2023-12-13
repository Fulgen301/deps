#!/bin/bash

set -e

VERSION=2.6.3

curl -L https://github.com/libsdl-org/SDL_mixer/releases/download/release-"$VERSION"/SDL2_mixer-"$VERSION".tar.gz | tar -xz --exclude="Xcode*"

pushd SDL2_mixer-"$VERSION"

patch -p1 <"$PATCH_DIR/SDL2_mixer.patch"
patch -p1 <"$PATCH_DIR/SDL2_mixer_memory_waste.patch"
rm "cmake/FindMPG123.cmake"

mkdir build
pushd build

perl -i -pe's/SDL2_mixer-static/SDL2_mixer/g' ../CMakeLists.txt

OS_OPTIONS=""

if [ "$OS" = "Linux" ]; then
	OS_OPTIONS="-DSDL2MIXER_MIDI_FLUIDSYNTH=ON"
else
	OS_OPTIONS="-DSDL2MIXER_MIDI_FLUIDSYNTH=OFF -DSDL2MIXER_MIDI_NATIVE=ON"
fi

$CMAKE_CONFIGURE_BINARY .. \
	-DSDL2MIXER_DEPS_SHARED=OFF \
	-DSDL2MIXER_VENDORED=OFF \
	-DSDL2MIXER_INSTALL=ON \
	-DSDL2MIXER_FLAC=OFF \
	-DSDL2MIXER_MOD_MODPLUG=ON \
	-DSDL2MIXER_MOD_XMP=OFF \
	-DSDL2MIXER_MP3_DRMP3=OFF \
	-DSDL2MIXER_MP3_MPG123=ON \
	-DSDL2MIXER_OPUS=OFF \
	-DSDL2MIXER_VORBIS=VORBISFILE \
	-DSDL2MIXER_VORBIS_VORBISFILE_SHARED=OFF \
	-DSDL2MIXER_SAMPLES=OFF \
	$OS_OPTIONS $CMAKE_CONFIGURE_ARGS \

cmake --build . $CMAKE_BUILD_ARGS
cmake --install . $CMAKE_BUILD_ARGS

popd

license SDL2_mixer "LICENSE.txt" zlib
popd
