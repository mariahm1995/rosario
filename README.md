<!-- README.md is generated from README.Rmd. Please edit that file -->

# rosario

<!-- badges: start -->

<!-- badges: end -->

The `rosario` package provides tools to quantify and visualize temporal niche overlap using Pianka and Czekanowski indices, and to simulate null models with the ROSARIO algorithm (Castro-Arellano et al. 2010).

## Installation

You can install the development version of rosario from [GitHub](https://github.com/) with:

``` r
# Install devtools if you don't have it
install.packages("devtools")

# Install commecometrics from GitHub
devtools::install_github("mariahm1995/rosario")
```

You can also get the official release version from CRAN

``` r
install.packages("rosario")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(rosario)

# Example data
ex1

# Assemblage-wide overlap
temp_overlap(ex1, method = "pianka")

# Null model test
nm <- get_null_model(ex1, method = "pianka", nsim = 200, parallel = FALSE)
nm$p_value

# Visualize ROSARIO patterns
plot_rosario(ex1[1, ], cols = 5)
```
