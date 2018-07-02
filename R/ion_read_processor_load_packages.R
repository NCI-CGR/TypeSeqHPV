#' **Load Packages**
#'  
#' We us a function dymanic_require() here to install packages if they are not already in R environment. 
#' They should already be installed in the docker image 
#' but this is still sometimes helpful for testing on other platforms (such as databricks).

ion_read_processor_load_packages <- function(){
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
                  "jsonlite",
                  "sparklyr"))

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

dynamic_require_bioc("GenomicAlignments")

sessionInfo()
}
