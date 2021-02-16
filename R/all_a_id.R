## Compute sentinel station statistics with all auxiliary stations
##
## `all_a_id` computes statistics for a single sentinel station
## corresponding to all auxiliary stations
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
all_a_id <- function(s_id, a_id, id, group, value,
                     data, n_min, type, output_index, ...){




  # taking out the sentinel station
  other_stations <- a_id[a_id != s_id]
  if (length(other_stations) == 0) stop("must provide at least one other station not equal to the sentinel station")
  # repeatedly calling compsum for each other station
  sentsum_list <- lapply(X = other_stations,
                        FUN = function(x){
                          single_a_id(s_id = s_id, a_id = x, id = id,
                                  group = group, value = value, data = data, n_min = n_min,
                                  type = type, ...)
                        })
  #storing the overall results
  sentsum_individual <- do.call(rbind, lapply(sentsum_list, function(x) x$individual))
  if (output_index["dataset"]) {
    sentsum_dataset <- do.call(rbind, lapply(sentsum_list, function(x) x$dataset))
  } else sentsum_dataset <- NULL

  individual <- stats::na.omit(sentsum_individual)


  if (output_index["overall"]){
    if (nrow(individual) > 0) {

      # making weights for the weighted aveage
      w <- individual$n

      # storing the estimate
      est <- individual$estimate

      # storing the overall results
      sentsum_overall <- data.frame(s_id = s_id, wt_mean = sum(w * est) / sum(w),
                                 mean = mean(est), min = min(est), q1 = unname(stats::quantile(est, 0.25)),
                                 med = stats::median(est), q3 = unname(stats::quantile(est, 0.75)),
                                 max = max(est), stringsAsFactors = FALSE)
    } else {
      sentsum_overall <- data.frame(s_id = s_id, wt_mean = NA,
                                 mean = NA, min = NA, q1 = NA, med = NA, q3 = NA, max = NA,
                                 stringsAsFactors = FALSE)
    }
  } else sentsum_overall <- NULL

  output <- list(overall = sentsum_overall, individual = sentsum_individual, dataset = sentsum_dataset)

  invisible(output)
}




