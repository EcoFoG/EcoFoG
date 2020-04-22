testthat::context("Article")

# Check rarely used estimators
testthat::test_that("Coverage is estimated", {
  testthat::skip_on_cran()
  # create an article project
  if (rmarkdown::pandoc_available()) {
    rmarkdown::draft("test_article", template="article", package="EcoFoG", edit=FALSE)
    setwd("test_article/")
    test_result <- rmarkdown::render("test_article.Rmd", "html_document")
    testthat::expect_true(endsWith(test_result, "test_article.html"))
    test_result <- rmarkdown::render("test_article.Rmd", "pdf_document")
    testthat::expect_true(endsWith(test_result, "test_article.pdf"))
    setwd("..")
    unlink("test_article", recursive = TRUE)
  }
})
