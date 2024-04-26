#' rosario
#'
#' @param numvec A numeric vector with activity pattern time series
#'
#' @return A list with all the permutations in the time series
#' @export
#'
#' @examples rosario(c(40, 25, 18, 10, 5, 2))
rosario <- function(numvec){
  vecLength <- length(numvec)
  veclist <- purrr::map(vecLength:2, function(x){
    module_logic <- as.logical((1:vecLength %/% x) )
    module_sequence <- c(which(module_logic), which(!module_logic))
    numvec[ module_sequence ]
  })
  c(list(numvec), veclist) %>%
    purrr::map(function(x) c(x, rev(x)))
}
