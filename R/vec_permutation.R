#' Cyclic permutation (rotate) a numeric vector
#'
#' Returns a cyclic shift of `numvec` so that position `x` becomes the first
#' element and the order wraps around the end.
#'
#' @param numvec Numeric vector representing an ordered cycle.
#' @param x Integer (1-based) index of the new starting position.
#'
#' @return A numeric vector of the same length as `numvec`, rotated so that
#'   `numvec[x]` is first.
#' @examples
#' vec_permutation(1:6, 4)  # 4 5 6 1 2 3
#' @export
#'
vec_permutation <- function(numvec, x = 1){
  module_logic <- as.logical((1:length(numvec) %/% x) )
  module_sequence <- c(which(module_logic), which(!module_logic))
  numvec[ module_sequence ]
}


