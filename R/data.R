#' Copepod Data
#'
#' @description A dataset containing stations, auxiliary information, and
#'   abundance. Because we could not share the raw data, we provided this
#'   data set as a means to emulate the raw data.
#'
#' @format A data frame with 43 rows and 5 variables:
#' \describe{
#'   \item{stations}{A character vector of station identifiers}
#'   \item{year}{A numeric vector containing year}
#'   \item{taxa}{A character vector indicating taxa type}
#'   \item{species}{A character vector indicating species type}
#'   \item{abundance}{A numeric vector of abundances}
#' }
"copepod"

#' Paired station data
#'
#' A dataset containing stations, auxiliary information, and a response.
#'
#' @format A data frame with 116 rows and 5 variables:
#' \describe{
#'   \item{stations}{A character vector of station identifiers}
#'   \item{year}{A numeric vector containing year}
#'   \item{response}{A numeric vector of response values}
#'   \item{xcoord}{A numeric vector of x coordinates}
#'   \item{ycoord}{A numeric vector of y coordinates}
#' }
"stationdata"

