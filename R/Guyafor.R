#' Donnees Guyafor
#'
#' Importation de l'ensemble des données de la base Guyafor dans un dataframe
#'
#' La fonction exécute une requête sur le serveur sql.ecofog.gf pour lire les données
#' @author Gaëlle Jaouen, \email{gaelle.jaouen@ecofog.gf}
#' @importFrom RODBC odbcConnect
#' @importFrom RODBC odbcClose
#' @importFrom RODBC sqlQuery
#' @export

Guyafor2df <- function () {
  # Connection odbc à Guyafor sur serveur SQL
  Connex <- RODBC::odbcConnect(dsn="Guyafor")

  # Sélection des données

  req1 <- "SELECT dbo.TtGuyaforShiny.NomForet, dbo.TtGuyaforShiny.n_parcelle, dbo.TtGuyaforShiny.n_carre, dbo.TtGuyaforShiny.n_arbre, dbo.TtGuyaforShiny.Surface,
                  dbo.TtGuyaforShiny.i_arbre, dbo.TtGuyaforShiny.X, dbo.TtGuyaforShiny.Y, dbo.TtGuyaforShiny.Xutm, dbo.TtGuyaforShiny.Yutm, dbo.TtGuyaforShiny.UTMZone,
                  dbo.TtGuyaforShiny.Lat, dbo.TtGuyaforShiny.Lon, dbo.TtGuyaforShiny.n_essence, dbo.TtGuyaforShiny.idPilote, dbo.TtGuyaforShiny.nomPilote,
                  dbo.TtGuyaforShiny.Densite, dbo.TtGuyaforShiny.circonf, dbo.TtGuyaforShiny.code_vivant, dbo.TtGuyaforShiny.code_mesure, dbo.TtGuyaforShiny.campagne,
                  dbo.TtGuyaforShiny.DateMesure, dbo.taMesure_Corr.circ_corr, dbo.taMesure_Corr.code_corr, dbo.TtGuyaforShiny.Famille, dbo.TtGuyaforShiny.Genre,
                  dbo.TtGuyaforShiny.Espece, dbo.TtGuyaforShiny.Commerciale, dbo.TtGuyaforShiny.SourceBota, dbo.TtGuyaforShiny.indSurete
           FROM   dbo.TtGuyaforShiny INNER JOIN
                  dbo.taMesure_Corr ON dbo.TtGuyaforShiny.idMesure = dbo.taMesure_Corr.idMesure"

  RODBC::sqlQuery(Connex,req1) -> dfGuyafor

  # Clôture de la connection odbc
  RODBC::odbcClose(Connex)
}




#' Donnees Paracou
#'
#' Importation de l'ensemble des données de Paracou de la base Guyafor dans un dataframe
#'
#' La fonction exécute une requête sur le serveur sql.ecofog.gf pour lire les données
#' @author Gaëlle Jaouen, \email{gaelle.jaouen@ecofog.gf}
#' @importFrom RODBC odbcConnect
#' @importFrom RODBC odbcClose
#' @importFrom RODBC sqlQuery
#' @export

Paracou2df <- function () {
  # Connection odbc à Guyafor sur serveur SQL
  Connex <- RODBC::odbcConnect(dsn="Guyafor")

  # Sélection des données

  req1 <- "SELECT dbo.TtGuyaforShiny.NomForet, dbo.TtGuyaforShiny.n_parcelle, dbo.TtGuyaforShiny.n_carre, dbo.TtGuyaforShiny.n_arbre, dbo.TtGuyaforShiny.Surface,
                  dbo.TtGuyaforShiny.i_arbre, dbo.TtGuyaforShiny.X, dbo.TtGuyaforShiny.Y, dbo.TtGuyaforShiny.Xutm, dbo.TtGuyaforShiny.Yutm, dbo.TtGuyaforShiny.UTMZone,
                  dbo.TtGuyaforShiny.Lat, dbo.TtGuyaforShiny.Lon, dbo.TtGuyaforShiny.n_essence, dbo.TtGuyaforShiny.idPilote, dbo.TtGuyaforShiny.nomPilote,
                  dbo.TtGuyaforShiny.Densite, dbo.TtGuyaforShiny.circonf, dbo.TtGuyaforShiny.code_vivant, dbo.TtGuyaforShiny.code_mesure, dbo.TtGuyaforShiny.campagne,
                  dbo.TtGuyaforShiny.DateMesure, dbo.taMesure_Corr.circ_corr, dbo.taMesure_Corr.code_corr, dbo.TtGuyaforShiny.Famille, dbo.TtGuyaforShiny.Genre,
                  dbo.TtGuyaforShiny.Espece, dbo.TtGuyaforShiny.Commerciale, dbo.TtGuyaforShiny.SourceBota, dbo.TtGuyaforShiny.indSurete
           FROM   dbo.TtGuyaforShiny INNER JOIN
                  dbo.taMesure_Corr ON dbo.TtGuyaforShiny.idMesure = dbo.taMesure_Corr.idMesure
           WHERE  (dbo.TtGuyaforShiny.NomForet = N'paracou')"

  RODBC::sqlQuery(Connex,req1) -> dfParacou

  # Clôture de la connection odbc
  RODBC::odbcClose(Connex)
}

