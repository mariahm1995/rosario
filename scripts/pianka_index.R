#' Pianka's index
#'
#' @param p A vector of relative frequence of activity pattern.
#' @param q A vector of relative frequence of activity pattern.
#'
#' @return An index value of overlap resource use.
#' @export
#'
#' @examples
#' n = 100
#' p = ifelse(runif(n) > 0.5, 1, 0)
#' q = ifelse(runif(n) > 0.5, 1, 0)
#' pianka_index(p, q)

pianka_index <- function(p, q){
  sum(p*q)/sqrt(sum(p^2)*sum(q^2))
}

