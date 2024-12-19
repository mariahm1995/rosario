#' Convert a square tempral overlapping matrix to a pairwise distance dataframe
#'
#' @param mat A pairwise  square matrix of temporal niche overlapping of species
#'
#' @return A data.frame if the distance between species
#' @export
#'
#' @examples
#' d <- temp_overlap_matrix(ex1)
#' temp_overlap_df(d)
temp_overlap_df <- function(mat){
  d <- stats::as.dist(mat)
  broom::tidy(d)
}

