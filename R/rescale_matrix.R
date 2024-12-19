#' Rescale matrix
#' This function  rescale the rows of a matrix dividing each element of a row over the sum of the row.
#' @param m A numeric matrix to rescale
#'
#' @return A rescaled matrix
#' @export
#'
#' @examples
#' ex1_rescale <- rescale_matrix(ex1)
rescale_matrix <- function(m){
  diag_m <- diag(1/rowSums(m))
  m_rescale <- diag_m %*% m
  colnames(m_rescale) <- colnames(m)
  rownames(m_rescale) <- rownames(m)
  m_rescale
}

