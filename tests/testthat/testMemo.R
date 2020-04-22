testthat::context("Memo")

# Knit from template
testthat::test_that("Memo is knitted", {
  testthat::skip_on_cran()
  # create a memo project
  if (rmarkdown::pandoc_available()) {
    # Create a project
    rmarkdown::draft("test_memo", template="memo", package="EcoFoG", edit=FALSE)
    setwd("test_memo/")
    # Knit in HTML
    test_result <- rmarkdown::render(input="test_memo.Rmd", output_format=bookdown::html_document2())
    testthat::expect_true(endsWith(test_result, "test_memo.html"))
    # Knit in pdf
    test_result <- rmarkdown::render(input="test_memo.Rmd", output_format=bookdown::pdf_book())
    testthat::expect_true(endsWith(test_result, "test_memo.pdf"))
    # Clean up
    setwd("..")
    unlink("test_memo", recursive = TRUE)
  }
})
