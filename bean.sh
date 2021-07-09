#!/bin/bash
#
prokka_out_fasta="$1"
BEAN_PATH="/home/bsalehe/canker_cherry/software/BEAN-2.0/"
PIPELINE_OUT="/data/scratch/bsalehe/canker_cherry_pipeline_output/"
#
#
# Run BEAN2.0
#
perl ${BEAN_PATH}classify.pl $prokka_out_fasta
#
# Copy prediction result file into new file
cp ${BEAN_PATH}prediction_result.txt ${BEAN_PATH}pipeline_bean2.0_prediction_result_$(date +%Y%m%d%s).txt
#
# Copy prediction result new file into final output diectory
cp ${BEAN_PATH}pipeline_bean2.0_prediction_result_$(date +%Y%m%d%s).txt $PIPELINE_OUT
#
# Remove previous BEAN working output directory
#rm -rf ${BEAN_PATH}OUT_work
#
# remove previous prediction result file 
rm ${BEAN_PATH}prediction_result.txt
#
# remove current prediction result file from current working directory $BEAN_PATH
rm ${BEAN_PATH}pipeline_bean2.0_prediction_result_$(date +%Y%m%d%s).txt
