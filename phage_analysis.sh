#!/bin/bash

#!/usr/bin/env bash


prokka_out="$1"
OutDir="$2"
#CurPath=$PWD

export MYCONDAPATH=/home/bsalehe/miniconda3

#activate phispy
source ${MYCONDAPATH}/bin/activate phispy

echo "running phispy "
PhiSpy.py -o /data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Tracy/1/phages/phispy/${OutDir} $prokka_out
echo "phispy finished running"


conda deactivate
