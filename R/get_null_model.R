#' Niche overlap null model. Resampling through rosario algorithm
#' to preserve the temporal autocorrelation.
#'
#'
#' @param mat A matrix with species per time columns.
#' @param method A measure of temporal niche overlap between pairs of species
#' @param nsim The number of simulations
#' @param parallel Logical. Do the resampling on parallel

#'
#' @return A matrix with pairwise overlaping temporal resource use.
#' @export
#'
#' @examples
#' temp_overlap(ex1, method = "pianka")
#'
#' get_null_model(ex1, method = "pianka", nsim = 10, parallel = FALSE)
get_null_model <- function(mat, method, nsim = 100, parallel = FALSE) {

  if(method == "czekanowski"){
    mat <- rosario::rescale_matrix(mat)
  }

 niche_overlap_observed <- temp_overlap(mat, method)

 f <- function() rosario::temp_overlap(rosario::rosario_sample(mat), method)

  if(parallel){
    #res <- mcreplicate::mc_replicate(1000, f())
    future::plan(strategy = "multisession")
    res <- furrr::future_map_dfr(1:nsim, \(x) f(), .options = furrr::furrr_options(seed = TRUE))
    #res <- get(mat, envir = .GlobalEnv)
  } else {
    res <- purrr::map_dfr(1:nsim, \(x) f(), .progress = TRUE )

  }
  p_value <- stats::t.test(x = res[[1]], mu = niche_overlap_observed)
  results <- list(niche_overlap_observed, p_value, res)
  names(results) <- c("observed_niche_overlap", "p_value", "null_niche_overlap")
  return(results)
}

