## Code Sample 4 - OpenMP DPU Offloading Support - OpenMP Parallel feature

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
[user@dash4]$ cd task_b
[user@dash4]$ rm -rf build ; mkdir build && cd build && cmake .. && make && cd ..
[user@dash4]$ exit
```

### Execution

```
[user@rg-login]$ ./run_service.sh 4
#Good result: Submitted batch job 14261
[user@rg-login]$ sbatch --export=NONE ./run_task.sh ./task_b/build/omp_parallel
#Result: Submitted batch job 14262
#Kill the service
[user@rg-login]$ scancel 14261
```

### Output

You can check the generated output files or refer to `out/*` for the reference outputs. Note that in the manual execution, `out/manual-service.out` shows 16 messages (BF3's #cores), while `service-14261.out` shows only 8m as it is restricted by `--cpus-per-task` parameter in [run_service.sh](../run_service.sh).
