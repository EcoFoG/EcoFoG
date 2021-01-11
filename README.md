# EcoFoG <img src="man/figures/logo.png" align="right" alt="" width="120" />

![R-CMD-check](https://github.com/EcoFoG/EcoFoG/workflows/R-CMD-check/badge.svg)
[![codecov](https://codecov.io/github/EcoFoG/EcoFoG/branch/master/graphs/badge.svg)](https://codecov.io/github/EcoFoG/EcoFoG) 

Utilitaires pour l'UMR EcoFoG (package R)

## Contenu

* Modèles : ensemble de modèles utilisant la syntaxe de [bookdown](https://bookdown.org/yihui/bookdown/), qui permet la bibliographie, les références croisées, etc.

  * modèle de [présentation Beamer](https://ecofog.github.io/EcoFoG/beamer/docs/beamer.pdf) (R Markdown) ou [HTML (ioslides)](https://ecofog.github.io/EcoFoG/beamer/docs/beamer.html).
  * modèle de memo [HTML](https://ecofog.github.io/EcoFoG/memo/docs/memo.html) et [PDF](https://ecofog.github.io/EcoFoG/memo/docs/memo.pdf) au format simple (R Markdown).
  * modèle d'[article](https://ecofog.github.io/EcoFoG/article/docs/article.pdf) pour l'autoarchivage en PDF (R Markdown), identique au memo en HTML.
  *  Modèle d'ouvrage en [HTML](https://ecofog.github.io/EcoFoG/book/docs/index.html) ou [PDF](https://ecofog.github.io/EcoFoG/book/docs/MyBook.pdf) (Bookdown): livre, rapport, thèse. 

* Accès aux données Guyafor: `Guyafor2df()` et `Paracou2df()`.
* Cartographie interactive de Paracou: `Automap()`.


## Installation

Dans R : `remotes::install_github("EcoFoG/EcoFoG", build_vignettes = TRUE)`


## Vignette

Une [vignette](https://ecofog.github.io/EcoFoG/) est disponible.
Dans R, utiliser la commande `vignette("EcoFoG")`.
