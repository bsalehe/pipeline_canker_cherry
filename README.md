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
