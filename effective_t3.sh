#!/bin/bash

FASTA_FILE="$1"
EFECTIVE_T3_OUT_FILE="$2"
EFECTIVE_T3_BINARY="/scratch/software/EffectiveT3/"
#EFECTIVE_T3_OUTDIR="/data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Tracy/1/T3/January/effectiveT3/refgenomes"
EFECTIVE_T3_OUTDIR="/data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Michelle_data/T3/January/effectiveT3/known_genomes/"
#
java -jar ${EFECTIVE_T3_BINARY}TTSS_GUI-1.0.1.jar -f $FASTA_FILE -m TTSS_STD-2.0.2.jar -t cutoff=0.995 -o ${EFECTIVE_T3_OUTDIR}/$EFECTIVE_T3_OUT_FILE -q
