#!/bin/bash

#gb_file="$1"

#########################################################

for dir_with_gb_file in /data/scratch/bsalehe/prokka_out/*; do
     gb_file=${dir_with_gb_file}/PROKKA_*.gbk
     python3 ./modify_locus_genbank.py $gb_file

done

#########################################################
