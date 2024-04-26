
#' Arbitrary ciclic permutation of a numeric vector
#'
#' @param numvec A numeric vector. This function is designed to deal with
#' the randomization
#' time series of animal activity
#' @param x The new starting position of the permutation
#'
#' @return A permuted vector
#' @export
#'
#' @examples vec_permutation(1:24, 4)
vec_permutation <- function(numvec, x = 1){
  module_logic <- as.logical((1:length(numvec) %/% x) )
  module_sequence <- c(which(module_logic), which(!module_logic))
  numvec[ module_sequence ]
}


