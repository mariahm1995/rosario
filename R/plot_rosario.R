#' Diagram of ROSARIO null-model randomizations
#'
#' Visualizes the first 10 hypothetical time use distributions produced by
#' [rosario()] for a single biological identity. Each panel displays one
#' hypothetical time use distribution with its cyclic shift shown in dark gray
#' and its mirror image shown in dark red.
#'
#' @param numvec Numeric vector representing a single biological identity'
#'  distribution across ordered time intervals.
#' @param normalize Logical; if TRUE (default) scale each half to sum to 1
#'   (compare shapes, not totals).
#' @param cols Integer; number of panels (hypothetical distributions) per row.
#'
#' @return Invisibly, a list with:
#' \itemize{
#'   \item \code{variants} — the original list from \code{rosario(numvec)}
#'   \item \code{mat2k_plotted} — matrix of the plotted variants (min(10, n) × 2k)
#'   \item \code{k} — number of time bins
#'   \item \code{indices_plotted} — which variant indices (1..m) were drawn
#' }
#'
#' @examples
#' one <- c(0,5,0,7,5,13,70,0)
#' plot_rosario(one, cols = 4)
#'
#' @importFrom graphics par barplot axis box mtext
#'
#' @export
plot_rosario <- function(numvec, normalize = TRUE, cols = 4) {
  stopifnot(is.numeric(numvec), length(numvec) > 1)

  # Get all variants from rosario(); each element length = 2k = c(real, mirror)
  variants <- rosario(numvec)
  stopifnot(length(variants) >= 1L)

  # Keep only the first up to 10 variants (to avoid overly dense plots)
  m <- min(length(variants), 10L)
  variants_plot <- variants[seq_len(m)]

  # Bind into matrix: rows = variants, cols = 2k
  mat2k <- do.call(rbind, variants_plot)
  k <- length(numvec)
  stopifnot(ncol(mat2k) == 2 * k)

  # Optional normalization: scale each half separately to sum to 1
  if (normalize) {
    real_half   <- mat2k[, 1:k, drop = FALSE]
    mirror_half <- mat2k[, (k + 1):(2 * k), drop = FALSE]
    rs <- rowSums(real_half);   rs[rs == 0] <- 1
    ms <- rowSums(mirror_half); ms[ms == 0] <- 1
    mat2k[, 1:k]           <- real_half   / rs
    mat2k[, (k + 1):(2*k)] <- mirror_half / ms
  }

  # Colors (fixed): Real = dark gray, Mirror = dark red
  col_real   <- "#343a40"
  col_mirror <- "#9a031e"
  bar_cols   <- c(rep(col_real, k), rep(col_mirror, k))

  # X labels: 1..k for real, 1..k for mirror (all numbers shown)
  xlabs <- c(seq_len(k), seq_len(k))

  # Safe par handling
  old_par <- par(no.readonly = TRUE); on.exit(par(old_par), add = TRUE)

  n <- nrow(mat2k)
  ncol <- max(1L, as.integer(cols))
  nrow <- ceiling(n / ncol)
  par(mfrow = c(nrow, ncol),
      mar = c(3.5, 3.0, 1.5, 0.8),
      oma = c(2.5, 3.2, 2.2, 1.2))

  ymax <- max(mat2k, 0)

  # Draw each (capped) variant
  for (i in seq_len(n)) {
    v <- mat2k[i, ]
    barplot(v,
            col = bar_cols,
            border = NA,
            ylim = c(0, ymax * 1.05),
            names.arg = xlabs,
            cex.names = 0.7,
            axes = FALSE)
    axis(2, las = 1, cex.axis = 0.8)
    box(bty = "l")
  }

  # Outer axis labels
  mtext("Time interval", side = 1, outer = TRUE, line = 1.0)
  mtext(if (normalize) "Percentage of activity" else "Activity",
        side = 2, outer = TRUE, line = 1.6)

  invisible(list(
    variants = variants,
    mat2k_plotted = mat2k,
    k = k,
    indices_plotted = seq_len(m)
  ))
}
