## Epiphytes Canker Cherry Pipeline

The pipeline runs through fastq files to produce predicted effectors which will be used for further downstreaming functional and phylogenetic analysis.

### Phase 1: Pre-prcessing

For the first phase when running, the pipeline is expected to do the following:
- Pre-processing fastq files using fastp.sh script file running fastp (https://github.com/OpenGene/fastp) tool. The fastp final output will be stored in the same directory where the pipeline script runs.
- Performing genome assembly using SPAdes.sh script file running SPAdes (http://bioinf.spbau.ru/spades).
- Perform coverage analysis using genme_cov.sh which runs cuont.pl.
- Performing assembly quality analysis using quast.sh script running quast (http://quast.sourceforge.net/).
- Performing genome annotation using prokka_ps.sh script running prokka (https://github.com/tseemann/prokka).

Please run the pipeline in the slurm environment by typing the following command:
```
sbatch pipeline.sh
```
The pipeline.sh script file should be in the same directory with other script files.
Before running the pipeline script open it using vim or any text editor and please change accordingly READSDATADIR path where the data reads are located.
Example `READSDATADIR="/home/bsalehe/canker_cherry/data/"`

You may need to change the PROKKA_OUT variable which holds the final prokka final fasta output file for being used as an input for effector prediction using BEAN2.0, and also change the path for reference gbk files in the 'prokka_ps.sh' script file.
Example `REFSEQPATH="/home/bsalehe/canker_cherry/scripts/refseq1/"`. 

The prokka script should be conifgured accordingly. In my case I did the following:

1. I installed ncbi-genome-download tool using conda. This is not needed at the moment
`conda create -n ncbi_genome_download`
`conda install -c bioconda ncbi-genome-download`

2. I activated the ncbi-genome-download
`conda activate ncbi-genome-download`

3. I downloaded ref genomes from ncbi
'ncbi-genome-download -F genbank --genera "Pseudomonas syringae" bacteria -v --flat-output`

4. I moved all gbff.gz to a single folder
`mv *.gbff.gz refseq/`

5. I decompressed files from .gbff.gz to .gbk
```
  for file in refseq/*.gbff.gz; do
       zcat $file > refseq/$(basename $file .gbff.gz).gbk
  done
```

6. I copied some few genomes to new folder for testing
```
   mkdir refseq1
   cp refseq/*.1_C*.gbk refseq1/
```

7. I merged all .gbk files into single gbk file using adapted merge_gbk.py script
```
   mkdir refseq_merged
   python merge_gbk.py refseq1/*.gbk > refseq_merged/ps.gbk
```
Step 1 and 2 may be skipped. Step 3 up to 7 may be repeated by uncommenting the prokka_script accordingly excluding step 6.

### Phase 2: Downstream analysis for Effectors prediction and phylogenomic analysis
The second phase of the pipeline is expected to do the following:
- Taking the output from Prokka and use them to predict potential T3SS effectors using BEAN2.0 (http://systbio.cau.edu.cn/bean).
- Predicting the T6SS  effectors.
- Predicting T2SS effectors.
- Perform prophage and phylogenetic analysis.

#### Configuring BEAN-2.0
BEAN-2.0 comes with the 'classify.pl' script, which requires several perl modules to be in your PERL5LIB path in addition to those needed to run
pfam_scan module. These modules include `Class::Load::Load` `Eval::Closure` `IPC::Run` `Package::DeprecationManager' `Test::Fatal`.

The following settings were also done in the 'classify.pl' file:
- BLAST's database
`my $blast_nrdb="/data/scratch/bsalehe/blast_nrdb/nr";`
- HHBLITS's database
`my $hhsuite_db="/home/bsalehe/canker_cherry/hhsuit_db/scop/scop95";`
- PfamScan's database
`my $pfam_db="/scratch/software/BEAN2.0/pfam_db";`
- HHblits' tool script reformat.pl path
`my $reformat='/scratch/software/hh-suite/build/scripts';`
- PfamScan' tool script pfam_scan.pl path
`my $pfamscan='/scratch/software/BEAN2.0/PfamScan/pfam_scan.pl';`
- Libsvm' tool script svm-predict
`my $svm_pred='/home/bsalehe/canker_cherry/software/BEAN-2.0/libsvm-2.9/svm-predict';`

#### Setting necessary variables in bean.sh
You may need to reset varaibles `BEAN_PATH` and `PIPELINE_OUT` in the file bean.sh. The former finds where BEAN classify.pl script is located while the later saves the prediction results of the bean in text format.

#### Additional T3SS Prediction Tools
We have added in the pipeline two more additional tools for predicting T3 effectors. These are:-
- Deepredeff
- EffectiveT3

Deepredeff depends on R and Tensorflow to run CNN models. The prediction is done de novo without feature selection mechanism.

Two databases have been added from the installation directories of the source folders of the tools. These are:
`module` and `db` which are for EffectiveT3 and Deepredeff respectively.

