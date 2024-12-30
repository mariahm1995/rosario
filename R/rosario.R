#' rosario
#'
#' @param numvec A numeric vector with activity pattern time series
#'
#' @return A list with all the permutations in the time series
#' @export
#'
#' @examples rosario(c(40, 25, 18, 10, 5, 2))
rosario <- function(numvec){
  vecLength <- length(numvec)
  veclist <- purrr::map(vecLength:2, function(x){vec_permutation(numvec, x)})
  c(list(numvec), veclist) %>%
    purrr::map(function(x) c(x, rev(x)))
}

#' Random sampling a niche overlap matrix preserving the
#' autocorrelation temporal structure.
#' Each row of the matrix is permuted starting in a random
#' column. The result also could be reversed with a
#' binomial probability of 0.5.

#'
#' @param mat A matrix with species (rows) and temporal intervals (columns)
#' to be sampled preserving the temporal autocorrelation of the intervals
#'
#' @return A random matrix with same number of species and temporal intervals
#' @export
#'
#' @examples rosario_sample(ex1)

rosario_sample <- function(mat){
  res <-  matrix(data = 0, nrow = nrow(mat), ncol = ncol(mat) )
  ncol_mat <- ncol(mat)
  for(i in 1:nrow(mat)){
    sample_col <- sample(1:ncol_mat, 1, replace = TRUE)
    flag <- stats::rbinom(1, 1, 0.5)
    v <- vec_permutation(mat[i, ], sample_col )
    if(flag){
      res[i, ] <- v
    } else{
      res[i, ] <- rev(v)
    }
  }
  colnames(res) <- colnames(mat)
  res
}
