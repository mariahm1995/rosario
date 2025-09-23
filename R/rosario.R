#' Generate cyclic and mirrored permutations of a time series
#'
#' For a numeric vector, creates the set of cyclic shifts and their
#' mirror images (reverse order), preserving shape but changing location along
#' the cycle. The suite of vectors and mirrors represent a complete set
#'  of possible distributions.
#'
#' @param numvec Numeric vector representing a single biological identity'
#' distributions across ordered time intervals.
#'
#' @return A list of numeric vectors with all the permutations in the time series,
#' including the mirror patterns.
#' @examples
#' rosario(c(40, 25, 18, 10, 5, 2))
#' @seealso [vec_permutation()], [rosario_sample()]
#' @export

rosario <- function(numvec){
  vecLength <- length(numvec)
  veclist <- purrr::map(vecLength:2, function(x){vec_permutation(numvec, x)})
  c(list(numvec), veclist) %>%
    purrr::map(function(x) c(x, rev(x)))
}

#' ROSARIO randomization of an assemblage matrix
#'
#' Randomly permutes each row by a uniform cyclic shift of its columns and,
#' with probability 0.5, reverses the order (mirror image). This kind of
#' permutations preserves each biological identity's temporal autocorrelation
#' structure and niche breadth while randomizing location within the cycle.
#'
#' @param mat Numeric matrix with biological identities in rows and ordered
#' time intervals in columns.
#'
#' @return A numeric matrix of the same dimension as `mat`, randomized row-wise.
#' @examples
#' rosario_sample(ex1)
#' @seealso [rosario()], [vec_permutation()]
#' @export
#'
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
