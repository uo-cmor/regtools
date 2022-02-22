stop_not_numeric <- function(arg, matrix = TRUE) {
  x <- paste0("{.arg {arg}} must be a numeric vector", if (matrix) " or matrix.")
  cli::cli_abort(x, "cmor.tools_error_not_numeric", arg = arg, matrix = matrix)
}

stop_not_number <- function(arg) {
  x <- "{.arg {arg}} must be a numeric scalar."
  cli::cli_abort(x, "cmor.tools_error_not_number", arg = arg)
}

stop_invalid_ci <- function(conf.level) {
  x <- c("{.arg conf.level} must be a numeric scalar between 0 and 1.",
         x = "You've provided {.val {conf.level}}.")
  cli::cli_abort(x, "cmor.tools_error_invalid_ci", conf.level = conf.level)
}
