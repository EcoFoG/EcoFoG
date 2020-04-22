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

