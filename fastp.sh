#!/bin/bash

R1="$1"
R2="$2"
OutDir="$3"
OutDir1="$4"
mkdir fastp_output

#tell bash where to find conda
export MYCONDAPATH=/home/bsalehe/miniconda3

#activate  fastp
source ${MYCONDAPATH}/bin/activate fastp

#run commands using your tools here
die(){
	local m="$1"
	local m1="$2"
	local err=$3
	echo "$m or $m1"
	exit $err
}

[ $# -eq 0 ] && die "Usage: fastp.sh <filename_R1.gz>" "Usage: fastp.sh <filename_R1.gz> <filename_R2.gz>" 1


echo "Start running fastp..."

if [ $# -eq 4 ]; then
	fastp -i "$R1" -I "$R2" -o $OutDir -O $OutDir1
#check if the file is one and single-end
elif [ $# -eq 2 ]; then
	fastp -i $R1 -o $OutDir
else echo "Error: Invalid number of argument. fastp didn't run" 1
fi
cp *.html fastp_output
cp *.json fastp_output
rm *.html *.json
cp -r fastp_output /data/scratch/bsalehe/canker_cherry_pipeline_output
rm -rf fastp_output
#
#deactivate fastp
conda deactivate
