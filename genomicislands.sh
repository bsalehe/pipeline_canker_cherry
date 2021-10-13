#!/bin/bash
#
#
GI_WORKIDIR="/scratch/software/genomicislandviewer/islandpath"
OUTDIR="/data/scratch/bsalehe/canker_cherry_pipeline_output/gislandviewer"
gb_file="$1"
s_name="$2"

${GI_WORKIDIR}/Dimob.pl $gb_file ${OUTDIR}/${s_name}_genomic_islands.txt
