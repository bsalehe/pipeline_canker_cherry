#!/bin/bash

#SBATCH -J pipeline
#SBATCH --partition=himem
#SBATCH --mem-per-cpu=8G
#SBATCH --cpus-per-task=16

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
OutDir=${Out}_quast_output
Correction=""
Cutoff="auto"

#########################################################

# PRE-PROCESSING COVERAGE ANALYSIS: Using FASTP and count_nucl.pl

###########################################################

for file1 in ../data/*_R1_*.fastq.gz; do
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
    ./quast.sh $Assembly_file $OutDir
done

####################
#
# ANNOTATION: Using Prokka
#
####################
#
./prokka_ps.sh $Assembly
#
PROKKA_OUT=$(ls /home/bsalehe/canker_cherry/scripts/ps_annotation/*.faa)
###################

#########################################################

# PHASE B: EFFECTORS PREDICTION FROM PROKKA ANNOTATION FILES

#########################################################

##################
#
#BEAN2.0_T3SS_effector
#
##################
./bean.sh $PROKKA_OUT
#
#
