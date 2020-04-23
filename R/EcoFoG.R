#' EcoFoG
#'
#' Package rassemblant les outils communs à l'UMR EcoFoG dans R
#'
#' @name EcoFoG
#' @docType package
#' @import magrittr
NULL


# Fonctions internes
#  Utilitaires pour article() et memo()
#  Largement inspirées du package rticles
#' @keywords internal
find_file <- function (template, file) {
  template <- system.file("rmarkdown", "templates", template, file, package = "EcoFoG")
  if (template == "") {
    stop("Couldn't find template file ", template, "/", file, call. = FALSE)
  }
  return(template)
}
#' @keywords internal
find_resource <- function (template, file) {
  return(find_file(template, file.path("resources", file)))
}
#' @keywords internal
inherit_pdf_document <- function (...) {
  fmt <- rmarkdown::pdf_document(...)
  fmt$inherits <- "pdf_document"
  return(fmt)
}

#' Article
#'
#' Formatage d'un article pour l'auto-archivage
#'
#' La fonction est appelée par le modèle Markdown article
#'
#' @param ... Arguments optionnels passés à \code{\link{pdf_document}}
#' @param md_extensions Extensions markdodown, cf. \code{\link{pdf_document}}
#'
#' @export
article <- function (..., md_extensions = c("-autolink_bare_uris")) {
  inherit_pdf_document(..., template = find_resource("article", "template.tex"), md_extensions = md_extensions, citation_package = "natbib")
}

#' Memo
#'
#' Formatage d'un mémo
#'
#' La fonction est appelée par le modèle Markdown memo
#'
#' @inheritParams article
#'
#' @export
memo <- function (..., md_extensions = c("-autolink_bare_uris")) {
  inherit_pdf_document(..., template = find_resource("memo", "template.tex"), md_extensions = md_extensions, citation_package = "natbib")
}



#' TricoterTout
#'
#' Création des tous les documents à partir des modèles
#'
#' Utilisé pour vérifier le bon fonctionnement des modèles
#'
#' @param destination Dossier de destination des documents
#'
#' @export
TricoterTout <- function (destination="docs") {
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

  # Beamer
  setwd(tmpdir)
  rmarkdown::draft("beamer", template="beamer", package="EcoFoG", edit=FALSE)
  setwd("beamer")
  # Knit to HTML
  rmarkdown::render(input="beamer.Rmd",
                    output_format=rmarkdown::ioslides_presentation(
                      logo="images/EcoFoG2020.png", widescreen=TRUE), output_dir = "docs")
  # Knit to pdf
  rmarkdown::render(input="beamer.Rmd",
                    output_format=rmarkdown::beamer_presentation(
                      includes=list(in_header="EcoFoGBeamer.tex", df_print="kable",
                                    fig_caption=FALSE, slide_level=2)), output_dir = "docs")
  # Copy to destination
  docsDirs <- list.dirs(path="docs", full.names=TRUE, recursive=TRUE)
  dir.create(paste(wd, "/", destination, "/beamer", sep = ""))
  if (length(docsDirs) > 0) {
    sapply(paste(wd, "/", destination, "/beamer/", docsDirs, sep=""), dir.create)
    docsFiles <- list.files("docs", full.names=TRUE, recursive=TRUE)
    file.copy(from=docsFiles, to=paste(wd, "/", destination, "/beamer/", docsFiles, sep = ""), overwrite=TRUE)
  }
  # Clean up
  setwd(wd)
  unlink(paste(tmpdir, "/beamer", sep = ""), recursive = TRUE)

  # Book
  setwd(tmpdir)
  rmarkdown::draft("book", template="book", package="EcoFoG", edit=FALSE)
  setwd("book")
  unlink("book.Rmd")
  # Knit to HTML
  bookdown::render_book("index.Rmd", "bookdown::gitbook")
  # Knit to pdf
  bookdown::render_book("index.Rmd", "bookdown::pdf_book")
  # Copy to destination
  docsDirs <- list.dirs(path="docs", full.names=TRUE, recursive=TRUE)
  dir.create(paste(wd, "/", destination, "/book", sep = ""))
  if (length(docsDirs) > 0) {
    sapply(paste(wd, "/", destination, "/book/", docsDirs, sep=""), dir.create)
    docsFiles <- list.files("docs", full.names=TRUE, recursive=TRUE)
    file.copy(from=docsFiles, to=paste(wd, "/", destination, "/book/", docsFiles, sep = ""), overwrite=TRUE)
  }
  # Clean up
  setwd(wd)
  unlink(paste(tmpdir, "/beamer", sep = ""), recursive = TRUE)

  # Memo
  setwd(tmpdir)
  rmarkdown::draft("memo", template="memo", package="EcoFoG", edit=FALSE)
  setwd("memo")
  # Knit to HTML
  rmarkdown::render(input="memo.Rmd", output_format=bookdown::html_document2(), output_dir = "docs")
  # Knit to pdf
  rmarkdown::render(input="memo.Rmd", output_format=bookdown::pdf_book(base_format = EcoFoG::memo), output_dir = "docs")
  # Copy to destination
  docsDirs <- list.dirs(path="docs", full.names=TRUE, recursive=TRUE)
  dir.create(paste(wd, "/", destination, "/memo", sep = ""))
  if (length(docsDirs) > 0) {
    sapply(paste(wd, "/", destination, "/memo/", docsDirs, sep=""), dir.create)
    docsFiles <- list.files("docs", full.names=TRUE, recursive=TRUE)
    file.copy(from=docsFiles, to=paste(wd, "/", destination, "/memo/", docsFiles, sep = ""), overwrite=TRUE)
  }
  # Clean up
  setwd(wd)
  unlink(paste(tmpdir, "/memo", sep = ""), recursive = TRUE)
}


