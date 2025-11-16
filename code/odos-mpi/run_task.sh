#!/bin/bash -l

#SBATCH -p rome
#SBATCH -w rome006
#SBATCH -o task-%j.out

# sbatch ./run_task.sh ./task_a/hello
module purge
module load doca/2.0.2

. env.sh

CLANG_PATH=$PKG/odos/

COMMAND_=$@

echo "cmd : $COMMAND_"

LIB_C=`pwd`/out/tasks/

LD_LIBRARY_PATH=$LIB_C:$LD_LIBRARY_PATH $COMMAND_

