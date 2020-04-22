#' Donnees Guyafor
#'
#' Importation de l'ensemble des données de la base Guyafor dans un dataframe
#'
#' La fonction exécute une requête sur le serveur sql.ecofog.gf pour lire les données.
#' Un pilote ODBC pour SQL Server doit être accessible.
#'
#' @author Gaëlle Jaouen, \email{gaelle.jaouen@ecofog.gf}
#' @param WHERE Clause WHERE optionnelle de la requête SQL envoyée au serveur
#' @param UID Compte SQL Server utilisé pour la connexion. Par défaut, l'authentification est faite par Windows.
#' @param PWD Mot de passe du compte SQL Server.
#' @param Driver Nom du pilote ODBC, dépendant de l'installation du système. La valeur par défaut est le nom le plus fréquent. "SQL Server" peut fonctionner si la valeur par défaut renvoie une erreur indiquant que le pilote ODBC n'existe pas.
#' @return Un dataframe contenant le résultat de la requête ODBC
#' @export
#' @examples
#' if (!any(is.na(pingr::ping_port("sql.ecofog.gf", port=1433))))
#'   # Si le serveur sql.ecofog.gf est accessible
#'   Paracou15 <- Guyafor2df(WHERE="Forest='Paracou' AND Plot='15' AND CensusYear=2016")
Guyafor2df <- function (WHERE = NULL, UID=NULL, PWD=NULL, Driver="SQL Server Native Client 10.0") {

  return(QueryGuyafor(WHERE, UID, PWD, Driver))

}



#' Donnees Paracou
#'
#' Importation de l'ensemble des données de Paracou de la base Guyafor dans un dataframe
#'
#' La fonction exécute une requête sur le serveur sql.ecofog.gf pour lire les données
#' Un pilote ODBC pour SQL Server doit être accessible.
#'
#' @author Gaëlle Jaouen, \email{gaelle.jaouen@ecofog.gf}
#' @author Eric Marcon, \email{eric.marcon@ecofog.gf}
#' @inheritParams Guyafor2df
#' @return Un dataframe contenant le résultat de la requête ODBC
#' @export
#' @examples
#' # Creation d'une communaute spatialement explicite (package SpatDiv)
#' if(require("dbmss") & require("dplyr") & require("tidyr")) {
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
#'   plot(Paracou6, which.marks="PointWeight",
#'   main="Surface terrière (cm2) \n
#'         des arbres de la parcelle 6 de Paracou en 2016")
#' }
Paracou2df <- function (WHERE = NULL, UID=NULL, PWD=NULL, Driver="SQL Server Native Client 10.0") {

 return(QueryGuyafor(WHERE, UID, PWD, Driver, "WHERE (dbo.TtGuyaforShiny.Forest = N'paracou')"))

}



# Utilitaire pour l'interrogation de la base de données
# Fonction interne
# Arguments : ceux de Guyafor2df et
# codeWHERE : condition SQL supplémentaire codée dans la fonction appelante, alors que WHERE est défini par l'utilisateur.
QueryGuyafor <- function (WHERE, UID, PWD, Driver, codeWHERE = NULL) {

  # Vérification de la connectivité réseau
  if (any(is.na(pingr::ping_port("sql.ecofog.gf", port=1433)))) {
    warning("Le serveur sql.ecofog.gf n'est pas accessible.\n
            L'inventaire 2016 de la parcelle 6 de Paracou est retourné.")
    utils::data(Paracou6_2016)
    return(Paracou6_2016)
  }


  # Connexion odbc à Guyafor sur serveur SQL
  connection_string <- paste("Driver={", Driver, "};server=sql.ecofog.gf;database=Guyafor;", sep="")
  if (is.null(UID)) {
    # Authentification Windows
    connection_string <- paste(connection_string, "trusted_connection=Yes;", sep="")
  } else {
    # Authentification SQL Server
    connection_string <- paste(connection_string, "UID={", UID, "};PWD={", PWD, "};", sep="")
  }
  con <- odbc::dbConnect(odbc::odbc(), .connection_string=connection_string)

  # Sélection des données
  req1 <- "SELECT
  dbo.TtGuyaforShiny.Forest,
  dbo.TtGuyaforShiny.Plot,
  dbo.TtGuyaforShiny.PlotArea,
  dbo.TtGuyaforShiny.SubPlot,
  dbo.TtGuyaforShiny.TreeFieldNum,
  dbo.TtGuyaforShiny.idTree,
  dbo.TtGuyaforShiny.Project,
  dbo.TtGuyaforShiny.Protocole,
  dbo.TtGuyaforShiny.Xfield,
  dbo.TtGuyaforShiny.Yfield,
  dbo.TtGuyaforShiny.Xutm,
  dbo.TtGuyaforShiny.Yutm,
  dbo.TtGuyaforShiny.UTMZone,
  dbo.TtGuyaforShiny.Lat,
  dbo.TtGuyaforShiny.Lon,
  dbo.TtGuyaforShiny.Family,
  dbo.TtGuyaforShiny.Genus,
  dbo.TtGuyaforShiny.Species,
  dbo.TtGuyaforShiny.BotaSource,
  dbo.TtGuyaforShiny.BotaCertainty,
  dbo.TtGuyaforShiny.idVern,
  dbo.TtGuyaforShiny.VernName,
  dbo.TtGuyaforShiny.CommercialSp,
  dbo.TtGuyaforShiny.CensusYear,
  dbo.TtGuyaforShiny.CensusDate,
  dbo.TtGuyaforShiny.CensusDateCertainty,
  dbo.TtGuyaforShiny.CodeAlive,
  dbo.TtGuyaforShiny.MeasCode,
  dbo.TtGuyaforShiny.Circ,
  dbo.TtGuyaforShiny.CircCorr,
  dbo.TtGuyaforShiny.CorrCode

  FROM dbo.TtGuyaforShiny
    LEFT OUTER JOIN dbo.taMesure_Corr ON dbo.TtGuyaforShiny.idMeas = dbo.taMesure_Corr.idMesure"


  if (!is.null(codeWHERE)) {
    # ajout de la condition WHERE de la fonction appelante, typiquement le choix de la forêt
    req1 <- paste(req1, codeWHERE)
  }

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



#' Inventaire 2016 de la parcelle 6 de Paracou.
#'
#' Jeu de données public extrait de la base Guyafor.
#'
#' @format Un tibble contenant une mesure (année 2016) d'un arbre par ligne
#' @source <http://paracou.cirad.fr/>
#' @examples
#' # Nombre d'arbres
#' nrow(Paracou6_2016)
"Paracou6_2016"
