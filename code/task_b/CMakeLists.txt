cmake_minimum_required(VERSION 3.20.1)


set(CMAKE_C_COMPILER ${CLANG_PATH}/bin/clang)
set(CMAKE_C_FLAGS "-fopenmp -fopenmp-targets=aarch64-unknown-linux")
set(INCLUDE_PATH  "${CLANG_PATH}/include/")

project(omp_parallel)

add_executable(omp_parallel omp_parallel.c)

target_include_directories(
	omp_parallel	
	PRIVATE
	${INCLUDE_PATH}	
)

