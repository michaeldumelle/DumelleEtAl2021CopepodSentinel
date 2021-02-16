#' Compute sentinel station statistics
#'
#' `sentinel()` computes statistics for an arbitrary number of sentinel
#'  stations relative to an arbitrary number of auxiliary stations.
#'
#' @param s_id A character vector of unique sentinel station identifiers. If
#' this variable is not  specified, the \code{sentinel()} function defaults to
#' \code{s_id} equaling all unique values in \code{id}.
#' @param a_id A character vector of unique auxiliary station identifiers. If
#' this variable is not specified, the \code{sentinel()} function defaults to
#' \code{a_id} equaling all unique values in \code{id}.
#' @param id A character vector matching the name of the variable in \code{data}
#' containing station identifiers
#' @param group A character vector matching the name of the variable in \code{data}
#' containing grouping information for which to pair sentinel and auxiliary
#' stations.
#' @param value A character vector matching the name of the variable in \code{data}
#' containing the response variable for which statistics are computed.
#' @param data A data.frame, tibble, sp, or sf object containing the \code{id},
#' \code{group}, and \code{value} variables.
#' @param n_min An integer specifying the minimum number of matching \code{group}
#' variables in each sentinel-auxiliary pair required to compute relevant
#' statistics
#' @param type A character vector indicating the type of statistic desired. The
#' value of type uses the appropriate generic function:
#' \itemize{
#' \item \code{type = "correlation": sentinel.correlation}
#' } For more information, see \code{?sentinel.type}, where type matches the
#' character string normally specified by \code{type} (for example, see
#' \code{?sentinel.correlation} for information about the function when
#' \code{type = "correlation"})
#' @param output A character vector indicating the desired output. \code{output}
#' can have three values: \code{"overall"}, \code{"individual"}, and \code{"dataset"}. If \code{"overall"}
#' is in \code{output}, overall summary statistics are returned for each sentinel
#' station. If \code{"individual"} is in \code{output}, statistics are returned for each
#' sentinel-auxiliary station pair. If \code{"dataset"} is in \code{output}, a data.frame
#' is returned with all data used to compute relevant statistics. Defaults to
#' \code{"overall"}.
#' @param ... Additional arguments provided to sentinel that correspond to the
#' value of the \code{type} argument.
#'
#' @return A list containing sublists for the corresponding \code{output} specified
#' @export
#'
#' @examples
#' id <-  c(rep("Station1", 10), rep("Station2", 8), rep("Station3", 9))
#' data <- data.frame(id = c(rep("Station1", 10), rep("Station2", 8), rep("Station3", 9)),
#' group = c(1:10, 1:8, 1:9), value = rnorm(10 + 8 + 9))
#' output <- sentinel(id = "id",
#' group = "group", value = "value", data = data, type = "correlation",
#' n_min = 0, output = c("overall", "individual", "dataset"), method = "spearman")
sentinel <- function(s_id, a_id, id,
                     group, value, data,
                     n_min, type, output = "overall", ...) {

  # creating a logical index to be used later that returns relevant individual
  output_index <- c("overall" %in% output, "individual" %in% output, "dataset" %in% output)
  names(output_index) <- c("overall", "individual", "dataset")


  # an error message if the user does not want anything returned
  if (all(!output_index)) stop("output argument must be non-empty")

  # default of all stations if the sentinel index argument is missing
  if (missing(s_id)) s_id <- unique(data[[id]])

  # default of all stations if the other index argument is missing
  if (missing(a_id)) a_id <- unique(data[[id]])


  # repeatedly cycling through each sentinel station and applying singlest
  all_st <- lapply(s_id, function(x) all_a_id(s_id = x, a_id = a_id,
                                                            id = id, group = group, data = data,
                                                            value = value, n_min = n_min,
                                                            output_index = output_index,
                                                            type = type, ...))

  # returning the overall upon request
  if (output_index["overall"]) {
    overall <- do.call(rbind, lapply(all_st, function(x) x$overall))
    row.names(overall) <- NULL
  } else overall <- NULL

  # returning the test individual upon request
  if (output_index["individual"]) {
    individual <- do.call(rbind, lapply(all_st, function(x) x$individual))
    row.names(individual) <- NULL
  } else individual <- NULL

  # returning the data upon request
  if (output_index["dataset"]) {
    dataset <- do.call(rbind, lapply(all_st, function(x) x$dataset))
    row.names(dataset) <- NULL
  } else dataset <- NULL

  # returning the appropriate output
  invisible(list(overall = overall, individual = individual, dataset = dataset)[output_index])
}
