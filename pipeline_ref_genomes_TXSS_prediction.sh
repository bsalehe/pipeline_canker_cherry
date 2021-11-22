#!/bin/bash

#!/usr/bin/env bash
#SBATCH --partition=long
#SBATCH --mem=500G
#SBATCH --cpus-per-task=10
#export TF_CPP_MIN_LOG_LEVEL=2 

echo Start running pipeline...
export PATH=/scratch/software/ncbi-blast-2.11.0+/ncbi-blast-2.11.0+/bin:$PATH
#
#Assembly="/projects/pseudomonas_syringae/ref_genomes"
#

#####################################################################

# PROKKA ANNOTATION OF THE REFERENCE GENOME STRAINS

#####################################################################

for prokka_dir in /data/scratch/bsalehe/prokka_out/refgenomes/*; do
    #
    refname=$(basename $prokka_dir)
    PROKKA_OUT1=${prokka_dir}/PROKKA_*.faa
    #
    #PROKKA_OUT1=$(ls /data/scratch/bsalehe/prokka_out/${refname}/PROKKA*.faa)
    #
    #################################################################
    #
    # EFFECTORS PREDICTION FROM PROKKA ANNOTATION FILES
    #
    #################################################################
    #
    #################################################################
    #
    # TXSS: MACSYFINDER (PREDICTING ALL POTENTIAL EFFECTORS)
    #
    #################################################################
    #
    ./macsyf.sh $PROKKA_OUT1 $refname

    #################################################################
    #
    # T3SS: Deepredeff
    #
    #################################################################
    #
    #./deepredeff.sh $PROKKA_OUT1
    #mv deepredeff_output /data/scratch/bsalehe/canker_cherry_pipeline_output/${refname}_deepredeff_result.csv
    #
    #################################################################
    #
    # T3SS: BEAN2.0_T3SS_effector
    #
    #################################################################
    #
    #./bean.sh $PROKKA_OUT
    #
    #################################################################
    #
    # T4SS: CNN-T4SE
    #
    #################################################################
    #./cnne_t4se.sh $file $refname
    #
    #################################################################

done
