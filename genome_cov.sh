#!/bin/bash

R1="$1"
R2="$2"
GENOME_SIZE=$3

gsname=$(basename $R1 _L001_R1_trimmed.fastq.gz)
#gsname=$(basename $R1 _L001_R1_trimmed.fastq.gz)

echo "Usage: genome_size.sh  <file1.fq.gz> <option file2.fq.gz> <genome_size int value>"

./count_nucl.pl -i "$R1" -i "$R2" -g $GENOME_SIZE > ${gsname}_coverage.txt

echo "Finished computing coverage $(basename $R1 _L001_R1_trimmed.fastq.gz)"

# Copy coverage output into /data/scratch/bsalehe/
#
cp ${gsname}_coverage.txt /data/scratch/bsalehe/canker_cherry_pipeline_output/assembly_pre-processing/Tracy/1/
#
rm ${gsname}_coverage.txt

