
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rosario

<!-- badges: start -->
<!-- badges: end -->

This R package implements two common measures of overlap in resource use
for communities. We implement the Pianka (Pianka 1973) and Czekanowski
indices (Feinsinger, Spears, & Poole 1981).

We implement the Pianka’s index of overlap as:

$$
\alpha_{j, k} = \frac{ \sum_{i = 1}^{n}p_{ij}p_{ik} }{\sqrt{} \sum_{i = 1}^{n}p_{ij}^2 * \sum_{i = 1}^{n} p_{ik}^2 }
$$ As well as the Czekanowski index of overlap. $$
\alpha_{j, k} = 1 -\frac{1}{2}\Big(\sum_{i = 1}^{n} |p_{ij} - p_{ik}| \Big)
$$

## Installation

You can install the development version of rosario hosted in github:

``` r
devtools::install_github("alrobles/rosario")
```

## Example

In this case of use we create a simulated community with 20 species and
300 time intervales. With a Poisson distribution. We rescale to get que
relative frequency of time counts and get both distance

``` r
library(rosario)
## basic example code
n = 20
k = 300
#create random matrix
m = matrix(rpois(n*k, 10), ncol = k)


# rescale with sum of rows
freqs <- scale(t(m), center = FALSE, 
               scale = rowSums(m))
# transpose
m <- t(freqs)

# load rosario R package
library(rosario)

# measure the overlap matrix with Pianka's method
overlap_pianka <- temp_overlap(m, method = "pianka")

# measure the overlap matrix with Czekanowski method
overlap_czekanowski <- temp_overlap(m, method = "czekanowski")
```

We can observe the first 6 rows between species:

``` r
overlap_pianka[1:6, 1:6]
#>           [,1]      [,2]      [,3]      [,4]      [,5]      [,6]
#> [1,] 0.0000000 0.9127830 0.9099589 0.9053507 0.9145439 0.8997963
#> [2,] 0.9127830 0.0000000 0.9117832 0.9007759 0.9089715 0.9201218
#> [3,] 0.9099589 0.9117832 0.0000000 0.9151724 0.9168289 0.9093187
#> [4,] 0.9053507 0.9007759 0.9151724 0.0000000 0.9097408 0.8868245
#> [5,] 0.9145439 0.9089715 0.9168289 0.9097408 0.0000000 0.9062268
#> [6,] 0.8997963 0.9201218 0.9093187 0.8868245 0.9062268 0.0000000
```

And for the second example:

``` r
overlap_czekanowski[1:6, 1:6]
#>           [,1]      [,2]      [,3]      [,4]      [,5]      [,6]
#> [1,] 0.0000000 0.8230587 0.8219101 0.8185585 0.8291592 0.8109945
#> [2,] 0.8230587 0.0000000 0.8286438 0.8105342 0.8235404 0.8348117
#> [3,] 0.8219101 0.8286438 0.0000000 0.8284788 0.8329551 0.8207348
#> [4,] 0.8185585 0.8105342 0.8284788 0.0000000 0.8205648 0.8049121
#> [5,] 0.8291592 0.8235404 0.8329551 0.8205648 0.0000000 0.8171527
#> [6,] 0.8109945 0.8348117 0.8207348 0.8049121 0.8171527 0.0000000
```
