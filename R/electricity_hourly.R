#' Hourly data from the UCI ElectricityLoadDiagrams20112014 Data Set
#'
#' The dataset contains hourly mean KW per 15min of 370 clients.
#' We have processed the dataset so it only includes the active period of
#' each client. Ie, we take the period between the first non zero-entry and
#' the last non-zero entry.
#'
#' @source [UCI database](https://archive.ics.uci.edu/ml/datasets/ElectricityLoadDiagrams20112014)
#'
#' @examples
#' library(electricity)
#' str(electricity_hourly)
#' @export
"electricity_hourly"
