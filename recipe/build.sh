#!/bin/sh

# if [ "$(uname)" = "Darwin" ]; then
#   export LDFLAGS="-L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib ${LDFLAGS}"
# fi

mkdir build && cd build || exit
cmake \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_INSTALL_LIBDIR="${PREFIX}/lib" \
  -DNLOPT_GUILE=OFF -DNLOPT_MATLAB=OFF -DNLOPT_OCTAVE=OFF \
  ..

make install -j${CPU_COUNT}
ctest --output-on-failure

DIST_INFO_PATH=${SP_DIR}/${PKG_NAME}-${PKG_VERSION}.dist-info
mkdir -p $DIST_INFO_PATH
touch $DIST_INFO_PATH/METADATA
