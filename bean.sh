#!/bin/bash
#
prokka_out_fasta="$1"
sname="$2"
BEAN_PATH="/scratch/software/BEAN2.0/BEAN-2.0/"
PIPELINE_OUT="/data/scratch/bsalehe/canker_cherry_pipeline_output/"
#
#
# Run BEAN2.0
#
cd /scratch/software/BEAN2.0/BEAN-2.0/
#perl ${BEAN_PATH}classify.pl $prokka_out_fasta
perl classify.pl $prokka_out_fasta
#
# Copy prediction result file into new file
mv prediction_result.txt /data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Tracy/1/T3/bean2.0/${sname}_BEAN2_prediction_result.txt
#
# Remove previous BEAN working output directory
#rm -rf ${BEAN_PATH}OUT_work
#
rm -rf OUT_work
#
# remove previous prediction result file 
#rm ${BEAN_PATH}prediction_result.txt
#rm prediction_result.txt
#
# return to the main pipeline  working directory
cd -
