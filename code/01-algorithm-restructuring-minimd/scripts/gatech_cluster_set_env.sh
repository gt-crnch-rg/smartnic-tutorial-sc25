#!/bin/bash

# Source this script to set your environment on each machine to run the heterogeneous MiniMD example

# Query Architecture
arch=$(uname -i)
# Create unique symlink name
FILE=/tmp/hpcx-$USER

# Unlink existing symlink if it exists
if test -h $FILE; then
	unlink $FILE
fi

ln -s /projects/tools/$(uname -i)/ubuntu-22.04/hpcx-v2.18-gcc-mlnx_ofed-ubuntu22.04-cuda12-$(uname -i) $FILE
export PATH=$FILE/ucx/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$FILE/ucx/lib:$FILE/ompi/lib/:$LD_LIBRARY_PATH

source $FILE/hpcx-init.sh
hpcx_load

# Prevent mpicxx failure with -mavx in BF3 devices
if [ "$arch" == 'aarch64' ]; then
	export AVX=No
fi
