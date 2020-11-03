testthat::context("Tricot")

Sys.setlocale('LC_ALL','C')

# Knit from template
testthat::test_that("Templates are knitted", {
  testthat::skip_on_cran()
  # knit all templates
  if (rmarkdown::pandoc_available()) {
    TricoterTout()
    # Clean up
    unlink("docs", recursive = TRUE)
  }
})
