#!/bin/bash
#
BLASTDBINPUT="/data/scratch/bsalehe/Michelle_data/db_t3se/"
BLASTPOUT="/data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Michelle_data/T3/January/blast_confirmed_effectors"
BLASTQUERYDB="/data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Michelle_data/T3/January/deepredeff"
#BLASTQUERYDB="/data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Tracy/1/T3/deepredeff"
export PATH=/scratch/software/ncbi-blast-2.11.0+/ncbi-blast-2.11.0+/bin:$PATH

#makeblastdb -in ${BLASTDBINPUT}Supplemental_Dataset_S4.fasta -dbtype prot

#cd /data/scratch/bsalehe/blast_nrdb/
  for file in ${BLASTQUERYDB}/*.fasta; do
    #dname=$(dirname $file)
    name=$(basename $file .fasta)
    #blastp -query $file -db ${dirfastafiles}/PROKKA_*.faa -evalue 1e-6 -num_threads 4 -out /data/scratch/bsalehe/canker_cherry_pipeline_outpu>
    blastp -query $file -db ${BLASTDBINPUT}Supplemental_Dataset_S4.fasta -evalue 1e-6 -num_threads 8 -out ${BLASTPOUT}/${name}_blastp.txt
  done
#cd -

