#!/bin/bash -l

#SBATCH -p rome
#SBATCH -w romebf3a006
#SBATCH -o service-%j.out

# sbatch ./run_service.sh
module purge
module load doca/2.0.2

. env.sh

CLANG_PATH=$PKG/odos/

LIB_C=`pwd`/out/tasks/

LD_LIBRARY_PATH=$LIB_C:$LD_LIBRARY_PATH $CLANG_PATH/service/doca-omp-service

