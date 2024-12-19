#' Assemblage-wide temporal niche segregation
#'
#' @param mat A matrix with species per time columns.
#' @param method A measure of temporal niche overlap between pairs of species
#'
#' @return The mean temporal overlaping index from a pairwise distance matrix
#' @export
#'
#' @examples
#' temp_overlap(ex1, method = "pianka")
#' ex1_rescale <- rescale_matrix(ex1)
#' temp_overlap(ex1_rescale, method = "czekanowski")

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
