#!/bin/bash -l

#SBATCH -p rome
#SBATCH -w romebf3a005,romebf3a006,romebf3a007,romebf3a008
#SBATCH -o service-%j.out

# sbatch ./run_service.sh
module purge
module load doca/2.0.2

. env.sh

CLANG_PATH=$PKG/odos/
MPI_PATH=$PKG/ompi/ref/aarch64
UCX_LIB=$PKG/ucx/aarch64/lib

export OPAL_PREFIX=$MPI_PATH
export LD_LIBRARY_PATH=$MPI_PATH/lib:$LD_LIBRARY_PATH

$MPI_PATH/bin/mpirun -q -x OPAL_PREFIX=$MPI_PATH \
	-x LD_LIBRARY_PATH=$MPI_PATH/lib:$UCX_LIB:$LD_LIBRARY_PATH \
	-np 4 -H romebf3a005,romebf3a006,romebf3a007,romebf3a008   \
	$CLANG_PATH/service/doca-omp-service5-mpi

