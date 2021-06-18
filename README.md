## Epiphytes Canker Cherry Pipeline

The pipeline runs through fastq files to produce predicted effectors which will be used for further downstreaming functional and phylogenetic analysis.

Please run the pipeline in the slurm environment by typing the following command:
```
sbatch pipeline.sh
```
The pipeline.sh script file should be in the same directory with other script files.

When running, the pipeline is expected to do the following: 
- Pre-processing fastq files using fastp.sh script file running fastp (https://github.com/OpenGene/fastp) tool. The fastp final output will be stored in the same directory where the pipeline script runs.
- Performing genome assembly using SPAdes.sh script file running SPAdes (http://bioinf.spbau.ru/spades).
- Perform coverage analysis using genme_cov.sh which runs cuont.pl.
- Performing assembly quality analysis using quast.sh script running quast (http://quast.sourceforge.net/).
- Performing genome annotation using prokka_ps.sh script running prokka (https://github.com/tseemann/prokka).

The second phase of the pipeline is expected to do the following:
- Taking the output from Prokka and use them to predict potential T3SS effectors using BEAN2.0 (http://systbio.cau.edu.cn/bean).
- Predicting the T6SS  effectors.
- Predicting T2SS effectors.
- Perform prophage and phylogenetic analysis.

### Configuring BEAN-2.0
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
