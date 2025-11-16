#!/bin/bash -l

#SBATCH -p rome
#SBATCH -w rome005,rome006,rome007,rome008
#SBATCH -o task-%j.out

# sbatch ./run_task.sh ./task_a/hello
module purge
module load doca/2.0.2

. env.sh 

COMMAND_=$@

echo "cmd : $COMMAND_"
MPI_PATH=$PKG/ompi/ref/x86_64
UCX_LIB=$PKG/ucx/aarch64/lib

export OPAL_PREFIX=$MPI_PATH
export LD_LIBRARY_PATH=$MPI_PATH/lib:$LD_LIBRARY_PATH

OPAL_PREFIX=$MPI_PATH $MPI_PATH/bin/mpirun -q  -x PAL_PREFIX=$MPI_PATH \
	-x LD_LIBRARY_PATH=$MPI_PATH/lib:$UCX_LIB:$PKG/pnetcdf/lib:$LD_LIBRARY_PATH \
	-np 4 -H rome005,rome006,rome007,rome008 -x OMP_NUM_THREADS=55 $COMMAND_

