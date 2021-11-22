# This how i solve the "Can't locate IPC/Run.pm in @INC (you may need to install the IPC::Run module) (@INC contains: /home/bsalehe/perl5/lib/perl5/5.24.1/x86_64-linux-gnu-thread-multi /home/bsalehe/perl>
BEGIN failed--compilation aborted at /home/bsalehe/perl5/lib/perl5/5.24.1/x86_64-linux-gnu-thread-multi/Bio/Pfam/Scan/PfamScan.pm line 36.
Compilation failed in require at ./pfam_scan.pl line 8." error when running pfam_scan.pl
#
echo 1 > /home/bsalehe/perl5/lib/perl5/5.24.1/x86_64-linux-gnu-thread-multi/Bio/Pfam/Scan/PfamScan.pm
chmod u-x /home/bsalehe/perl5/lib/perl5/5.24.1/x86_64-linux-gnu-thread-multi/Bio/Pfam/Scan
ls -d /home/bsalehe/perl5/lib/perl5/5.24.1/x86_64-linux-gnu-thread-multi/Bio/Pfam/Scan
ls -l /home/bsalehe/perl5/lib/perl5/5.24.1/x86_64-linux-gnu-thread-multi/Bio/Pfam/Scan ## I got permission denied as below:
##############################################################

#ls: cannot access '/home/bsalehe/perl5/lib/perl5/5.24.1/x86_64-linux-gnu-thread-multi/Bio/Pfam/Scan/Seq.pm': Permission denied
#ls: cannot access '/home/bsalehe/perl5/lib/perl5/5.24.1/x86_64-linux-gnu-thread-multi/Bio/Pfam/Scan/PfamScan.pm': Permission denied
#total 0
#?????????? ? ? ? ?            ? PfamScan.pm
#?????????? ? ? ? ?            ? Seq.pm

###############################################################
chmod u+x /home/bsalehe/perl5/lib/perl5/5.24.1/x86_64-linux-gnu-thread-multi/Bio/Pfam/Scan
ls -l /home/bsalehe/perl5/lib/perl5/5.24.1/x86_64-linux-gnu-thread-multi/Bio/Pfam ## Got no more permission denied
#
# Test to check whether the 'Can't locate' error is comming up again
perl -I /home/bsalehe/perl5/lib/perl5/5.24.1/x86_64-linux-gnu-thread-multi/Bio/Pfam/Scan -MPfamScan -e'1' # Nothing is comming up
#
# Run again ./pfam_scan.pl ## now shows the help msg output for running Pfam HMMS
# Source: https://www.perlmonks.org/?node_id=1034621
#
##But before this error I was getting:
##Can't locate Bio/Pfam/Scan/PfamScan.pm in @INC
#Then I moved Bio/Pfam to my perllib path from the installation path.
mv Bio/Pfam /home/bsalehe/perl5/lib/perl5/5.24.1/x86_64-linux-gnu-thread-multi/
#
########################################

# Running Pfam steps

########################################
#
#Downloading Pfam database
#https://pfam-docs.readthedocs.io/en/latest/ftp-site.html
#
wget -N ftp://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.dat.gz
wget -N ftp://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz
gunzip *.gz
hmmpress Pfam-A.hmm
#
#
#                                                                                         
##Solving problem "A_05262021.fasta -dir /scratch/software/BEAN2.0/pfam_db -outfile outdir_pfam
Can't locate object method "new" via package "Bio::Pfam::Scan::PfamScan" (perhaps you forgot to load "Bio::Pfam::Scan::PfamScan"?) at ./pfam_scan.pl line 111." when configuring pfam_scan.pl
#
# Understand all possible path of PERL5LIB in the system. Type:-
perl -wle 'print for @INC'
#
# Open bashrc file and change accordingly the PERL5LIB path where PfamScan.pm module exist, typically within Bio/Pfam directory path which was moved FROM PfamScan gunzipped directory.
#
# Copy the directory of pfam_scan.pl to PERL5LIB path in the bashrc
# Make sure you properly direct the pfam_scan where it can find the hmmer bineries in the system path with bashrc
#
# The bashrc file will look like below:
######################################################################
PATH="/home/bsalehe/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/bsalehe/perl5/lib/perl5/x86_64-linux-gnu-thread-multi${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/bsalehe/perl5/x86_64-linux-gnu-thread-multi${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/bsalehe/perl5/x86_64-linux-gnu-thread-multi\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/bsalehe/perl5/x86_64-linux-gnu-thread-multi"; export PERL_MM_OPT;
HMMERPATH=/scratch/software/hmmer-2.3/bin
export PATH=${PATH}:$HMMERPATH
export PERL5LIB=/scratch/software/BEAN2.0/PfamScan/:$PERL5LIB
#########################################################################
#
# close and source the bashrc file
#
# Off you go in running pfam_scan.pl
#
# For running BEAN2.0 with classify.pl several perl modules needed which causes error:
# "Can't locate Package/Module" error. These modules include:
#Class/Load.pm, Eval/Closure.pm, IPC/Run.pm, Package/DeprecationManager.pm, 
#Test/Fatal.pm and almost all of other modules in Test/
#
# All these had to be copied from '/home/bsalehe/perl5/lib/perl5/' to the PERL5LIB path where pfam_scanDir was linked as shown above.

