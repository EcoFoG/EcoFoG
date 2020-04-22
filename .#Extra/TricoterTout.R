#' TricoterTout
#'
#' Code identique à celui de la fonction 

destination="docs"
  # Article
  wd <- getwd()
  tmpdir <- tempdir()
  setwd(tmpdir)
  rmarkdown::draft("article", template="article", package="EcoFoG", edit=FALSE)
  setwd("article")
  # Knit to HTML
  rmarkdown::render(input="article.Rmd", output_format=bookdown::html_document2(), output_dir = "docs")
  # Knit to pdf
  rmarkdown::render(input="article.Rmd", output_format=bookdown::pdf_book(base_format = EcoFoG::article), output_dir = "docs")
  # Copy to destination
  docsDirs <- list.dirs(path="docs", full.names=TRUE, recursive=TRUE)
  dir.create(paste(wd, "/", destination, sep = ""))
  dir.create(paste(wd, "/", destination, "/article", sep = ""))
  if (length(docsDirs) > 0) {
    sapply(paste(wd, "/", destination, "/article/", docsDirs, sep=""), dir.create)
    docsFiles <- list.files("docs", full.names=TRUE, recursive=TRUE)
    file.copy(from=docsFiles, to=paste(wd, "/", destination, "/article/", docsFiles, sep = ""), overwrite=TRUE)
  }
  # Clean up
  setwd(wd)
  unlink(paste(tmpdir, "/article", sep = ""), recursive = TRUE)


