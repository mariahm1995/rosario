#' Pairwise temporal niche-overlap matrix
#'
#' Computes all pairwise overlaps among rows (biological identities) using the chosen index.
#'
#' @param mat Numeric matrix (rows = biological identities, columns = ordered time intervals).
#' @param method Overlap index to use: `"pianka"` or `"czekanowski"`.
#'
#' @return A square symmetric matrix of overlap values with row/colnames copied
#'   from `mat`. The first class of the object is set to the method name.
#' @details For Czekanowski, supply a **row-rescaled** matrix (see
#'   [rescale_matrix()]) or use [temp_overlap()], which handles rescaling.
#' @examples
#' temp_overlap_matrix(ex1, method = "pianka")
#' ex1_rescale <- rescale_matrix(ex1)
#' temp_overlap_matrix(ex1_rescale, method = "czekanowski")
#' @seealso [temp_overlap()], [rescale_matrix()]
#' @export
#'
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
