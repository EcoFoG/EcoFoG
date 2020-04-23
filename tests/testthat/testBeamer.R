testthat::context("Beamer")

# Knit from template
testthat::test_that("Beamer is knitted", {
  testthat::skip_on_cran()
  # create a beamer project
  if (rmarkdown::pandoc_available()) {
    # Create a project
    rmarkdown::draft("test_beamer", template="beamer", package="EcoFoG", edit=FALSE)
    setwd("test_beamer/")
    # Knit in HTML
    test_result <- rmarkdown::render(input="test_beamer.Rmd", output_format=rmarkdown::ioslides_presentation())
    testthat::expect_true(endsWith(test_result, "test_beamer.html"))
    # Knit in pdf
    test_result <- rmarkdown::render(input="test_beamer.Rmd",
                                     output_format=rmarkdown::beamer_presentation(includes=list(in_header="EcoFoGBeamer.tex")))
    testthat::expect_true(endsWith(test_result, "test_beamer.pdf"))
    # Clean up
    setwd("..")
    unlink("test_beamer", recursive = TRUE)
  }
})
