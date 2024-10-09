prop.ci <- function(x, n, cc = FALSE, conf.level = 0.95) {
  z <- qnorm(1 - (1 - conf.level) / 2)
  p <- x / n
  q <- 1 - p
  denom <- 2 * (n + z^2)
  lhs <- 2 * n * p + z^2
  var <- z^2 + 4 * n * p * q
  if (cc) {
    L <- (lhs - 1 - z * sqrt(var + 4 * p - 2 - 1/n)) / denom
    L[p == 0] <- 0
    U <- (lhs + 1 + z * sqrt(var - 4 * p + 2 - 1/n)) / denom
    U[p == 1] <- 1
  } else {
    L <- (lhs - z * sqrt(var)) / denom
    U <- (lhs + z * sqrt(var)) / denom
  }
  cbind(L, U)
}
