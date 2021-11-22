#!/bin/bash


INPUTDIR="$1"
#OUTDIR="$2"
WORKDIR="/home/bsalehe/canker_cherry/software/OrthoFinder_source/"

#mkdir /data/scratch/bsalehe/canker_cherry_pipeline_output/orthology/OrthoFinder/$OUTDIR

cd $WORKDIR

# The output directory should not exist before. Just give the name and Orthofinder will create it for you.
python3 orthofinder.py -f $INPUTDIR -o /data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Tracy/1/orthology/OrthoFinder/results_for_combined_3_refgenomes_and_8_samples

cd -



