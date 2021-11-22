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

# PHASE 4: ORTHOLOGY ANALYSIS

#################################################################

#cd /data/scratch/bsalehe/prokka_out/

for prokka_dir in /data/scratch/bsalehe/orthofinder_prep_files/refgenomes/; do
    #out_dir=$(basename $prokka_dir);
    PROKKA_OUT=${prokka_dir}
    #file_name=$(basename $PROKKA_OUT .faa)
    #sample_name=$(dirname $PROKKA_OUT)

#################################################################
#
# ORTHOLOGUE FINDING: ORTHOFINDER 2.5.4
#
#################################################################
#
    ./orthofinder.sh $PROKKA_OUT #$out_dir
#
##################################################################

done
