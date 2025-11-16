#!/bin/sh

module load cmake doca/2.0.2


PKG=${HOME}/mpi-odos-pkg

export PATH=$PKG/odos/bin:$PATH

export LD_LIBRARY_PATH=$PKG/ucx/x86_64/install/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$PKG/ucx/aarch64/install/lib:$LD_LIBRARY_PATH

export BLUEFIELD_SYSROOT=/global/software/centos-8.x86_64/modules/tools/gcc-arm/8.3/aarch64-linux-gnu/libc
export BLUEFIELD_GCC_TOOLCHAIN=/global/software/centos-8.x86_64/modules/tools/gcc-arm/8.3


