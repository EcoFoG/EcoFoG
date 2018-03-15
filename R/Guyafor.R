#' Donnees Guyafor
#'
#' Importation de l'ensemble des données de la base Guyafor dans un dataframe
#'
#' La fonction exécute une requête sur le serveur sql.ecofog.gf pour lire les données.
#' Un pilote ODBC pour SQL Server doit être accessible.
#'
#' @author Gaëlle Jaouen, \email{gaelle.jaouen@ecofog.gf}
#' @param WHERE Clause WHERE optionnelle de la requête SQL envoyée au serveur
#' @return Un dataframe contenant le résultat de la requête ODBC
#' @export
#' @examples
#' if (!any(is.na(pingr::ping_port("sql.ecofog.gf", port=1433))))
#'   # Si le serveur sql.ecofog.gf est accessible
#'   Paracou15 <- Guyafor2df(WHERE="Forest='Paracou' AND Plot='15' AND CensusYear=2016")

Guyafor2df <- function (WHERE = NULL) {

  if (any(is.na(pingr::ping_port("sql.ecofog.gf", port=1433))))
    stop("Le serveur sql.ecofog.gf n'est pas accessible")

  # Connection odbc à Guyafor sur serveur SQL
  con <- odbc::dbConnect(odbc::odbc(), .connection_string = "Driver={SQL Server};server=sql.ecofog.gf;database=Guyafor;trusted_connection=Yes;")

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

  if (!is.null(WHERE)) {
    # Requête imbriquée pour utiliser les alias dans les conditions WHERE (ex.: Forest='Paracou' AND Plot='15')
    req1 <- paste("SELECT * FROM (", req1, ") AS Guyafor WHERE", WHERE)
  }

  # Création de la connexion
  QueryResult <- odbc::dbSendQuery(con, req1)
  # Lecture des données
  dfGuyafor <- odbc::dbFetch(QueryResult)

  # Clôture de la connection odbc
  odbc::dbClearResult(QueryResult)
  odbc::dbDisconnect(con)

  return(dfGuyafor)
}




#' Donnees Paracou
#'
#' Importation de l'ensemble des données de Paracou de la base Guyafor dans un dataframe
#'
#' La fonction exécute une requête sur le serveur sql.ecofog.gf pour lire les données
#' Un pilote ODBC pour SQL Server doit être accessible.
#'
#' @author Gaëlle Jaouen, \email{gaelle.jaouen@ecofog.gf}
#' @param WHERE Clause WHERE optionnelle de la requête SQL envoyée au serveur
#' @return Un dataframe contenant le résultat de la requête ODBC
#' @export
#' @examples
#' # Creation d'une communaute spatialement explicite (package SpatDiv)
#' if (!any(is.na(pingr::ping_port("sql.ecofog.gf", port=1433)))) {
#'  # Si le serveur sql.ecofog.gf est accessible
#'  if(require(dbmss)) {
#'   Paracou2df("Plot='6' AND CensusYear=2016") %>%
#'   # Arbres vivants
#'   filter(CodeAlive == TRUE) %>%
#'   # Variables utiles
#'   select(Plot, SubPlot:Yfield, Family:Species, CircCorr) %>%
#'   # Nom complet des especes
#'   unite(col = spName, Family, Genus, Species, remove = FALSE) %>%
#'   # Champs d'un wmppp. Le poids est la surface terriere
#'   mutate(X=Xfield, Y=Yfield, PointType=as.factor(spName),
#'     PointWeight=pi*(CircCorr/pi/2)^2, PointName=idTree) %>%
#'   dbmss::wmppp(window = owin(c(0,250), c(0,250),
#'     unitname=c("metre", "metres"))) -> Paracou6
#'  }
#' }
Paracou2df <- function (WHERE = NULL) {

  if (any(is.na(pingr::ping_port("sql.ecofog.gf", port=1433))))
    stop("Le serveur sql.ecofog.gf n'est pas accessible")

  # Connection odbc à Guyafor sur serveur SQL
  con <- odbc::dbConnect(odbc::odbc(), .connection_string = "Driver={SQL Server};server=sql.ecofog.gf;database=Guyafor;trusted_connection=Yes;")

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

  if (!is.null(WHERE)) {
    # Requête imbriquée pour utiliser les alias dans les conditions WHERE (ex.: Forest='Paracou' AND Plot='15')
    req1 <- paste("SELECT * FROM (", req1, ") AS Guyafor WHERE", WHERE)
  }

  # Création de la connexion
  QueryResult <- odbc::dbSendQuery(con, req1)
  # Lecture des données
  dfParacou <- odbc::dbFetch(QueryResult)

  # Clôture de la connection odbc
  odbc::dbClearResult(QueryResult)
  odbc::dbDisconnect(con)

  return(dfParacou)
}

