#!/bin/bash

#gb_file="$1"

#########################################################

for dir_with_gb_file in /data/scratch/bsalehe/prokka_out/Tracy/*; do
     out_dir=$(basename $dir_with_gb_file)
     gb_file=${dir_with_gb_file}/${out_dir}.gbk
     python3 ./modify_locus_genbank.py $gb_file

done

#########################################################
