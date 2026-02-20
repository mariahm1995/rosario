#' Null-model test via ROSARIO algorithm randomization
#'
#' Generates a null distribution of concurrent temporal niche overlap by
#' repeatedly randomizing the input matrix with [rosario_sample()] and
#' recomputing the mean pairwise overlap (see [temp_overlap()]).
#'
#' @param mat Numeric matrix (rows = biological identities, columns = ordered time intervals).
#'  Time intervals are assumed to be circular (e.g., hours of the day, months of the year),
#'  so the last interval is treated as adjacent to the first. Biological identities can be
#'  individuals, populations, species or communities.
#'
#' @param method Character string naming the overlap index to use:
#'   `"pianka"` or `"czekanowski"`.
#' @param nsim Integer number of randomizations to run (default `100`).
#' @param parallel Logical. If `TRUE`, randomizations are executed in parallel
#'   using [furrr::future_map_dfr()] with a `multisession` plan set internally.
#'
#' @return A list with components:
#' \describe{
#'   \item{observed_niche_overlap}{Mean from all possible pairwise comparisons among biological identities for `mat`.}
#'   \item{p_value}{A one-sample `t.test` object comparing null means to the
#'     observed value (mu = observed).}
#'   \item{null_niche_overlap}{A tibble/data.frame of simulated mean overlaps
#'     (one per randomization).}
#' }
#' @details For `"czekanowski"`, rows are rescaled to proportions internally to
#'   satisfy the index's assumptions. Randomization preserves each row's
#'   temporal autocorrelation by cyclically shifting (and optionally mirroring)
#'   its profile; see [rosario_sample()].
#'
#'   When `parallel = TRUE`, the function calls `future::plan(multisession)`
#'   internally so that randomizations are distributed across available local
#'   sessions. This means the function overrides any previously set `future` plan.
#'   If you need custom control over parallelization (e.g. cluster backends),
#'   run the non-parallel mode (`parallel = FALSE`) and handle parallelism
#'   externally.
#' @examples
#' get_null_model(ex1, method = "pianka", nsim = 10, parallel = FALSE)
#' @seealso [temp_overlap()], [rosario_sample()], [temp_overlap_matrix()]
#'
#' @importFrom furrr future_map_dfr furrr_options
#' @importFrom future plan multisession
#'
#' @export
get_null_model <- function(mat, method, nsim = 100, parallel = FALSE) {

  if(method == "czekanowski"){
    mat <- rosario::rescale_matrix(mat)
  }

 niche_overlap_observed <- temp_overlap(mat, method)

 f <- function() rosario::temp_overlap(rosario::rosario_sample(mat), method)

  if(parallel){
    future::plan(strategy = "multisession")
    res <- furrr::future_map_dfr(1:nsim, \(x) f(), .options = furrr::furrr_options(seed = TRUE))
  } else {
    res <- purrr::map_dfr(1:nsim, \(x) f(), .progress = TRUE )

  }
  p_value <- stats::t.test(x = res[[1]], mu = niche_overlap_observed)
  results <- list(niche_overlap_observed, p_value, res)
  names(results) <- c("observed_niche_overlap", "p_value", "null_niche_overlap")
  return(results)
}

