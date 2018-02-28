### Make github pages (master branch / docs as web site)
# The README.md file is copied to /docs. Make a link to the main html file in it
# html files, including figures and libs are copied to /docs
# pdf files are copied to /docs
# Source this file before committing

# Update vignette
devtools::build_vignettes()

# Copy vignette
libsFiles <- list.files("inst/doc", pattern="*.html", full.names = FALSE, recursive=TRUE)
file.copy(from=libsFiles, to=paste("docs/", libsFiles, sep = ""), overwrite=TRUE)

# Copy README.md to docs
file.copy(from="README.md", to="docs/README.md", overwrite=TRUE)

# Manual update of docs/Article, docs/Ouvrage and docs/Presentation
# Empty the folder, New Markdown from Template, knit to html
