## ----Install, eval=FALSE---------------------------------------------------
#  # Install necessary packages only
#  InstallPackages <- function(Packages) {
#    sapply(Packages, function(Package) if (!Package %in% installed.packages()[, 1]) {install.packages(Package)})
#  }
#  # Markdown
#  InstallPackages(c("base64enc", "knitr", "rmarkdown", "bookdown"))
#  # Other packages
#  InstallPackages(c("RODBC", "devtools"))
#  # EcoFoG
#  devtools::install_github("EcoFoG/EcoFoG")

## ----_BiocStyle_, eval=FALSE-----------------------------------------------
#  source("https://bioconductor.org/biocLite.R")
#  biocLite("BiocStyle")

## ---- eval=FALSE-----------------------------------------------------------
#  knitr::knit_hooks$set(crop = knitr::hook_pdfcrop)
#  knitr::opts_chunk$set(crop=TRUE)

