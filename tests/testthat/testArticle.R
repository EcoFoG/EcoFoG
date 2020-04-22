testthat::context("Article")

# Knit from template
testthat::test_that("Article is knitted", {
  testthat::skip_on_cran()
  # create an article project
  if (rmarkdown::pandoc_available()) {
    # Create a project
    rmarkdown::draft("article", template="article", package="EcoFoG", edit=FALSE)
    setwd("article/")
    # Knit in HTML
    test_result <- rmarkdown::render(input="article.Rmd", output_format=bookdown::html_document2())
    testthat::expect_true(endsWith(test_result, "article.html"))
    # Knit in pdf
    test_result <- rmarkdown::render(input="article.Rmd",
                                     output_format=bookdown::pdf_book(base_format = EcoFoG::article))
    testthat::expect_true(endsWith(test_result, "article.pdf"))
    # Clean up
    source("GithubPages.R")
    setwd("..")
    # unlink("article", recursive = TRUE)
  }
})
