
<!-- README.md is generated from README.Rmd. Please edit that file -->

# regtools

<!-- badges: start -->
<!-- badges: end -->

The goal of regtools is to provide simple tools for the analysis of
regression models.

## Installation

You can install the released version of regtools from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("uo-cmor/regtools")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(regtools)

df <- data.frame(a = 1:12, b = rep(c("b1", "b2", "b3"), c(4, 5, 3)), c = rep(0:1, c(5, 7)))
model <- lm(a ~ b + c, df)

lincom(model, c(1, 0.5, 0.3, 0.2))
#> $b
#> [1] 6.05
#> 
#> $se
#> [1] 0.7770135

lincom(model, rbind(c(1, 0.5, 0.3, 0.2),
                        c(0.2, 0.3, 0.5, 0.2)))
#> $b
#> [1] 6.05 4.75
#> 
#> $V
#>         [,1]    [,2]
#> [1,] 0.60375 0.58125
#> [2,] 0.58125 0.83375
#> 
#> $F.test
#> $F.test$df.residual
#> [1] 8
#> 
#> $F.test$df
#> [1] 2
#> 
#> $F.test$F.stat
#>          [,1]
#> [1,] 32.41837
#> 
#> $F.test$P
#>              [,1]
#> [1,] 0.0001455319
```
