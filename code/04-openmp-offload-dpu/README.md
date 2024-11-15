# Code Sample 4 - OpenMP DPU Offloading Support

This code sample demonstrates how to compile ODOS-enabled applications with the following examples:

* [Hello World](./task_a) - executable: hello
* [OpenMP Parallel feature](./task_b) - executable: omp_parallel
* [Shared libraries](./task_c) - executable: shared
* [Asynchonous TCP](./task_d) - executable: net_accel

Please, look into example folders for further details about running them. However, the general instructions are presented below.

## Manual process

### Request resources

1) First you need to request an interactive node to compile the example code and run it. We highly recommend that you open two terminals or use a screen/tmux session to allow logging into the host and BF3 nodes.

```
[user@rg-login]$ cd 04-openmp-offload-dpu
#Note you should select a number between 1 and 4 for node number
$ ./request_bf3_heterogenous_slurm_job.sh 3
#The rest of the instructions assume that the node `3` was requested.
```

### Compile a sample

Assume that `task` is the `code/04-openmp-offload-dpu/task_*` folder in which one you want to work.

Once you have a session and two terminal sessions, you need to load the environment host system.

Terminal 1 (Host):

```
[user@rg-login]$ ssh dash3
[user@dash3]$ cd <task>
#Load ODOS and cmake
[user@dash3]$ module use /projects/tools/x86_64/ubuntu-22.04/modulefiles/
[user@dash3]$ module load odos-dpu cmake
[user@dash3]$ rm -rf build && mkdir -p build && cd build && cmake .. && make && cd ..
```

Terminal 2 (BF3):

```
[user@rg-login]$ ssh dash3-bf3-1
[user@dash3-bf3-1]$ cd <task>
[user@dash3-bf3-1]$ module use /projects/tools/x86_64/ubuntu-22.04/modulefiles/
[user@dash3-bf3-1]$ module load odos-dpu
```

### Running the sample

To run the sample code, you need to run the DOCA OpenMP service in BF system and the compiled code on host side.

Terminal 2 (BF3):

```
[user@dash3-bf3-1]$ $ODOS/service/doca-omp-service
```

Terminal 1 (Host):

```
[user@dash3]$ ./build/<executable>
```

### Wrap-up

Kill the service on the BF3 system and you can pass to the next task folder and start again from [compilation](### Compile a sample).

## Automated compilation and running using SLURM

There are two scripts provided for automated compilation of all tasks and the execution of a task.

### Compilation

```
[user@rg-login]$ cd 04-openmp-offload-dpu
#Note you should select a number between 1 and 4 for node number
$ ./request_bf3_heterogenous_slurm_job.sh 3
#The rest of the following instructions assume that the node `3` was requested.
[user@dash3]$ source /etc/profile
[user@dash3]$ module use /projects/tools/x86_64/ubuntu-22.04/modulefiles/
[user@dash3]$ module load odos-dpu cmake
[user@dash3]$ ./clean.sh
[user@dash3]$ ./compile.sh
[user@dash3]$ exit
```

### Execution

The execution script request the nodes itself.

```
# This env variable declaration is needed for task_c
[user@rg-login]$ export LIB_=./task_c/build
#Note you should select a number between 1 and 4 for node number
[user@rg-login]$ ./run_service.sh 3
#Good result: Submitted batch job 14014 (it will be killed in 10 minutes)
#Please change: ./task_<*/build/executable>; e.g ./task_a/build/hello
[user@rg-login]$ sbatch --export=LIB_ ./run_task.sh ./task_<*/build/executable>
#Result: Submitted batch job 14170
[user@rg-login]$ cat task-14170.out
#Kill the service
[user@rg-login]$ scancel 14014
```
