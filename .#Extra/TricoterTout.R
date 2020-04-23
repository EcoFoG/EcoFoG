# TricoterTout
#
# Création des documents à partir des modèles
# Appelé par Travis

# Installation du package
# A ce stade, les tests ont validé le bon fonctionnement
remotes::install_github("EcoFoG/EcoFoG")
# Tricot
EcoFoG::TricoterTout()
