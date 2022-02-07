#!/bin/bash

#!/usr/bin/env bash


#SBATCH --partition=long
#SBATCH --mem=500G
#SBATCH --cpus-per-task=16

##################################################################################################

# PHASE 1 PIPELINE OF CANKER CHERRY PROJECT: PRE-PROCESSING, ASSEMBLY & ANNOTATION OF GENOMIC READS

###################################################################################################

echo Start running pipeline...
export PATH=/scratch/software/ncbi-blast-2.11.0+/ncbi-blast-2.11.0+/bin:$PATH

R1="$1"
R2="$2"
GENOME_SIZE=$3
#WORKDIR=$PWD
#Correction=""
#Cutoff="off" ## --cov-cutoff

READSDATADIR="/data/scratch/bsalehe/Michelle_data/ps_genomic_strains/canker_genomes/epiphyte_genomes/"

QUASTOUTDIR="/data/scratch/bsalehe/canker_cherry_pipeline_output/assembly_pre-processing/Tracy/1/"

PROKKAOUTDIR="/data/scratch/bsalehe/Michelle_data/ps_genomic_strains/canker_genomes/epiphyte_genomes/prokka_out/"

DEEPREDEFFOUTDIR="/data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Michelle_data/T3/January/deeprdeff/known_genomes"

ORTHODIR="/data/scratch/bsalehe/orthofinder_prep_files/Michelle_epiphytes/"

################################################################
#
# PRE-PROCESSING COVERAGE ANALYSIS: Using FASTP and count_nucl.pl
#
################################################################

#for file1 in ${READSDATADIR}*_R1_001.fastq.gz; do
#        file2=${file1/R1_/R2_}
#        ./fastp.sh "$file1" "$file2" "$(basename $file1 001.fastq.gz)trimmed.fastq.gz" "$(basename $file2 001.fastq.gz)trimmed.fastq.gz"
#        ./genome_cov.sh "$(basename $file1 001.fastq.gz)trimmed.fastq.gz" "$(basename $file2 001.fastq.gz)trimmed.fastq.gz" 6
#done

################################################################
#
# ASSEMBLY: Using SPAdes
#
################################################################

#for file1 in *_R1_trimmed.fastq.gz; do
#        file2=${file1/R1_/R2_}
#        sname=$(basename $file1 _L001_R1_trimmed.fastq.gz)
#        ./SPAdes.sh "$file1" "$file2" "$sname" "off"
#
################################################################
#
# ASSEMBLY ANALYSIS: Using Quast
#
################################################################
#        ./quast.sh ${sname}/scaffolds.fasta ${sname}_quast_out
#        mv ${sname}_quast_out $QUASTOUTDIR
#
################################################################
#
# ANNOTATION: Using Prokka
#
###############################################################
for file1 in ${READSDATADIR}*.fa; do
        ./prokka_ps.sh $file1
#        ./prokka_ps.sh ${sname}/contigs.fasta
        #rm -r ${sname}
#done

#rm *.gz

#
#
#################################################################

# PHASE 2A: EFFECTORS PREDICTION FROM PROKKA ANNOTATION FILES

#################################################################
#
# Iterate over directories containing prokka output files
for prokka_dir in ${PROKKAOUTDIR}*; do  
    sample_name=$(basename $prokka_dir);
    PROKKA_OUT=${prokka_dir}/${sample_name}.faa
#    PROKKA_OUT_GBK=${prokka_dir}/${sample_name}.gbk
    #file_name=$(basename $PROKKA_OUT .faa)
    #sample_name=$(dirname $PROKKA_OUT)
#
##################################################################
#
# T3SS: EffectiveT3
#
#################################################################
#
    ./effective_t3.sh $PROKKA_OUT $sample_name
#
#################################################################

#################################################################
#
# TXSS: MACSYFINDER
#
#################################################################
#
    ./macsyf.sh $PROKKA_OUT $sample_name
#
#################################################################
#
# T3SS: Deepredeff
#
#################################################################
#
    ./deepredeff.sh $PROKKA_OUT 
    mv deepredeff_output ${DEEPREDEFFOUTDIR}/${sample_name}_deepredeff_result.csv
#
#################################################################

#################################################################
#
# T3SS: BEAN2.0
#
#################################################################
#
#    ./bean.sh $PROKKA_OUT $sample_name
#
##################################################################
#
#################################################################

# PHASE 2B: GENOMIC ISLANDS PREDICTION FROM PROKKA ANNOTATION FILES

#################################################################
#
#################################################################
#
#    ./genomicislands.sh $PROKKA_OUT_GBK $sample_name
#
#python3 /home/bsalehe/canker_cherry/scripts/pipeline_canker_cherry/genomicislands.py $PROKKA_OUT_GBK
#
##################################################################
#
done

#################################################################

# PHASE 2C: PHAGE PREDICTION FROM PROKKA ANNOTATION FILES

#################################################################
#
################################################################
#    ./phage_analysis.sh $PROKKA_OUT $sample_name using phaster 
# Iterate over fasta files containing contigs
for file1 in ${READSDATADIR}*.fa; do
#
       python3 phaster.py --fasta $file1

done

#
#################################################################

# PHASE 2D: ORTHOLOGS ANALYSIS FROM PROKKA ANNOTATION FILES

#################################################################
#
#################################################################
#
#          ORTHOFINDER 2.5.4
#
    ./orthofinder.sh $ORTHODIR
#
##################################################################
