#!/bin/sh

set -euo pipefail

if [ "$(uname)" = "Darwin" ]; then
  # osx uses a temp directory which messes up with cmake finding libraries.
  cd "${SRC_DIR}"
fi

mkdir build
cd build

# nlopt is used by r-nloptr so a Python interface isn't needed on win64.
# Every supported programming language can have its interface of nlopt
# but creating the Python interface will require python in host and at runtime.
# That means then we need to build nlopt for all python versions (four at this moment).
# Hence, r-nloptr will be built for all 4 Python versions and the same applies
# to all 350 downstream R packages. It's a lot of redundancy.
# And R packages seem not to require the Python interface.
cmake \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_INSTALL_LIBDIR=lib \
  -DNLOPT_PYTHON=OFF \
  -DNLOPT_GUILE=OFF \
  -DNLOPT_MATLAB=OFF \
  -DNLOPT_OCTAVE=OFF \
  ..

make install -j${CPU_COUNT}
ctest --output-on-failure
