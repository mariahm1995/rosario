#' Convert a square overlap matrix to a tidy pairwise data frame
#'
#' Tidies a symmetric overlap (or distance) matrix into a
#' three-column tibble/data frame with pairs and values.
#'
#' @param mat Square numeric matrix (typically from [temp_overlap_matrix()]).
#'
#' @return A data frame with columns `item1`, `item2`, and `distance`
#'   (terminology follows [stats::as.dist()]).
#' @examples
#' d <- temp_overlap_matrix(ex1)
#' temp_overlap_df(d)
#' @export
#'
temp_overlap_df <- function(mat){
  d <- stats::as.dist(mat)
  broom::tidy(d)
}

