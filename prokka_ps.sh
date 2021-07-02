#!/bin/bash

# Reference sequence path containing gbk files
REFSEQPATH="/home/bsalehe/canker_cherry/scripts/refseq1/"
REFSEQJOINEDGBK="/home/bsalehe/canker_cherry/scripts/combined_gbk/"
PROKKA_DB="/data/scratch/bsalehe/prokka_db/"
PROKKA_OUT="/data/scratch/bsalehe/prokka_out"
#spades_out="$1"
Assembly="$1"
#### Prokka genome annotation #### 
 
# 12.03.18 Downloaded all Pseudomonas syringae group complete genome NCBI accession numbers to build database for Prokka annotation
# This included complete chromosomes and plasmids (102 total)
# Accession list was used to find all records on genbank and download as one file 

# Install ncbi-genome-download 
## conda create -n ncbi_genome_download
## conda install -c bioconda ncbi-genome-download

# Acticate the ncbi-genome-download
## conda activate ncbi-genome-download

# Download ref genomes from ncbi
### ncbi-genome-download -F genbank --genera "Pseudomonas syringae" bacteria -v --flat-output

# Move all gbff.gz to single folder
# mv *.gbff.gz refseq/

# Decompress files from .gbff.gz to .gbk
## for file in refseq/*.gbff.gz; do
##       zcat $file > refseq/$(basename $file .gbff.gz).gbk
## done

# Copy some few latest genomes to new folder 
## mkdir refseq1
## cp refseq/*.1_C*.gbk refseq1/

# Merge all .gbk files into single gbk file using adapted merge_gbk.py script
## mkdir refseq_merged
#conda create -n biopython
#conda activate biopython
#conda install -c anaconda biopython
export MYCONDAPATH=/home/bsalehe/miniconda3
source ${MYCONDAPATH}/bin/activate biopython
#
python merge_gbk.py ${REFSEQPATH}*.gbk > ${REFSEQJOINEDGBK}ps.gbk
conda deactivate
# 
#export MYCONDAPATH=/home/bsalehe/miniconda3

# conda activate prokka
source ${MYCONDAPATH}/bin/activate prokka

# Run Prokka
prokka --proteins ${REFSEQJOINEDGBK}ps.gbk --outdir ${PROKKA_OUT}/ps_annotation "$Assembly"/contigs.fasta

#convert all ref genbank files into fasta format
#prokka-genbank_to_fasta_db ${REFSEQPATH}*.gbk > ${REFSEQPATH}ps.faa

#mv ${REFSEQPATH}ps.faa ${PROKKA_DB}ps.faa

#makeblastdb -in ${PROKKA_DB}ps.faa -dbtype prot

#blastp -query ps_annotation/*.faa -db ${PROKKA_DB}ps.faa > ps_proteins

conda deactivate
