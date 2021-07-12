#!/bin/bash

#FASTADIR="$1"
FASTAFILE="$1"
#
#
Rscript deepredeff.r $FASTAFILE --slave > /data/scratch/bsalehe/canker_cherry_pipeline_output/deepredeff_result.txt
