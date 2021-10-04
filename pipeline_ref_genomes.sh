#!/bin/bash

#!/usr/bin/env bash
#SBATCH --partition=long
#SBATCH --mem=500G
#SBATCH --cpus-per-task=10
#export TF_CPP_MIN_LOG_LEVEL=2 

echo Start running pipeline...
export PATH=/scratch/software/ncbi-blast-2.11.0+/ncbi-blast-2.11.0+/bin:$PATH
#
Assembly="/projects/pseudomonas_syringae/ref_genomes"
#

#####################################################################

# PROKKA ANNOTATION OF THE REFERENCE GENOME STRAINS

#####################################################################

for Assembly_file in $(ls ${Assembly}/*.fasta); do
    refname=$(basename $Assembly_file .fasta)
    #
    ./prokka_ps.sh $Assembly_file
    #
    PROKKA_OUT1=$(ls /data/scratch/bsalehe/prokka_out/${refname}_out_prokka/PROKKA*.faa)
    #
    #################################################################
    #
    # EFFECTORS PREDICTION FROM PROKKA ANNOTATION FILES
    #
    #################################################################
    #
    #################################################################
    #
    # TXSS: MACSYFINDER
    #
    #################################################################
    #
    #./macsyf.sh $PROKKA_OUT1 $refname

    #################################################################
    #
    # T3SS: Deepredeff
    #
    #################################################################
    #
    #./deepredeff.sh $PROKKA_OUT $refname
    #mv deepredeff_output /data/scratch/bsalehe/canker_cherry_pipeline_output/${refname}_deepredeff_result.csv
    #
    #################################################################
    #
    # T3SS: BEAN2.0_T3SS_effector
    #
    #################################################################
    #
    ./bean.sh $PROKKA_OUT
    #
    #################################################################
    #
    # T4SS: CNN-T4SE
    #
    #################################################################
    ./cnne_t4se.sh $file $dsname
    #
    #################################################################
    #
    #TXSS (All effectors together) : MACSYFINDER
    #
    #################################################################
    ./macsyf.sh $file $dsname
    #
    #################################################################
done
