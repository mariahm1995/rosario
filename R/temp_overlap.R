#' Mean concurrent temporal niche overlap
#'
#' Computes the **mean** of all pairwise overlaps among rows (biological
#' identities) using the chosen index.
#'
#' @param mat Numeric matrix (rows = biological identities, columns = ordered time intervals).
#' @param method Overlap index to use: `"pianka"` or `"czekanowski"`.
#'
#' @return A single numeric value (named by the method) equal to the mean of
#'   the lower triangle of the pairwise overlap matrix.
#' @details For `"czekanowski"`, rows are automatically rescaled to proportions.
#' @examples
#' temp_overlap(ex1, method = "pianka")
#' temp_overlap(rescale_matrix(ex1), method = "czekanowski")
#' @seealso [temp_overlap_matrix()], [get_null_model()]
#' @export
#'
temp_overlap <- function(mat, method = c("pianka", "czekanowski")) {


  if(is.data.frame(mat)){
    mat <- as.matrix(mat)
  }

  flag <- Map(is.numeric, mat ) |> unlist() |> all()
  if(!flag){
    stop("The input matrix is not numeric")
  }

  method <- match.arg(method)
  if(method == "czekanowski"){
    mat <- rescale_matrix(mat)
  }

  mat <- temp_overlap_matrix(mat, method = method)

  df <- temp_overlap_df(mat)
  index <- mean(df[["distance"]], na.rm = TRUE)
  names(index) <- class(mat)[1]
  index
}
