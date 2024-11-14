#!/bin/bash
#This script just shows how to allocate two nodes in a heterogeneous fashion to get a paired host and BF3 

#Read in the node number from command line
NODE=$1

check_cmd_params()
{

if [ -z $NODE ];
then 
	printf "Pass a node number from 1 to 4\n"
	printf "Ex: ./request_bf3_heterogenous_slurm_job.sh 3"
	exit
fi
}

check_cmd_params

#If the user specified a parameter, then request two nodes for 10 minutes in an exclusive fashion
# -w specifies node names, -p specifies the queue, and --exclusive specifies that no other jobs will share
#these nodes
salloc --reservation sc24_tutorial --nodes=2 -w dash$NODE,dash$NODE-bf3-1 -p rg-nextgen-hpc --time=0:10:00 --exclusive
