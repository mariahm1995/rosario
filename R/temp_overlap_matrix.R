#' Assemblage-wide temporal niche segregation
#'
#' @param mat A matrix with species per time columns.
#' @param method A measure of temporal niche overlap between pairs of species
#'
#' @return A matrix with pairwise overlaping temporal resource use.
#' @export
#'
#' @examples
#' temp_overlap_matrix(ex1, method = "pianka")
#' ex1_rescale <- rescale_matrix(ex1)
#' temp_overlap_matrix(ex1_rescale, method = "czekanowski")

temp_overlap_matrix <- function(mat, method = c("pianka", "czekanowski")) {


  if(is.data.frame(mat)){
    mat <- as.matrix(mat)
  }

  flag <- Map(is.numeric, mat ) |> unlist() |> all()
  if(!flag){
    stop("The input matrix is not numeric")
  }

  method <- match.arg(method)

  res = matrix(0, nrow(mat), nrow(mat))

  if(is.null(method)){
    warning("No method provided. Pianka method by default")
    method = "pianka"
  }


  if(method == "pianka"){
    for (i in 1:(nrow(mat) - 1)) {
      for (j in (i + 1):nrow(mat)) {
        d = pianka_index(p = mat[i, ], q =  mat[j, ])
        res[i,j] = d
        res[j,i] = d
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

  colnames(res) <- rownames(res) <- rownames(mat)
  class(res) <- c(method, class(mat) )
  res
}
