## Code Sample 4 - OpenMP DPU Offloading Support - Shared library

### Compilation

This step is only needed if a previous compilation of the task was not done.

```
[user@rg-login]$ cd 04-openmp-offload-dpu
#Note you should select a number between 1 and 4 for node number
$ ./request_bf3_heterogenous_slurm_job.sh 4
#The rest of the following instructions assume that the node 4 was requested.
[user@dash4]$ source /etc/profile
[user@dash4]$ module use /projects/tools/x86_64/ubuntu-22.04/modulefiles/
[user@dash4]$ module load odos-dpu cmake
[user@dash4]$ cd task_c
[user@dash4]$ sh compile.sh
[user@dash4]$ exit
```

The compilation script will create a build directory and add shared objects, differentiated by architecture and application binary, into it.

### Execution

```
[user@rg-login] export LIB_=$(pwd)/task_c/build
[user@rg-login]$ ./run_service.sh 4
#Good result: Submitted batch job 14267
[user@rg-login]$ sbatch --export=LIB_ ./run_task.sh ./task_c/build/shared
#Result: Submitted batch job 14268
#Kill the service
[user@rg-login]$ scancel 14267
```

### Output

You can take a look to the generated output files or see `out/*` for reference outputs.
