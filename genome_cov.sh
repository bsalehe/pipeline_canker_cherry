#!/bin/bash

R1="$1"
R2="$2"
GENOME_SIZE=$3

echo "Usage: genome_size.sh  <file1.fq.gz> <option file2.fq.gz> <genome_size int value>"

./count_nucl.pl -i "$R1" -i "$R2" -g $GENOME_SIZE > coverage.txt

echo "Finished computing coverage $(basename $R1 .fastq.gz)"

# Copy coverage output into /data/scratch/bsalehe/
#
cp coverage.txt /data/scratch/bsalehe/canker_cherry_pipeline_output/
#
rm coverage.txt

