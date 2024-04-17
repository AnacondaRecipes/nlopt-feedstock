#!/bin/sh

if [ "$(uname)" = "Darwin" ]; then
  # osx uses a temp directory which messes up with cmake finding libraries.
  cd "${SRC_DIR}" || exit
fi

mkdir build && cd build || exit
cmake \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_INSTALL_LIBDIR=lib \
  -DNLOPT_GUILE=OFF -DNLOPT_MATLAB=OFF -DNLOPT_OCTAVE=OFF \
  ..

make install -j${CPU_COUNT}
ctest --output-on-failure

DIST_INFO_PATH=${SP_DIR}/${PKG_NAME}-${PKG_VERSION}.dist-info
mkdir -p $DIST_INFO_PATH
touch $DIST_INFO_PATH/METADATA
