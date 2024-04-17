
mkdir build && cd build

set CMAKE_CONFIG="Release"

REM nlopt is used by r-nloptr so a Python interface isn't needed on win64
cmake -LAH -G"NMake Makefiles"                     ^
  -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"           ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"        ^
  -DNLOPT_PYTHON=OFF ^
  ..
if errorlevel 1 exit 1

cmake --build . --config %CMAKE_CONFIG% --target install
if errorlevel 1 exit 1

copy nlopt.dll test
ctest --output-on-failure --timeout 100
if errorlevel 1 exit 1
