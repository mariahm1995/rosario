#' Czekanowski overlap index
#'
#' Computes the Czekanowski index of overlap between two relative-frequency
#' activity profiles \eqn{p} and \eqn{q}:
#' \deqn{1 - \tfrac{1}{2}\sum_i |p_i - q_i|.}
#'
#' @param p Numeric vector of non-negative relative frequencies (typically
#'   sums to 1) describing the first biological identity data (e.g. activity,
#'   population size, etc) across ordered time bins. Standardized use of time
#'   intervals through the manual.
#' @param q Numeric vector of non-negative relative frequencies (same length
#'   as `p`) for the second biological identity across ordered time bins.
#'
#' @return A single numeric value in \[0, 1\] where 0 indicates no overlap and
#'   1 indicates identical profiles.
#' @details Inputs should be on a *comparable scale*; if your data are raw
#'   counts, rescale rows to proportions first (see [rescale_matrix()]).
#' @examples
#' set.seed(1)
#' n <- 6
#' p <- rmultinom(1, 20, rep(1, n))[,1]; p <- p / sum(p)
#' q <- rmultinom(1, 20, rep(1, n))[,1]; q <- q / sum(q)
#' czekanowski_index(p, q)
#' @export
#'
czekanowski_index <- function(p, q){
  1 - 0.5*sum(abs(p - q))
}
