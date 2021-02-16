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
#' @param type The type of summary -- fixed at "correlation"
#' @param n_min An integer specifying the minimum number of matching \code{group}
#' variables in each sentinel-auxiliary pair required to compute relevant
#' statistics
#' @param output A character vector indicating the desired output. \code{output}
#' can have three values: "overall", "individual", and "dataset". If "overall
#' is in \code{output}, overall summary statistics are returned for each sentinel
#' station. If "individual" is in \code{output}, statistics are returned for each
#' sentinel-auxiliary station pair. If "dataset" is in \code{output}, a data.frame
#' is returned with all data used to compute relevant statistics. Defaults to
#' "overall".
#' @param ... Additional arguments corresponding to arguments from the \code{cor.test}
#' function in the \code{stats} package (see \code{?stats::cor.test} for
#' more information).
#'
#' @return A list containing sublists for the corresponding \code{output} specified
#' @export
#' @method sentinel correlation
sentinel.correlation <- function(s_id, a_id, id, group, value, data, type = "correlation", n_min, output = "overall", ...) {



  # making a data frame with sentinel response and code
  sentinel_data <- data.frame(group = data[[group]][data[[id]] == s_id], s_id = s_id,
                                      s_value = data[[value]][data[[id]] == s_id], stringsAsFactors = FALSE)

  # making a data frame with other response and code
  other_data <- data.frame(group = data[[group]][data[[id]] == a_id], a_id = a_id,
                                 a_value = data[[value]][data[[id]] == a_id], stringsAsFactors = FALSE)

  # merging the two together and then removing missing cases
  merged_data <- stats::na.omit(merge(sentinel_data, other_data, all = TRUE))

  # finding the sample size (number of matching cases)
  n <- length(merged_data$group)

  # returning the correlation output if the other code has enough matches and is not a repeat of the sentinel code
  if ((n >= pmax(3, n_min)) & (s_id != a_id)) {

    # running the correlation test
    cor_test <- stats::cor.test(x = merged_data$s_value, y = merged_data$a_value, ...)

    # storing the output for estimate and p-value
    estimate <- unname(cor_test$estimate)
    p <- unname(cor_test$p.value)

  } else {
    estimate <- NA
    p <- NA
  }

  # storing the output in a data frame
  individual <- data.frame(s_id = s_id, a_id = a_id, n = n, estimate = estimate, p = p, stringsAsFactors = FALSE)


  invisible(list(individual = individual, dataset = merged_data))
}
