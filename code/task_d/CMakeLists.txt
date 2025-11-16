cmake_minimum_required(VERSION 3.20.1)

set(CMAKE_C_COMPILER ${CLANG_PATH}/bin/clang)
set(CMAKE_C_FLAGS "-fopenmp -fopenmp-targets=aarch64-unknown-linux")
set(INCLUDE_PATH  "${CLANG_PATH}/include/")

project(net_accel)

add_executable(net_accel net_accel.c)

target_include_directories(
	net_accel	
	PRIVATE
	${INCLUDE_PATH}	
)

