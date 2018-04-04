# TypeSeqer_HPV
***CGR laboratory's HPV typing TypeSeqer analysis workflows***

# Instructions For Running Illumina TypeSeqer

## 1. Generate fastq files from raw sequencing data using modified parameters
  
The Illumina fastq files need to be regenerated using the following custom bcl2fastq parameters:  
```  
bcl2fastq --runfolder-dir [location of run directory (local or networked drive) ]  
--output-dir [ any directory]  
--with-failed-reads  
--minimum-trimmed-read-length 11  
--mask-short-adapter-reads 11  
```  

This should generate two new fastq files, one for R1 and one for R2. Any version of bcl2fastq higher than  
2.19 should work.
  
## 2. Create New Directory for The Project  

The pre-built image, cwl file, and helper bash script are hosted in an archive on the NIH HPC at `https://hpc.nih.gov/~robersondw/TypeSeqerHPV_0.18.314.tar.gz`

The workflow will need to utilize a fresh working directory. Make sure that the contents of
`typeseqerHPV.0.18.31403.simg.tar.gz` are in this working directory.  The complete set of files needed for the task are:
  
  
   1. Bash script with execution command (in archive)
   2. Common workflow language file (in archive)
   3. The Singularity image (in archive)
   4. Pair of fastq files (provided by user)
   5. TypeSeqer run manifest (provided by user)
   6. Control definitions file (provided by user)
   
As an alternative the user can genearate the singularity image by building from the Dockerfile.  The user will still need to download the latest cwl and shell script from this reposititory.     
    
## 3. Adjust the Shell Variables  

In the shell script there are 5 variables that will need to be entered manually to help with the Singularity
exec command. These include fastq1, fastq2, control_defs, run_manifest and working_dir.  
  
Note that the file paths specified should be relative to the working_dir so that the relationship is
maintained inside the container. Any paths relative to your local environment will not work inside
Singularity.
  
## 4. Run the Workflow  
  
These instructions were tested on the NIH HPC which uses Slurm Workload Manager. We used an
interactive node but the shell script can easily be adjusted for a batch job. For a fast completion time try
to use at least 16 or 24 cores and at least 60 GB RAM. A typical MiSeq run should complete in 45
minutes with 24 cores.
  
The workflow will generate a subdirectory with the name of the cwl file and a timestamp (e.g.
illumina_TypeSeqer-2018-03-15-185300.647).  

Inside this folder will be subfolders for each of the tools in the workflow. The illumina_Typeseqer* folder
and its subdirectories can be considered temporary files and may be deleted as soon the workflow
finishes. This folder will need about 50 GB of disk space but will be reduced to about 2GB after the run
completes (these are typical sizes for MiSeq runs; NextSeq runs will require more space).  
  
The folder the end user should keep is called illumina_typeseqer_output and will be about 1 MB. This
will contain a report PDF and CSV tables.  

The version of Singularity we used to run the container is 2.4.4
