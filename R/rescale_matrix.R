#' Row-wise rescaling of a matrix to relative frequencies
#'
#' Divides each row by its row sum so that every row sums to 1 (leaving
#' dimnames intact).
#'
#' @param m Numeric matrix; rows are biological identities, columns are time
#'  bins (i.e., time resources).
#'
#' @return A numeric matrix of the same dimension with each row summing to 1.
#'   Rows with a zero sum are left unchanged (resulting in `NaN` if present).
#' @examples
#' ex1_rescale <- rescale_matrix(ex1)
#' rowSums(ex1_rescale)
#' @export
#'
rescale_matrix <- function(m){
  diag_m <- diag(1/rowSums(m))
  m_rescale <- diag_m %*% m
  colnames(m_rescale) <- colnames(m)
  rownames(m_rescale) <- rownames(m)
  m_rescale
}

