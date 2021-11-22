#!/bin/bash

R1="$1" #The argument for read1
R2="$2" #The argument for read2
#GENOME_SIZE=$3
GENOME_SIZE=6

FastpOutDir=$(basename $R1 001.fastq.gz)trimmed.fastq.gz
FastpOutDir1=$(basename $R2 001.fastq.gz)trimmed.fastq.gz

#gsname=$(basename $FastpOutDir _L001_R1_trimmed.fastq.gz)
gsname=$(basename $R1 _L001_R2_001.fastq.gz)

echo "Usage: genome_size.sh  <file1.fq.gz> <option file2.fq.gz> <genome_size int value>"

#./count_nucl.pl -i "$R1" -i "$R2" -g $GENOME_SIZE > ${gsname}_coverage.txt
./count_nucl.pl -i $FastpOutDir -i $FastpOutDir1 -g $GENOME_SIZE > ${gsname}_coverage.txt

#echo "Finished computing coverage $(basename $R1 _L001_R1_trimmed.fastq.gz)"
#echo "Finished computing coverage $(basename $FastpOutDir _L001_R1_trimmed.fastq.gz)"

# Copy coverage output into /data/scratch/bsalehe/canker_cherry_pipeline_output/assembly_pre-processing/
#
cp ${gsname}_coverage.txt /data/scratch/bsalehe/canker_cherry_pipeline_output/assembly_pre-processing/Tracy/1/new/
#
rm ${gsname}_coverage.txt

