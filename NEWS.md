# EcoFog 1.9-1

## Améliorations

* Tests unitaires et intégration continue par Github Actions
* Code de taille script et bibliographie sur deux colonnes dans le modèle book
* Logo EcoFoG 2021
* Standardisation des .gitignore des modèles
* Standardisation des options des bouts de code des modèles
* Gestion plus propre des ouvrages multilingues


# EcoFog 1.8-2

## Améliorations

* Tests unitaires et intégration continue par Travis
* Nom de champs définitifs dans `Guyafor2df`
* Jeu de données par défaut (Paracou 6, 2016) si la base de données est inaccessible.
* Suppression des avertissements inutiles pendant les manipulations de fichiers


# EcoFog 1.7-10

## Améliorations

* Production de documents HTML Bootstrap en plus de Gitbook à partir des modèles
* Vignette par pkgdown
* Possibilité de spécifier le nom du pilote ODBC pour les connexions au serveur SQL
* Logo EcoFoG 2020
* Ajout du champ `DateMesFiable` (fiabilité e la date de mesure) dans `Guyafor2df()` et `Paracou2df()`

## Correction de bugs

* Nettoyage de tous les modèles de documents
* Erreur: Couldn't find template file /resources/template.tex pendant la compilation LaTeX des modèles avec R 3.5-2.
* Modèle d'ouvrage : Evolutions de LaTeX nécessitant de mettre à jour le modèle de page de garde pdgUniv.sty
* Modèle d'ouvrage : Bug de bookdown contourné dans latex/preamble.tex
* `Automap()` ignorait l'argument `Driver`


# EcoFog 1.6-5

## Améliorations

* Nouveau modèle : memo
* Bibliographie du modèle d'ouvrage avec biber au lieu de bibtex
* Meilleure gestion du placement vertical dans les marges du modèle d'ouvrage
* Suppression de l'appel au package LaTeX fixltx2e devenu inutile
* Support des deux colonnes dans les présentations HTML 

# EcoFog 1.5-0

## Améliorations

* Possibilité d'utiliser un dataframe sur Automap()

## Correction de bugs

* Correction d'un bug si la parcelle ne contient pas 4 carrés

# EcoFoG 1.4-0

## Améliorations

* Support de l'authentification SQL sur la base de données.

## Correction de bug

* Déclaration correcte des packages de tidyverse pour l'exemple de `Guyafor2df()`.
* Rectification des cas où les plots ne sont pas découpés en 250*250 sur Automap()



# EcoFoG 1.3-0

## Améliorations

* Formatage avancé des tableaux dans le modèle d'article.


# EcoFoG 1.2-6

## Correction de bug

* L'impossibilité d'atteindre le serveur SQL bloquait indéfiniment les fonctions `Paracou2df()`, `Guyafor2df()` et `Automap()`. Correction : vérification de la connectivité (_ping_) du serveur sql.ecofog.gf avant la connexion ODBC.


# EcoFoG 1.2-5

## Améliorations

* Exemples.

* Nettoyage des importations.


## Améliorations

* Présentations : options R optimisées.


# EcoFoG 1.2-3

## Améliorations

* Présentations : verbatim (PDF) de même taille que les bouts de code.


# EcoFoG 1.2-2

## Améliorations

* Support du caractère degré : °


# EcoFoG 1.2-1

## Correction de bug

* Modèle Présentation : tricotage Beamer impossible en absence de bout de code. Ajout de `\usepackage{fancyvrb}` dans `EcoFoGBeamer.tex`.

## Améliorations

* _.gitignore_ dans tous les modèles.


# EcoFoG 1.2-0

## Améliorations

* Modèle article : simplification de la production. Utilisation standard du bouton _Knit_.

* Modèle Présentation : script `GithubPages.R` pour la maintenance du site web.


# EcoFoG 1.1-2

## Améliorations

* Les accès aux bases SQL utilisent le package _odbc_ au lieu de _RODBC_ et acceptent une clause WHERE.


# EcoFoG 1.1-1

## Améliorations

* Les bouts de code sont affichés en taille `\scriptsize` dans Beamer pour la compatibilité avec IOSlides.


# EcoFoG 1.1-0

## Nouveautés

* `Automap()` permet la création de cartes de Paracou avec une application Shiny.


# EcoFoG 1.0-1

## Correction de bug

* Dans le modèle article, la suppression des champs `journalinfo` ou `journalinfo` générait une erreur de compilation en LaTeX.


# EcoFoG 1.0-0

Première version en production

## Nouveautés

* Les requêtes d'accès aux données de Guyafor utilisent les noms officiels des champs, identiques à ceux du  package ForestData.


# EcoFoG 0.3-2

## Nouveautés

* Le modèle d'article permet de produire un document Word.


# EcoFoG 0.3-0

## Nouveautés

* Le modèle d'article s'appuie sur bookdown.

## Correction de bug

* Le modèle d'ouvrage ignorait le préambule personnalisé.


# EcoFoG 0.2-1

## Nouveautés

* Première version utilisable en production. Le modèle d'ouvrage (livre, thèse, HDR) est opérationnel.


# EcoFoG 0.1-4

## Nouveautés

* Vignette _Introduction_


# EcoFoG 0.1-3

Première version déboguée et documentée.
