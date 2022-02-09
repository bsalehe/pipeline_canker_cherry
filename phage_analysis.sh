#!/bin/bash

#!/usr/bin/env bash


prokka_out="$1"
OutDir="$2"
#PHISPY_OUTDIR="/data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Tracy/1/phage/phispy/refgenomes/January"
PHISPY_OUTDIR="/data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Michelle_data/phage/January/phispy"

#CurPath=$PWD

export MYCONDAPATH=/home/bsalehe/miniconda3

#activate phispy
source ${MYCONDAPATH}/bin/activate phispy

echo "running phispy "
PhiSpy.py -o ${PHISPY_OUTDIR}/${OutDir} $prokka_out --randomforest_trees=1500 --phage_genes=0 --keep_dropped_predictions
echo "phispy finished running"


conda deactivate
