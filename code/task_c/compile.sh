#!/bin/sh

CLANG_PATH=$1

CC=$CLANG_PATH/bin/clang
TARGET=aarch64-unknown-linux
CFLAGS="-fopenmp -fopenmp-targets=$TARGET"

set -x

cd build
$CC ../log.c -shared                 -o liblog_x86.so
$CC ../log.c -shared -target $TARGET -o liblog_aarch64.so

$CC ../shared.c  $CFLAGS -o shared  \
	-L. -llog_x86                   \
	-Wl,--device-linker=-L.,--device-linker=-llog_aarch64 \
	-I $CLANG_PATH/include
	

