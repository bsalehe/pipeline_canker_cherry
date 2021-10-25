#!/bin/bash

#!/usr/bin/env bash
#SBATCH --partition=himem
#SBATCH --mem=500G
#SBATCH --cpus-per-task=4
#export TF_CPP_MIN_LOG_LEVEL=2

echo Start running pipeline...
export PATH=/scratch/software/ncbi-blast-2.11.0+/ncbi-blast-2.11.0+/bin:$PATH
#
#################################################################

# PHASE 3: GENOMIC ISLANDS PREDICTION FROM PROKKA ANNOTATION FILES

#################################################################

#cd /data/scratch/bsalehe/prokka_out/

for prokka_dir in /data/scratch/bsalehe/prokka_out/refgenomes/*; do
    out_dir=$(basename $prokka_dir);
    PROKKA_OUT=${prokka_dir}/PROKKA_*.gbk
    #file_name=$(basename $PROKKA_OUT .faa)
    #sample_name=$(dirname $PROKKA_OUT)

#################################################################
#
# GENOMI ISLANDS: IslandPath-DIMOB
#
#################################################################
#
    ./phage_analysis.sh $PROKKA_OUT $out_dir
#
##################################################################

done
