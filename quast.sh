#!/bin/bash

#!/usr/bin/env bash

# Assess assembly quality using quast.

Assembly="$1"
OutDir="$2"
CurPath=$PWD
#WorkDir=$TMPDIR/${SLURM_JOB_USER}_${SLURM_JOBID}

export MYCONDAPATH=/home/bsalehe/miniconda3

#activate quast
source ${MYCONDAPATH}/bin/activate quast

echo "running quast "
quast.py --k-mer-stats --k-mer-size 101 -o $OutDir $Assembly
echo "quast finished running"


conda deactivate
