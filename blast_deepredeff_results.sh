#!/bin/bash
#!/usr/bin/env bash

#SBATCH --partition=himem
#SBATCH --mem=500G
#SBATCH --cpus-per-task=4

export PATH=/scratch/software/ncbi-blast-2.11.0+/ncbi-blast-2.11.0+/bin:$PATH

cd /data/scratch/bsalehe/blast_nrdb/
  for file in /data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Tracy/1/T3/deepredeff/*.fasta; do
    dname=$(dirname $file)
    name=$(basename $file _result_filtered_sequence.fasta)
    #blastp -query $file -db ${dirfastafiles}/PROKKA_*.faa -evalue 1e-6 -num_threads 4 -out /data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Tracy/1/T3/deepredeff/${name}_blastp.txt
    blastp -query $file -db nr -evalue 1e-6 -num_threads 8 -out ${dname}/${name}_blastp.txt
  done
cd -

