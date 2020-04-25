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



#' Tricoter
#'
#' Création des tous les documents à partir des modèles
#'
#' Utilisé pour vérifier le bon fonctionnement des modèles
#'
#' @param destination Dossier de destination des documents
#'
#' @name Tricoter
NULL


#' @rdname Tricoter
#' @export
TricoterTout <- function (destination="docs") {
  TricoterArticle(destination=destination)
  TricoterPresentation(destination=destination)
  TricoterOuvrage(destination=destination)
  TricoterMemo(destination=destination)
}

#' @rdname Tricoter
#' @export
TricoterArticle <- function (destination="docs") {
  # Preparation
  knitr_table_format <- options("knitr.table.format")
  OriginalWD <- getwd()
  tmpdir <- tempdir()
  # Article
  setwd(tmpdir)
  unlink("article", recursive = TRUE)
  rmarkdown::draft("article", template="article", package="EcoFoG", edit=FALSE)
  setwd("article")
  # Knit to HTML
  options(knitr.table.format = 'html')
  rmarkdown::render(input="article.Rmd",
                    output_format=bookdown::html_document2(theme="sandstone", toc=TRUE, toc_float=TRUE),
                    output_dir = "docs")
  # Knit to pdf
  options(knitr.table.format = 'latex')
  rmarkdown::render(input="article.Rmd", output_format=bookdown::pdf_book(base_format = EcoFoG::article), output_dir = "docs")
  # Copy to destination
  docsDirs <- list.dirs(path="docs", full.names=TRUE, recursive=TRUE)
  dir.create(paste(OriginalWD, "/", destination, sep = ""))
  dir.create(paste(OriginalWD, "/", destination, "/article", sep = ""))
  if (length(docsDirs) > 0) {
    sapply(paste(OriginalWD, "/", destination, "/article/", docsDirs, sep=""), dir.create)
    docsFiles <- list.files("docs", full.names=TRUE, recursive=TRUE)
    file.copy(from=docsFiles, to=paste(OriginalWD, "/", destination, "/article/", docsFiles, sep = ""), overwrite=TRUE)
  }
  # Clean up
  setwd(OriginalWD)
  unlink(paste(tmpdir, "/article", sep = ""), recursive = TRUE)
  options(knitr.table.format = knitr_table_format)
}

#' @rdname Tricoter
#' @export
TricoterPresentation <- function (destination="docs") {
  # Preparation
  knitr_table_format <- options("knitr.table.format")
  OriginalWD <- getwd()
  tmpdir <- tempdir()
  # Beamer
  setwd(tmpdir)
  unlink("beamer", recursive = TRUE)
  rmarkdown::draft("beamer", template="beamer", package="EcoFoG", edit=FALSE)
  setwd("beamer")
  # Knit to HTML
  options(knitr.table.format = 'html')
  rmarkdown::render(input="beamer.Rmd",
                    output_format=rmarkdown::ioslides_presentation(
                      logo="images/EcoFoG2020.png", widescreen=TRUE), output_dir = "docs")
  # Knit to pdf
  options(knitr.table.format = 'latex')
  rmarkdown::render(input="beamer.Rmd",
                    output_format=rmarkdown::beamer_presentation(
                      includes=list(in_header="EcoFoGBeamer.tex"),
                      df_print="kable", fig_caption=FALSE, slide_level=2),
                    output_dir = "docs")
  # Copy to destination
  docsDirs <- list.dirs(path="docs", full.names=TRUE, recursive=TRUE)
  dir.create(paste(OriginalWD, "/", destination, sep = ""))
  dir.create(paste(OriginalWD, "/", destination, "/beamer", sep = ""))
  if (length(docsDirs) > 0) {
    sapply(paste(OriginalWD, "/", destination, "/beamer/", docsDirs, sep=""), dir.create)
    docsFiles <- list.files("docs", full.names=TRUE, recursive=TRUE)
    file.copy(from=docsFiles, to=paste(OriginalWD, "/", destination, "/beamer/", docsFiles, sep = ""), overwrite=TRUE)
  }
  # Clean up
  setwd(OriginalWD)
  unlink(paste(tmpdir, "/beamer", sep = ""), recursive = TRUE)
  options(knitr.table.format = knitr_table_format)
}

#' @rdname Tricoter
#' @export
TricoterOuvrage <- function (destination="docs") {
  # Preparation
  knitr_table_format <- options("knitr.table.format")
  OriginalWD <- getwd()
  tmpdir <- tempdir()
  # Book
  setwd(tmpdir)
  unlink("book", recursive = TRUE)
  rmarkdown::draft("book", template="book", package="EcoFoG", edit=FALSE)
  setwd("book")
  unlink("book.Rmd")
  # Knit to HTML
  options(knitr.table.format = 'html')
  bookdown::render_book("index.Rmd", "bookdown::gitbook", clean_envir=FALSE)
  # Knit to pdf
  options(knitr.table.format = 'latex')
  bookdown::render_book("index.Rmd", "bookdown::pdf_book", clean_envir=FALSE)
  # Copy to destination
  docsDirs <- list.dirs(path="docs", full.names=TRUE, recursive=TRUE)
  dir.create(paste(OriginalWD, "/", destination, sep = ""))
  dir.create(paste(OriginalWD, "/", destination, "/book", sep = ""))
  if (length(docsDirs) > 0) {
    sapply(paste(OriginalWD, "/", destination, "/book/", docsDirs, sep=""), dir.create)
    docsFiles <- list.files("docs", full.names=TRUE, recursive=TRUE)
    file.copy(from=docsFiles, to=paste(OriginalWD, "/", destination, "/book/", docsFiles, sep = ""), overwrite=TRUE)
  }
  # Clean up
  setwd(OriginalWD)
  unlink(paste(tmpdir, "/book", sep = ""), recursive = TRUE)
  options(knitr.table.format = knitr_table_format)
}

#' @rdname Tricoter
#' @export
TricoterMemo <- function (destination="docs") {
  # Preparation
  knitr_table_format <- options("knitr.table.format")
  OriginalWD <- getwd()
  tmpdir <- tempdir()
  # Memo
  setwd(tmpdir)
  unlink("memo", recursive = TRUE)
  rmarkdown::draft("memo", template="memo", package="EcoFoG", edit=FALSE)
  setwd("memo")
  # Knit to HTML
  options(knitr.table.format = 'html')
  rmarkdown::render(input="memo.Rmd", output_format=bookdown::html_document2(), output_dir = "docs")
  # Knit to pdf
  options(knitr.table.format = 'latex')
  rmarkdown::render(input="memo.Rmd", output_format=bookdown::pdf_book(base_format = EcoFoG::memo), output_dir = "docs")
  # Copy to destination
  docsDirs <- list.dirs(path="docs", full.names=TRUE, recursive=TRUE)
  dir.create(paste(OriginalWD, "/", destination, sep = ""))
  dir.create(paste(OriginalWD, "/", destination, "/memo", sep = ""))
  if (length(docsDirs) > 0) {
    sapply(paste(OriginalWD, "/", destination, "/memo/", docsDirs, sep=""), dir.create)
    docsFiles <- list.files("docs", full.names=TRUE, recursive=TRUE)
    file.copy(from=docsFiles, to=paste(OriginalWD, "/", destination, "/memo/", docsFiles, sep = ""), overwrite=TRUE)
  }
  # Clean up
  setwd(OriginalWD)
  unlink(paste(tmpdir, "/memo", sep = ""), recursive = TRUE)
  options(knitr.table.format = knitr_table_format)
}