###################### Update on running BEAN2.0 #####################
#
# Keep getting "BLAST Database error: Could not find volume or alias file (nr.08) referenced in alias file (/data/scratch/bsalehe/blast_nrdb/nr)." error.
# Solved that error by running with the latest blast version BLAST 2.11.0+ which is compatible with the new nr database release.
#
#
#
ListUtil.c: loadable library and perl binaries are mismatched (got handshake key 0xdb00080, needed 0xdb80080)
# Soln:
# Open ~/.bashrc file and insert the below variable
PERL5LIB=PERL_LOCAL_LIB_ROOT=cpan
# From https://stackoverflow.com/questions/45000585/listutil-c-loadable-library-and-perl-binaries-are-mismatched-got-handshake-key
#
#
#
## PROKKA errors
Contig ID must <= 37 chars long: NODE_10192_length_4255_cov_6002.545300
soln:
Change by increasing the integer in the constant variable $MAXCONTIGIDLEN in the bin/prokka main script
#source: https://github.com/tseemann/prokka/issues/141
#
#
#
## awk command to skip to the next line of the CNN-T4SE output file for 
## removing pattern 'Protein_ID in every next line
awk '/Protein_ID/ {next} {print} HT8_S6_prediction_results_CNN-T4SEworked.csv >> HT8_S6_prediction_results_CNN-T4SEworked_new.csv

## To split file based on the line number: example
(head -4999 > HT8_S6_out_prokka/PROKKA_07302021_c.faa; cat > HT8_S6_out_prokka/PROKKA_07302021_d.faa) < HT8_S6_out_prokka/PROKKA_07302021_4.faa

# Counting number of proteins predicted to be TSS4 (YES) by CNNT4SEWorked
grep "YES" HT8_S6_prediction_results_CNN-T4SEworked_new.csv | wc -l

# Counting number of sequence of the PROKKA annotated protein sequence
grep "^>" SD3_S8_out_prokka/PROKKA_07302021.faa | wc -l

# Macysfinder prediction of all TXSS. E.g command for single sample
macsyfinder -m TXSS all --sequence-db /data/scratch/bsalehe/prokka_out/HT1_S1_out_prokka/PROKKA_07302021.faa --db-type ordered_replicon --models-dir /home/bsalehe/.macsyfinder/data -o /data/scratch/bsalehe/canker_cherry_pipeline_output/T6/macsyf

# Key git commands
git add "pipeline_ref_genomes.sh"
git commit -m "Add pipeline_ref_genomes.sh"
git pull --rebase --autostash
git push -u origin main
git add "macsyf.sh"
git add macsyf.sh
git commit -m "Add macsyf.sh"
git push -u origin main
git add cnn_t4se_v1.sh
git commit -m "Add cnn_t4se file"
git push -u origin main
#
# error: The following untracked working tree files would be overwritten by merge:
	cnn_t4se.sh
# Please move or remove them before you merge.
# Aborting
git add cnn_t4se.sh
git stash
git pull
git push -u origin main

###################################################################
### 25/10/2021

# Copying all output files to new paths

## Copying assembly and pre-processing files
for file in ./HT*_coverage.txt; do  cp $file assembly_pre-processing/Tracy/1/; done

for file in ./SD*_coverage.txt; do  cp $file assembly_pre-processing/Tracy/1/; done

for d in ./HT*_fastp_output; do  cp -r $d assembly_pre-processing/Tracy/1/; done

for d in ./SD*_fastp_output; do  cp -r $d assembly_pre-processing/Tracy/1/; done

for d in ./HT*_quast_out; do  cp -r $d assembly_pre-processing/Tracy/1/; done

for d in ./SD*_quast_out; do  cp -r $d assembly_pre-processing/Tracy/1/; done

## Removing all output assembly and pre-processing files from /data/scratch/bsalehe/canker_cherry_pipeline_output
rm ./HT*_coverage.txt

rm ./SD*_coverage.txt

rm -r ./HT*_fastp_output

rm -r ./SD*_fastp_output

rm -r ./HT*_quast_out

rm -r ./SD*_quast_out

## Copying analysis files (predicted effectors, orthologs, phages & genomic islands) from /data/scratch/bsalehe/canker_cherry_pipeline_output to new directory analysis/Tracy/1/
for file in ./HT*_deepredeff_result_.csv; do  cp $file analysis/Tracy/1/T3/deepredeff/; done

for file in ./SD*_deepredeff_result_.csv; do  cp $file analysis/Tracy/1/T3/deepredeff/; done

for file in ./*_genome_deepredeff_result_.csv; do  cp $file analysis/Tracy/1/T3/deepredeff/; done

cp -r TXSS/ analysis/Tracy/1/all_TiSS/macsyfinder/

cp -r gislandviewer analysis/Tracy/1/genomic_islands/

cp -r orthology analysis/Tracy/1/

cp -r phages analysis/Tracy/1/


## Removing all output (predicted effectors, orthologs, phages & genomic islands) from /data/scratch/bsalehe/canker_cherry_pipeline_output
rm *.csv

rm -r gislandviewer

rm -r orthology

rm -r phages

rm -r TXSS/ 

###################################################################################
####### 01/11/2021

# Extracting sequence from the thord column of the filtered Deepredeff predicted T3 effectors for further BLASTING
cd /data/scratch/bsalehe/canker_cherry_pipeline_output/analysis/Tracy/1/T3/deepredeff
for file in *_deepredeff_result_filtered.csv ; do  name=$(basename $file .csv); awk -F, 'NR>1 {print ">"$2 "\n" $3}' $file > ${name}_sequence.fasta; done
