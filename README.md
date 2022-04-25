# TypeSeq HPV
***NCI CGR laboratory HPV typing analysis workflows and R package***

TypeSeq HPV is an R package that includes  

* several helper functions for working with TypeSeq data  
* contains a "make" based pipeline for processing Ion runs  
* contains a docker build file that includes all the dependencies inside a single container  
  
We recommend running the pipeline inside the docker container ```cgrlab/typeseqhpv:final_220316``` as it contains all the required dependencies in the correct locations.

The workflow manager we use is **drake** https://github.com/ropensci/drake


## Ion Torrent Plugin

We also include a wrapper for the Ion Torrent server that can be uploaded via the provided zip file.  The prerequisite for running the Ion Torrent Plugin successfully is to install docker on the server ahead of time.


### Download and add hpv-typing plugin zip file via torrent server gui

https://github.com/NCI-CGR/IonTorrent_plugins/tree/main/TypeSeqHPV-TSv1/archive


### Tools utilized in the Ion Torrent
- Drake 
   - Function: workflow engine
   - https://github.com/ropensci/drake
- Sambamba view
   - Function: creates a json that is more easily parsed
   - https://github.com/biod/sambamba
- Samtools view header
   - Function: extracts a header from one of the BAM files to determine list of contigs
   - Li H, Handsaker B, Wysoker A, Fennell T, Ruan J, Homer N, Marth G, Abecasis G, Durbin R, and 1000 Genome Project Data Processing Subgroup, The Sequence alignment/map (SAM) format and SAMtools, Bioinformatics (2009) 25(16) 2078-9 [19505943]
- TypeSeqHPV R package
   - Function: wrangles data, filter-based QC, creates report and matrix deliverables
   - R packages this depends on:
      - Tidyverse, ggplot, ggsci, Rmarkdown, fuzzyjoin, drake, furrr
         - https://github.com/tidyverse/tidyverse
         - https://github.com/tidyverse/ggplot2
         - https://github.com/rstudio/rmarkdown
         - https://github.com/dgrtwo/fuzzyjoin
         - https://github.com/ropensci/drake
         6. https://github.com/DavisVaughan/furrr
- Docker
   - Function: enables portability
   - The plugin runs inside a docker container with all dependencies
   - Docker run triggers the workflow
   - https://www.docker.com/


