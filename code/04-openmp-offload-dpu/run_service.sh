#!/bin/bash -l

if [ "$#" -ne 1 ]; then
    echo "Please use ./run_service N; example: ./run_service 3"
    exit 2
fi

NODE=$1

sed -i 's/--nodelist .*/--nodelist dash'$NODE'/g' run_task.sh

sbatch --export=LIB_ <<EOT
#!/bin/bash
#SBATCH --reservation sc24_tutorial
#SBATCH --partition rg-nextgen-hpc
#SBATCH --nodelist dash$NODE-bf3-1
#SBATCH --output service-%j.out
#SBATCH --error service-%j.err
#SBATCH --cpus-per-task 8
#SBATCH --time 0:10:00
#SBATCH --exclusive

# The following line is only for task c
if [ -n "$LIB_" ]; then
        echo "lib path: $LIB_"
        export LD_LIBRARY_PATH=$LIB_/aarch64:$LD_LIBRARY_PATH
fi

export OMP_NUM_THREADS=\$SLURM_CPUS_PER_TASK

# Loading modules
source /etc/profile
module use /projects/tools/x86_64/ubuntu-22.04/modulefiles/
module load odos-dpu

stdbuf -o0 -e0 \$ODOS/service/doca-omp-service

EOT
