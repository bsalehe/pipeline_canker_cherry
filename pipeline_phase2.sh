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

# PHASE B: EFFECTORS PREDICTION FROM PROKKA ANNOTATION FILES

#################################################################

#cd /data/scratch/bsalehe/prokka_out/

for prokka_dir in /data/scratch/bsalehe/prokka_out/*; do  
    sample_name=$(basename $prokka_dir);
    PROKKA_OUT=${prokka_dir}/PROKKA_*.faa
    #file_name=$(basename $PROKKA_OUT .faa)
    #sample_name=$(dirname $PROKKA_OUT)

#################################################################
#
# TXSS: MACSYFINDER
#
#################################################################
#
    #./macsyf.sh $PROKKA_OUT $sample_name
#
#################################################################
#
# T3SS: Deepredeff
#
#################################################################
#
#    ./deepredeff.sh $PROKKA_OUT 
#    mv deepredeff_output /data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Tracy/1/T3/deepredeff/${sample_name}_deepredeff_result.csv
#
#################################################################

#################################################################
#
# T3SS: BEAN2.0
#
#################################################################
#
    ./bean.sh $PROKKA_OUT $sample_name
#
#################################################################

#################################################################
#
# T4SS: CNNT4SE
#
#################################################################
#
    #./cnn_t4se.sh $PROKKA_OUT $sample_name
#
#################################################################

done
