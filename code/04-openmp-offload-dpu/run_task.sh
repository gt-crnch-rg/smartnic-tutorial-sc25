#!/bin/bash -l

#SBATCH --reservation sc24_tutorial
#SBATCH --partition rg-nextgen-hpc
#SBATCH --nodelist dash3-bf3-1
#SBATCH --output task-%j.out
#SBATCH --error task-%j.err
#SBATCH --time 0:1:0
#SBATCH --exclusive

# The following line is only for task c
if [ -n "$LIB_" ]; then
	echo "lib path: $LIB_"
	export LD_LIBRARY_PATH=$LIB_/x86:$LD_LIBRARY_PATH
fi

# Loading modules
module use /projects/tools/x86_64/ubuntu-22.04/modulefiles/
module load odos-dpu

COMMAND_=$@

echo "cmd : $COMMAND_"

$COMMAND_
