#' Linear combination of regression coefficients
#'
#' This function calculates the point estimate and standard error for a linear
#' combination of regression coefficients (similar to Stata's "lincom"
#' function). At this stage the combination must be specified as a numeric
#' vector (or matrix) of weights -- future updates will extend this to allow
#' more flexible methods of specifying coefficient combinations (similar to
#' `car`'s `linearHypothesis` function).
#'
#' @param model A regression model with `coef` and `vcov` methods.
#' @param weights A numeric vector of coefficient weights to construct the
#'     combination, or a matrix in which each row represents one such
#'     combination. Each element specifies the weight applied to the
#'     corresponding element of `attr(terms(model), "term.labels")`.
#' @param vcov. (Optional) Either a function for estimating the covariance
#'     matrix of the regression coefficients, or the covariance matrix itself.
#'     If not specified, the default `vcov` method is used.
#'
#' @export
lincom <- function(model, weights, vcov. = NULL) {
  if (!rlang::is_bare_numeric(weights) || length(dim(weights)) > 2)
    stop_not_numeric("weights", matrix = TRUE)
  if (length(dim(weights)) != 2) weights <- matrix(weights, nrow = 1)

  if (is.null(vcov.)) vcov <- stats::vcov(model)
  else if (is.function(vcov.)) vcov <- vcov.(model)
  else if (is.matrix(vcov.)) vcov <- vcov.
  else stop("Invalid 'vcov.' argument")

  coefs <- stats::coef(model)

  b <- c(weights %*% coefs)
  V <- weights %*% vcov %*% t(weights)

  if (length(b) > 1) {
    df.residual <- df.residual(model)
    F.test <- Ftest(b, V, df.residual)
    list(b = b, V = V, F.test = F.test)
  } else {
    list(b = b, se = sqrt(diag(V)))
  }
}

Ftest <- function(b, V, df.residual = Inf) {
  df <- length(b)
  F.stat <- (t(b) %*% solve(V) %*% b) / df
  P <- stats::pf(F.stat, df, df.residual, lower.tail = FALSE)

  list(df.residual = df.residual, df = df, F.stat = F.stat, P = P)
}
