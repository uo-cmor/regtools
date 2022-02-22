#' Compute confidence interval bounds from confidence level
#'
#' @param conf.level Confidence level, expressed as a proportion in (0, 1); default is 0.95.
#'
#' @export
calculate_ci <- function(conf.level = 0.95) {
  if (!rlang::is_scalar_double(conf.level)) stop_not_number("conf.level")
  if (!(conf.level > 0 && conf.level < 1)) stop_invalid_ci(conf.level)

  c((1 - conf.level) / 2, 1 - (1 - conf.level) / 2)
}
