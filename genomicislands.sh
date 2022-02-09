#!/bin/bash
#
#
GI_WORKDIR="/home/bsalehe/canker_cherry/scripts/pipeline_canker_cherry"
PROKKAOUTDIR="/data/scratch/bsalehe/Michelle_data/ps_genomic_strains/canker_genomes/epiphyte_genomes/prokka_out/"

for prokka_dir in ${PROKKAOUTDIR}*; do
    sample_name=$(basename $prokka_dir)
    PROKKA_OUT_GBK=${prokka_dir}/${sample_name}.gbk
    python3 ${GI_WORKDIR}/genomicislands.py $PROKKA_OUT_GBK
done
