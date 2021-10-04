#!/bin/bash

R1="$1"
R2="$2"
#Outfile1="$3"
#Outfile2="$4"
#mkdir fastp_output

#inputfile=/data/scratch/bsalehe/prokka_out/HT1_S1_out_prokka/PROKKA_07302021.faa

#tell bash where to find conda
export MYCONDAPATH=/home/bsalehe/miniconda3

#activate  fastp
source ${MYCONDAPATH}/bin/activate macsyf

macsyfinder -m TXSS all --sequence-db $R1 --db-type ordered_replicon --models-dir /home/bsalehe/.macsyfinder/data -o /data/scratch/bsalehe/canker_cherry_pipeline_output/TXSS/${R2}

conda deactivate

