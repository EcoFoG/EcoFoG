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

  req1 <- "SELECT
    dbo.TtGuyaforShiny.NomForet AS Forest,
    dbo.TtGuyaforShiny.n_parcelle AS Plot,
    dbo.TtGuyaforShiny.Surface AS PlotSurface,
    dbo.TtGuyaforShiny.n_carre AS SubPlot,
    dbo.TtGuyaforShiny.n_arbre AS TreeFieldNum,
    dbo.TtGuyaforShiny.i_arbre AS idTree,
    dbo.TtGuyaforShiny.X AS Xfield,
    dbo.TtGuyaforShiny.Y AS Yfield,
    dbo.TtGuyaforShiny.Xutm,
    dbo.TtGuyaforShiny.Yutm,
    dbo.TtGuyaforShiny.UTMZone,
    dbo.TtGuyaforShiny.Lat,
    dbo.TtGuyaforShiny.Lon,
    dbo.TtGuyaforShiny.Famille AS Family,
    dbo.TtGuyaforShiny.Genre AS Genus,
    dbo.TtGuyaforShiny.Espece AS Species,
    dbo.TtGuyaforShiny.SourceBota AS BotaSource,
    dbo.TtGuyaforShiny.indSurete AS BotaCertainty,
    dbo.TtGuyaforShiny.n_essence,
    dbo.TtGuyaforShiny.idPilote AS idVern,
    dbo.TtGuyaforShiny.nomPilote AS VernName,
    dbo.TtGuyaforShiny.Commerciale AS CommercialSp,
    dbo.TtGuyaforShiny.Densite AS WoodDensity,
    dbo.TtGuyaforShiny.campagne AS CensusYear,
    dbo.TtGuyaforShiny.DateMesure AS CensusDate,
    dbo.TtGuyaforShiny.code_vivant AS CodeAlive,
    dbo.TtGuyaforShiny.code_mesure AS CodeMeas,
    dbo.TtGuyaforShiny.circonf AS Circ,
    dbo.taMesure_Corr.circ_corr AS CircCorr,
    dbo.taMesure_Corr.code_corr AS CodeCorr
  FROM dbo.TtGuyaforShiny
    LEFT OUTER JOIN dbo.taMesure_Corr ON dbo.TtGuyaforShiny.idMesure = dbo.taMesure_Corr.idMesure"


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

  req1 <- "SELECT
    dbo.TtGuyaforShiny.NomForet AS Forest,
    dbo.TtGuyaforShiny.n_parcelle AS Plot,
    dbo.TtGuyaforShiny.Surface AS PlotSurface,
    dbo.TtGuyaforShiny.n_carre AS SubPlot,
    dbo.TtGuyaforShiny.n_arbre AS TreeFieldNum,
    dbo.TtGuyaforShiny.i_arbre AS idTree,
    dbo.TtGuyaforShiny.X AS Xfield,
    dbo.TtGuyaforShiny.Y AS Yfield,
    dbo.TtGuyaforShiny.Xutm,
    dbo.TtGuyaforShiny.Yutm,
    dbo.TtGuyaforShiny.UTMZone,
    dbo.TtGuyaforShiny.Lat,
    dbo.TtGuyaforShiny.Lon,
    dbo.TtGuyaforShiny.Famille AS Family,
    dbo.TtGuyaforShiny.Genre AS Genus,
    dbo.TtGuyaforShiny.Espece AS Species,
    dbo.TtGuyaforShiny.SourceBota AS BotaSource,
    dbo.TtGuyaforShiny.indSurete AS BotaCertainty,
    dbo.TtGuyaforShiny.n_essence,
    dbo.TtGuyaforShiny.idPilote AS idVern,
    dbo.TtGuyaforShiny.nomPilote AS VernName,
    dbo.TtGuyaforShiny.Commerciale AS CommercialSp,
    dbo.TtGuyaforShiny.Densite AS WoodDensity,
    dbo.TtGuyaforShiny.campagne AS CensusYear,
    dbo.TtGuyaforShiny.DateMesure AS CensusDate,
    dbo.TtGuyaforShiny.code_vivant AS CodeAlive,
    dbo.TtGuyaforShiny.code_mesure AS CodeMeas,
    dbo.TtGuyaforShiny.circonf AS Circ,
    dbo.taMesure_Corr.circ_corr AS CircCorr,
    dbo.taMesure_Corr.code_corr AS CodeCorr
  FROM dbo.TtGuyaforShiny
    LEFT OUTER JOIN dbo.taMesure_Corr ON dbo.TtGuyaforShiny.idMesure = dbo.taMesure_Corr.idMesure
  WHERE (dbo.TtGuyaforShiny.NomForet = N'paracou')"

  RODBC::sqlQuery(Connex,req1) -> dfParacou

  # Clôture de la connection odbc
  RODBC::odbcClose(Connex)
}

