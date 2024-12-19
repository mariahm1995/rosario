#' Czekanowski index for overlap in resource use between two species.
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
#' czekanowski_index(p, q)

czekanowski_index <- function(p, q){
  1 - 0.5*sum(abs(p - q))
}
