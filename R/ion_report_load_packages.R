#' **Load Packages**
#'  
#' We us a function dymanic_require() here to install packages if they are not already in R environment. 
#' They should already be installed in the docker image 
#' but this is still sometimes helpful for testing on other platforms (such as databricks).

ion_report_load_packages <- function(){
# load packages
 
dynamic_require_bioc = function(x){
  for( i in x ){
    #  require returns TRUE invisibly if it was able to load package
    if( ! require( i , character.only = TRUE ) ){
      #  If package was not able to be loaded then re-install
      source("https://bioconductor.org/biocLite.R")
      biocLite(i)
      install.packages( i , dependencies = TRUE )
      #  Load package after installing
      require( i , character.only = TRUE )
    }
  }
}

dynamic_require_bioc(c("graph", 
                       "GenomicAlignments"))
  
  
  
  
dynamic_require = function(x){
  for( i in x ){
    #  require returns TRUE invisibly if it was able to load package
    if( ! require( i , character.only = TRUE ) ){
      #  If package was not able to be loaded then re-install
      install.packages( i , dependencies = TRUE )
      #  Load package after installing
      require( i , character.only = TRUE )
    }
  }
}

dynamic_require(c("tidyverse",
                  "devtools",
                  "stringr",
                  "jsonlite",
                  "pander",
                  "scales",
                  "knitr",
                  "koRpus",
                  "pandoc",
                  "rmarkdown",
                  "fuzzyjoin",
                  "ggsci",
                  "CodeDepends",
                  "visNetwork",
                  "txtq",
                  "webshot",
                  "networkD3",
                  "future",
                  "drake", 
                  "parallel",
                  "optigrab",
                  "formatR",
                  "remotes",
                  "stringi",
                  "V8",
                  "DT"
                  ))
sessionInfo()
  
}
