testthat::context("Article")

# Check rarely used estimators
testthat::test_that("Coverage is estimated", {
  testthat::skip_on_cran()
  # create an article project
  if (rmarkdown::pandoc_available()) {
    # Create a project
    rmarkdown::draft("test_article", template="article", package="EcoFoG", edit=FALSE)
    setwd("test_article/")
    # Knit in HTML
    test_result <- rmarkdown::render(input="test_article.Rmd", output_format=bookdown::html_document2())
    testthat::expect_true(endsWith(test_result, "test_article.html"))
    # Knit in pdf
    test_result <- rmarkdown::render("test_article.Rmd", "pdf_book")
    testthat::expect_true(endsWith(test_result, "test_article.pdf"))
    # Clean up
    setwd("..")
    unlink("test_article", recursive = TRUE)
  }
})
