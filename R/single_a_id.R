## Compute sentinel station statistics with an auxiliary stations
##
## `single_a_id` computes statistics for a single sentinel station
## corresponding to a single auxiliary stations
##
## @param s_id A character vector of unique sentinel station identifiers. If
## this variable is not  specified, the \code{sentinel()} function defaults to
## \code{s_id} equaling all unique values in \code{id}.
## @param a_id A character vector of unique auxiliary station identifiers. If
## this variable is not specified, the \code{sentinel()} function defaults to
## \code{a_id} equaling all unique values in \code{id}.
## @param id A character vector matching the name of the variable in \code{data}
## containing station identifiers
## @param group A character vector matching the name of the variable in \code{data}
## containing grouping information for which to pair sentinel and auxiliary
## stations.
## @param value A character vector matching the name of the variable in \code{data}
## containing the response variable for which statistics are computed.
## @param data A data.frame, tibble, sp, or sf object containing the \code{id},
## \code{group}, and \code{value} variables.
## @param n_min An integer specifying the minimum number of matching \code{group}
## variables in each sentinel-auxiliary pair required to compute relevant
## statistics
## @param type A character vector indicating the type of statistic desired.
## @param output A character vector indicating the desired output. \code{output}
## can have three values: "overall", "individual", and "dataset". If "overall
## is in \code{output}, overall summary statistics are returned for each sentinel
## station. If "individual" is in \code{output}, statistics are returned for each
## sentinel-auxiliary station pair. If "dataset" is in \code{output}, a data.frame
## is returned with all data used to compute relevant statistics. Defaults to
## "overall".
## @param ... Additional arguments provided to sentinel that correspond to the
## value of the \code{type} argument.
##
## @return A list containing sublists for the corresponding `output` specified
## @export
##
## @examples
single_a_id <- function(s_id, a_id, id, group, value, data, n_min, type, ...){
  output <- UseMethod("sentinel", structure(list(), class = type))
  invisible(output)
}
