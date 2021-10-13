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

# GENOMIC ISLANDS PREDICTION FOR THE REFERENCE GENOME STRAINS

#####################################################################

for prokka_dir in /data/scratch/bsalehe/prokka_out/refgenomes/*; do
    #
    refname=$(basename $prokka_dir)
    PROKKA_OUT1=${prokka_dir}/PROKKA_*.gbk
    #
    #PROKKA_OUT1=$(ls /data/scratch/bsalehe/prokka_out/${refname}/PROKKA*.faa)
    #
    #################################################################
    #
    # GENOMIC ISLANDS PREDICTION FROM PROKKA ANNOTATION FILES
    #
    #################################################################
    #
    #################################################################
    #
    # IslandPath
    #
    #################################################################
    #
    ./genomicislands.sh $PROKKA_OUT1 $refname

    #################################################################
    #


done
