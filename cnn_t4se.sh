#!/bin/bash

#PROKKA_FILE="$1"
#SNAME="$2"
#CNN_T4DIR="/scratch/software/T4/CNN_T4SE/"

for file in /data/scratch/bsalehe/prokka_out/HT8_S6_out_prokka/PROKKA_07302021_*.faa; do
part1=$(dirname $file) 
part2=$(basename $part1) 
dsname=$(echo $part2 | awk -F_o '{ print $1 }') 

#if [ $(grep "^>" $file | wc -l) -eq 1 ]; then  ## Check if the fasta file has more than one sequence as SCRATCH produce libgcc error when the number of sequence is  one.
# /scratch/software/T4/CNN_T4SE/SCRATCH-1D_1.2/bin/run_SCRATCH-1D_predictors.sh $file ${dsname}_scratch.out 4
# mv ${dsname}_scratch.out.ss /scratch/software/T4/CNN_T4SE/CNNT4SE/${dsname}_scratch.out.ss
# mv ${dsname}_scratch.out.acc /scratch/software/T4/CNN_T4SE/CNNT4SE/${dsname}_scratch.out.acc
# rm ${dsname}*.acc20 ${dsname}*.ss8
# cd /scratch/software/T4/CNN_T4SE/CNNT4SE

# ./predict PSSSA ${dsname}_scratch.out.ss ${dsname}_scratch.out.acc

# mv ResultPSSSA.csv /data/scratch/bsalehe/canker_cherry_pipeline_output/${dsname}_prediction_results_CNN-T4SE.csv

# cd -
#fi

#done
#
if [ $(grep "^>" $file | wc -l) -gt 1 ]; then ## if the number of sequence is more than one break each sequence in the multifasta file into individual separate file each with single sequence
 awk -F " " '/^>/ {close(F); ID=$1; gsub("^>", "", ID); F=ID".fasta"} {print >> F}' $file;
 for fasta_file in *.fasta; do ## loop over each split individual single fasta sequence file to run SCRATCH
    fname=$(basename $fasta_file .fasta)
    /scratch/software/T4/CNN_T4SE/SCRATCH-1D_1.2/bin/run_SCRATCH-1D_predictors.sh $fasta_file ${fname}.out 4
    mv ${fname}.out.ss /scratch/software/T4/CNN_T4SE/CNNT4SE/${fname}.out.ss
    mv ${fname}.out.acc /scratch/software/T4/CNN_T4SE/CNNT4SE/${fname}.out.acc
    cd /scratch/software/T4/CNN_T4SE/CNNT4SE
    ./predict PSSSA ${fname}.out.ss ${fname}.out.acc
    awk 'FNR==2{print $0}' ResultPSSSA.csv >> /data/scratch/bsalehe/canker_cherry_pipeline_output/${dsname}_prediction_results_CNN-T4SE_30082021.csv
    #mv ResultPSSSA.csv /data/scratch/bsalehe/canker_cherry_pipeline_output/${fname}_prediction_results_CNN-T4SE.csv
    #cat /data/scratch/bsalehe/canker_cherry_pipeline_output/${fname}_prediction_results_CNN-T4SE.csv >> /data/scratch/bsalehe/canker_cherry_pipeline_output/${dsname}_prediction_results_CNN-T4SE.csv
    rm ResultPSSSA.csv 
    #cd -
    rm ${fname}.out.ss8 ${fname}.out.acc20
    cd -
 done
 rm *.fasta
fi
done
#/scratch/software/T4/CNN_T4SE/SCRATCH-1D_1.2/bin/run_SCRATCH-1D_predictors.sh $PROKKA_FILE /scratch/software/T4/CNN_T4SE/CNNT4SE/${SNAME}_scratch.out 4

#perl /scratch/software/T4/CNN_T4SE/POSSUM_Standalone_Toolkit/possum_standalone.pl -i $PROKKA_FILE -o /scratch/software/T4/CNN_T4SE/${SNAME}.csv

#cd /scratch/software/T4/CNN_T4SE/CNNT4SE

#./predict PSSSA ${SNAME}_scratch.out.ss ${SNAME}_scratch.out.cc

#mv ResultPSSSA.csv /data/scratch/bsalehe/canker_cherry_pipeline_output/${SNAME}_prediction_results_CNN-T4SE.csv

#cd -
