cmake_minimum_required(VERSION 3.20.1)

project(hello)

set(CMAKE_C_COMPILER $ENV{ODOS}/bin/clang)

set(CFLAGS "-fopenmp")
set(CFLAGS "${CFLAGS} -fopenmp-targets=aarch64-unknown-linux")
set(CFLAGS "${CFLAGS} -L$ENV{ODOS}/lib_cross/")
set(CMAKE_C_FLAGS ${CFLAGS})

add_executable(hello hello.c)

target_include_directories(hello PUBLIC $ENV{ODOS}/include/)

message(STATUS "compiler : ${CMAKE_C_COMPILER}")
message(STATUS "flags    : ${CMAKE_C_FLAGS}")
message(STATUS "include  : $ENV{ODOS}/include/")

