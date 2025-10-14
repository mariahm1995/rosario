#' Plot null-model results for temporal niche overlap
#'
#' Creates a histogram of simulated mean niche overlap values from a null model
#' (see [get_null_model()]) and overlays a dashed vertical line indicating the
#' observed mean overlap.
#'
#' @param results A list object returned by [get_null_model()], containing
#'   `null_niche_overlap` (data frame of simulated overlaps) and
#'   `observed_niche_overlap` (numeric observed value).
#'
#' @return A `ggplot2` object displaying the null distribution of overlap values
#'   with the observed overlap marked.
#'
#' @seealso [get_null_model()], [temp_overlap()]
#'
#' @examples
#' mod <- get_null_model(ex1, method = "pianka", nsim = 100)
#' temp_overlap_plot(mod)
#'
#' @importFrom rlang .data
#' @export
temp_overlap_plot <- function(results) {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required for plotting. Please install it.", call. = FALSE)
  }

  # validate structure
  if (!all(c("null_niche_overlap", "observed_niche_overlap") %in% names(results))) {
    stop("`results` must be the list returned by get_null_model().", call. = FALSE)
  }

  data_plot <- as.data.frame(results$null_niche_overlap)
  names(data_plot) <- "values"

  ggplot2::ggplot(data_plot, ggplot2::aes(x = .data$values)) +
    ggplot2::geom_histogram(fill = "#f2f2f2", color = "#595959") +
    ggplot2::geom_vline(xintercept = results$observed_niche_overlap,
                        color = "#ae2012", linetype = "dashed") +
    ggplot2::theme_light() +
    ggplot2::labs(x = "Simulated overlap values", y = "Frecuencies")
}
