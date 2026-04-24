#!/bin/bash
set -e

# Build Contribs
mkdir -p contrib/native
pushd contrib/native
../bootstrap
make -j${BB_BUILD_JOBS:-2}
popd

# Build VLC
# We use the prefix to install into the BuildBox target directory
./bootstrap
./configure --prefix="${BB_TARGET_BUILD_DIR}" --disable-chromecast --disable-asdcp
make -j${BB_BUILD_JOBS:-2}
make install
