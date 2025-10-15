#' Pianka's niche-overlap index
#'
#' Computes Pianka's symmetric index of overlap between two non-negative
#' activity profiles \eqn{p} and \eqn{q}:
#' \deqn{\frac{\sum_i p_i q_i}{\sqrt{\left(\sum_i p_i^2\right)\left(\sum_i q_i^2\right)}}.}
#'
#' @param p Numeric vector of non-negative values (counts or relative
#'   frequencies) for the first biological identity data 1 (e.g. activity,
#'   population size, etc) across ordered time bins.
#' @param q Numeric vector of non-negative values (same length as `p`) for the
#' second biological identity (e.g. activity, population size, etc)
#' across ordered time bins.
#'
#' @return A single numeric value in \[0, 1\]; larger values indicate greater
#'   overlap.
#' @details Pianka's index does not require inputs to sum to 1,
#' but both vectors must be non-negative and not all zero.
#' @examples
#' set.seed(1)
#' n <- 10
#' p <- rpois(n, 3); q <- rpois(n, 3)
#' pianka_index(p, q)
#' @export
#'
pianka_index <- function(p, q){
  #sum(p * q)/sqrt(sum(p^2 * q^2))
  sum_pq <- sum(p*q)
  sum_sqrt <- sqrt(sum(p^2)*sum(q^2))
  sum_pq/sum_sqrt
}
