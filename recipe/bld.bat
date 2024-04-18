
mkdir build && cd build

set CMAKE_CONFIG="Release"

REM nlopt is used by r-nloptr so a Python interface isn't needed on win64.
REM Every supported programming language can have its interface of nlopt
REM but creating the Python interface will require python in host and at runtime.
REM That means then we need to build nlopt for all python versions (four at this moment).
REM Hence, r-nloptr will be built for all 4 Python versions and the same applies
REM to all 350 downstream R packages. It's a lot of redundancy.
REM And R packages seem not to require the Python interface.
cmake -LAH -G"NMake Makefiles"                     ^
  -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"           ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"        ^
  -DNLOPT_PYTHON=OFF ^
  -DNLOPT_SWIG=OFF ^
  -DNLOPT_GUILE=OFF ^
  -DNLOPT_MATLAB=OFF ^
  -DNLOPT_OCTAVE=OFF ^
  ..
if errorlevel 1 exit 1

cmake --build . --config %CMAKE_CONFIG% --target install
if errorlevel 1 exit 1

copy nlopt.dll test
ctest --output-on-failure --timeout 100
if errorlevel 1 exit 1
