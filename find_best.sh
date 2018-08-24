#!/bin/bash
set -e

[ $PBS_JOBID ] && JOBID=$PBS_JOBID
[ $SLURM_JOBID ] && JOBID=$SLURM_JOBID

JOBID=$(echo $JOBID | tr '[\[\]]' '_') #singularity doesn't like "[2]"

mkdir /tmp/$JOBID
export SINGULARITY_LOCALCACHEDIR=/tmp/$JOBID
MAXMEM=32000000 singularity exec docker://brainlife/mcr:neurodebian1604-r2017a ./compiled/find_best

#should be removed by the epilogue? (what about for slurm?)
#echo "removing tmp directory .. which should be empty by now"
#rmdir -rf /tmp/$JOBID
