### Préparation des pages github (master branch / docs comme site web)
# Sourcer ce fichier avant de livrer.

# Update vignette
devtools::build_vignettes()

# pkgdown
pkgdown::build_site()

# Mise à jour manuelle de docs/Article, docs/memo, docs/Ouvrage et docs/Presentation:
# Vider chaque dossier puis New Markdown from Template, knit to html.
