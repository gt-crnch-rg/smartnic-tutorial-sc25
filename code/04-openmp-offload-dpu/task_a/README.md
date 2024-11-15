## Code Sample 4 - OpenMP DPU Offloading Support - Hello World

### Compilation

This step is only needed if a previous compilation of the task was not done.

```
[user@rg-login]$ cd 04-openmp-offload-dpu
#Note you should select a number between 1 and 4 for node number
$ ./request_bf3_heterogenous_slurm_job.sh 2
#The rest of the following instructions assume that the node 2 was requested.
[user@dash2]$ source /etc/profile
[user@dash2]$ module use /projects/tools/x86_64/ubuntu-22.04/modulefiles/
[user@dash2]$ module load odos-dpu cmake
[user@dash2]$ cd task_a
[user@dash2]$ rm -rf build ; mkdir build && cd build && cmake .. && make && cd ..
[user@dash2]$ exit
```

### Execution

```
[user@rg-login]$ ./run_service.sh 2
#Good result: Submitted batch job 14234
[user@rg-login]$ sbatch --export=NONE ./run_task.sh ./task_a/build/hello
#Result: Submitted batch job 14235
#Kill the service
[user@rg-login]$ scancel 14234
```

### Output

You can check the generated output files or refer to `out/*` for the reference outputs.
