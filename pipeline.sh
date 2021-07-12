#!/bin/bash

#!/usr/bin/env bash
#SBATCH --partition=long
#SBATCH --mem=500G
#SBATCH --cpus-per-task=16

echo Start running pipeline...
export PATH=/scratch/software/ncbi-blast-2.11.0+/ncbi-blast-2.11.0+/bin:$PATH

#########################################################

# PHASE A: PRE-PROCESSING, ASSEMBLY & ANNOTATION OF GENOMIC READS

#########################################################

R1="$1"
R2="$2"
GENOME_SIZE=$3
WORKDIR=$PWD

Out=$(date +%Y%m%d%s)
mkdir ${Out}_spades_output
Assembly=${Out}_spades_output
QuastOutDir=${Out}_quast_output
Correction=""
Cutoff="auto"
READSDATADIR="/home/bsalehe/canker_cherry/data/"
EFFECTIVE_T3_OUT="/data/scratch/bsalehe/canker_cherry_pipeline_output/"

#########################################################

# PRE-PROCESSING COVERAGE ANALYSIS: Using FASTP and count_nucl.pl

###########################################################

for file1 in ${READSDATADIR}*_R1_*.fastq.gz; do
	file2=${file1/R1_/R2_}
	#paired=${i1/R1_/paired}
	./fastp.sh "$file1" "$file2" "$(basename $file1 .fastq.gz)trimmed.fastq.gz" "$(basename $file2 .fastq.gz)trimmed.fastq.gz"
        ./genome_cov.sh "$(basename $file1 .fastq.gz)trimmed.fastq.gz" "$(basename $file2 .fastq.gz)trimmed.fastq.gz" 6
done

###################

# ASSEMBLY: Using SPAdes

####################

for file1 in *_R1_*trimmed.fastq.gz; do
	file2=${file1/R1_/R2_}
	#echo  "Enter correction parameter for the SPAdes...<correct/only-assembler>"
	#read  correction
	#if [ $correction != "correct" ] || [ $correction != "only-assembler" ]; then
	#	"Enter correctly the correction parameter for the SPAdes...<correct/only-assembler>"
	#	read correction
	#else
	./SPAdes.sh "$file1" "$file2" "$Assembly" "only-assembler"
	#fi
done

############################

# ASSEMBLY ANALYSIS: Using Quast

############################

#ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Assembly_qc
for Assembly_file in $(ls ${Assembly}/*.fasta); do
    #OutDir=$(dirname $Assembly_file)
    ./quast.sh $Assembly_file $QuastOutDir
done

####################
#
# ANNOTATION: Using Prokka
#
####################
#
./prokka_ps.sh $Assembly
#
PROKKA_OUT=$(ls /data/scratch/bsalehe/prokka_out/ps_annotation/*.faa)
###################

#########################################################

# PHASE B: EFFECTORS PREDICTION FROM PROKKA ANNOTATION FILES

#########################################################

##################
#
#T3SS: BEAN2.0_T3SS_effector
#
##################
./bean.sh $PROKKA_OUT
#
#####################

####################
# T3SS: EffectiveT3
###################
#
./effective_t3.sh $PROKKA_OUT $EFECTIVE_T3_OUT
#
###########################################

###########################################
#
# T3SS: Deepredeff
#
##########################################
#
./deepredeff.sh $PROKKA_OUT
#
#############################################
#
#
# Copy fastp, assembly, quast, genome_cov output files into /scratch/data/bsalehe/canker_cherry_pipeline_output
if [ $? -ge 0 ]; then
    cp -r $Assembly /data/scratch/bsalehe/canker_cherry_pipeline_output
    cp -r $QuastOutDir /data/scratch/bsalehe/canker_cherry_pipeline_output
    rm -rf $Assembly $QuastOutDir
    rm *.gz
    rm -rf OUT_work ##BEAN workdir folder containing intermediate files
    mv slurm-*.out /data/scratch/bsalehe/canker_cherry_pipeline_output/slurm.out
fi
