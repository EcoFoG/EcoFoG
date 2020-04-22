testthat::context("Book")

# Knit from template
testthat::test_that("Book is knitted", {
  testthat::skip_on_cran()
  # create a book project
  if (rmarkdown::pandoc_available()) {
    # Create a project
    rmarkdown::draft("test_book", template="book", package="EcoFoG", edit=FALSE)
    setwd("test_book/")
    unlink("test_book.Rmd")
    # Knit in HTML
    test_result <- bookdown::render_book("index.Rmd", "bookdown::gitbook")
    testthat::expect_true(endsWith(test_result, "index.html"))
    # Knit in pdf
    test_result <- bookdown::render_book("index.Rmd", "bookdown::pdf_book")
    testthat::expect_true(endsWith(test_result, "MyBook.pdf"))
    # Clean up
    setwd("..")
    unlink("test_book", recursive = TRUE)
  }
})
