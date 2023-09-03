#' Assemblage-wide temporal niche segregation
#'
#' @param mat A matrix with species per time columns.
#' @param method A measure of temporal niche overlap between pairs of species
#'
#' @return A matrix with pairwise overlaping temporal resource use.
#' @export
#'
#' @examples
#' n = 200
#' k = 200
#' m = matrix(ifelse(runif(n*k) > 0.5, 1, 0), ncol = k)
#' temp_overlap(m, method = "pianka")
#' temp_overlap(m, method = "czekanowski")

temp_overlap <- function(mat, method = c("pianka", "czekanowski")) {

  method <- match.arg(method)


  res = matrix(0, nrow(mat), nrow(mat))

  if(is.null(method)){
    warning("No method provided. Pianka method by default")
    method = "pianka"
  }


  if(method == "pianka"){
    for (i in 1:(nrow(mat) - 1)) {
      for (j in (i+1):nrow(mat)) {
        d = pianka_index(mat[i,], mat[j,])
        res[j,i] = d
        res[i,j] = d
      }
    }

  }

  if(method == "czekanowski"){
    for (i in 1:(nrow(mat) - 1)) {
      for (j in (i+1):nrow(mat)) {
        d = czekanowski_index(mat[i,], mat[j,])
        res[j,i] = d
        res[i,j] = d
      }
    }

  }

  res
}
