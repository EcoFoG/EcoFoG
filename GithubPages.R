### Préparation des pages github (master branch / docs comme site web)
# Mise à jour des vignettes et copie dans /docs
# Le fichier README.md est copié dans /docs.
# Sourcer ce fichier avant de livrer.

# Update vignette
devtools::build_vignettes()

# Copy vignette
libsFiles <- list.files("inst/doc", pattern="*.html", full.names = FALSE, recursive=TRUE)
file.copy(from=paste("inst/doc/", libsFiles, sep=""), to=paste("docs/", libsFiles, sep = ""), overwrite=TRUE)

# Copy README.md to docs
file.copy(from="README.md", to="docs/README.md", overwrite=TRUE)

# Mise à jour manuelle de docs/Article, docs/Ouvrage et docs/Presentation:
# Vider chaque dossier puis New Markdown from Template, knit to html.
