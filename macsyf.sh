#!/bin/bash

R1="$1"
R2="$2"
#Outfile1="$3"
#Outfile2="$4"

#tell bash where to find conda
export MYCONDAPATH=/home/bsalehe/miniconda3

#activate  macsyf
source ${MYCONDAPATH}/bin/activate macsyf

macsyfinder -m TXSS all --sequence-db $R1 --db-type unordered --models-dir /home/bsalehe/.macsyfinder/data -o /data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Tracy/1/all_TiSS/macsyfinder/TXSS/new_run/${R2} --min-genes-required T2SS 100  --min-genes-required T1SS 100 --min-genes-required T3SS 100 --min-genes-required T4SS 100 --min-genes-required T5SS 100 --min-genes-required T6SS 100

conda deactivate

