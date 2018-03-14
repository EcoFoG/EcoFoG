#' EcoFoG
#'
#' Package rassemblant les outils communs à l'UMR EcoFoG dans R
#'
#' @name EcoFoG
#' @docType package
#' @import magrittr
NULL

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
  # Largement inspiré du package rticles
  find_file <- function (template, file) {
    template <- system.file("rmarkdown", "templates", template, file, package = "EcoFoG")
    if (template == "") {
      stop("Couldn't find template file ", template, "/", file, call. = FALSE)
    }
    template
  }
  find_resource <- function (template, file) {
    find_file(template, file.path("resources", file))
  }
  inherit_pdf_document <- function (...) {
    fmt <- rmarkdown::pdf_document(...)
    fmt$inherits <- "pdf_document"
    fmt
  }

  inherit_pdf_document(..., template = find_resource("article", "template.tex"), md_extensions = md_extensions, citation_package = "natbib")
}
