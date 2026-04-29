#!/bin/bash
set -e

FAST=${1}

if [ ! -d contrib/native ] || [[ "${FAST}" != "1" ]]; then
	echo "Standard build mode: building contribs..."
	# Build Contribs
	mkdir -p contrib/native
	pushd contrib/native
	../../contrib/bootstrap
	make -j${BB_BUILD_JOBS:-2}
	popd
else
	echo "Fast build mode: skipping contrib build"
fi

# Build VLC
if [ ! -f config.h ] || [[ "${FAST}" != "1" ]]; then
	echo "Standard build mode: bootstrapping and configuring..."
	./bootstrap
	./configure --prefix="${BB_TARGET_BUILD_DIR}" --disable-chromecast --disable-asdcp
else
	echo "Fast build mode: skipping bootstrap and configuration"
fi

echo "Building VLC..."
make -j${BB_BUILD_JOBS:-2}
make install
