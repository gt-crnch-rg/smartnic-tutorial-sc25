#!/bin/sh

CC=${ODOS}/bin/clang
TARGET=aarch64-unknown-linux
CFLAGS="-fopenmp -fopenmp-targets=$TARGET"

set -x

rm -rf build
mkdir build && cd build
mkdir x86   && cd x86 

$CC ../../log.c -shared                 -o liblog.so

cd ../ && mkdir aarch64 && cd aarch64

$CC ../../log.c -shared -target $TARGET -o liblog.so

cd ..

$CC ../shared.c  $CFLAGS -o shared      \
	-L`pwd`/x86 -L`pwd`/aarch64/ -llog  \
	-I${ODOS}/include/ -L${ODOS}/lib_cross/
	
cd ..

