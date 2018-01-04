#!/bin/sh

libtoolize --copy
autoreconf -vfi

./configure          \
  --prefix=${PREFIX} \
  --enable-static    \
  --enable-shared    \
  --without-octave   \
  --without-matlab   \
  --without-guile

make -j${CPU_COUNT} ${VERBOSE_AT}
make install ${VERBOSE_AT}
