#!/bin/bash

#!/usr/bin/env bash
#SBATCH --partition=long
#SBATCH --mem=500G
#SBATCH --cpus-per-task=16

##################################################################################################

# PHASE 1 PIPELINE OF CANKER CHERRY PROJECT: PRE-PROCESSING, ASSEMBLY & ANNOTATION OF GENOMIC READS

###################################################################################################

echo Start running pipeline...
#export PATH=/scratch/software/ncbi-blast-2.11.0+/ncbi-blast-2.11.0+/bin:$PATH

R1="$1"
R2="$2"
GENOME_SIZE=$3
#WORKDIR=$PWD
#Correction=""
#Cutoff="off" ## --cov-cutoff
READSDATADIR="/home/bsalehe/canker_cherry/data/yang/"

###########################################################
#
# PRE-PROCESSING COVERAGE ANALYSIS: Using FASTP and count_nucl.pl
#
###########################################################

for file1 in ${READSDATADIR}*_R1_001.fastq.gz; do
        file2=${file1/R1_/R2_}
        ./fastp.sh "$file1" "$file2" "$(basename $file1 001.fastq.gz)trimmed.fastq.gz" "$(basename $file2 001.fastq.gz)trimmed.fastq.gz"
        ./genome_cov.sh "$(basename $file1 001.fastq.gz)trimmed.fastq.gz" "$(basename $file2 001.fastq.gz)trimmed.fastq.gz" 6
done

##########################################################
#
# ASSEMBLY: Using SPAdes
#
##########################################################

for file1 in *_R1_trimmed.fastq.gz; do
        file2=${file1/R1_/R2_}
        sname=$(basename $file1 _L001_R1_trimmed.fastq.gz)
        ./SPAdes.sh "$file1" "$file2" "$sname" "off"

##############################################################
#
# ASSEMBLY ANALYSIS: Using Quast
#
##############################################################
        ./quast.sh ${sname}/scaffolds.fasta ${sname}_quast_out
        mv ${sname}_quast_out /data/scratch/bsalehe/canker_cherry_pipeline_output

##############################################################
#
# ANNOTATION: Using Prokka
#
###############################################################

        #./prokka_ps.sh $Assembly_file
        ./prokka_ps.sh ${sname}/scaffolds.fasta
        #rm -r ${sname}
done

rm *.gz

