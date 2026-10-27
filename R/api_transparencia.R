# ------------------------------------------------------------------
# R/api_transparencia.R
#
# Funcions per llegir dades de qualsevol recurs del portal de Dades
# Obertes de la Generalitat de Catalunya (API SODA / Socrata),
# aplicant la clàusula WHERE i LIMIT opcionalment.
# ------------------------------------------------------------------

library(httr2)
library(readr)
library(jsonlite)
library(dplyr)

#' Llegeix dades d'un recurs de analisi.transparenciacatalunya.cat
#'
#' @param resource_id Identificador del recurs, p.ex. "ques-gd6z" o "vq27-2ky2"
#' @param format      "csv" (per defecte, recomanat) o "json"
#' @param where       (opcional) Clàusula WHERE en format SoQL, p.ex.
#'                     'caseless_eq(`municipi`, "Sabadell")'
#' @param limit       (opcional) nombre màxim de files a retornar
#'
#' @return Un tibble amb el resultat de la consulta
llegir_dades_transparencia <- function(resource_id, format = c("csv", "json"),
                                       where = NULL, limit = NULL) {
  format <- match.arg(format)
  
  base_url <- sprintf(
    "https://analisi.transparenciacatalunya.cat/resource/%s.%s",
    resource_id, format
  )
  
  req <- request(base_url)
  
  if (!is.null(where)) {
    req <- req |> req_url_query(`$where` = where)
  }
  
  if (!is.null(limit)) {
    req <- req |> req_url_query(`$limit` = limit)
  }
  
  resp <- req_perform(req)
  
  if (format == "csv") {
    dades <- resp |>
      resp_body_string(encoding = "UTF-8") |>
      I() |> read_csv(show_col_types = FALSE)
  } else {
    dades <- resp |>
      resp_body_string(encoding = "UTF-8") |>
      fromJSON(flatten = TRUE) |>
      as_tibble()
  }
  
  dades
}
