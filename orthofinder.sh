#!/bin/bash


INPUTDIR="$1"
#OUTDIR="$2"
WORKDIR="/home/bsalehe/canker_cherry/software/OrthoFinder_source/"

#mkdir /data/scratch/bsalehe/canker_cherry_pipeline_output/orthology/OrthoFinder/$OUTDIR

cd $WORKDIR

python3 orthofinder.py -f $INPUTDIR -o /data/scratch/bsalehe/canker_cherry_pipeline_output/orthology/OrthoFinder/Tracy/

cd -



