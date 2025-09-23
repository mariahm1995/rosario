#' Example temporal activity dataset
#'
#' An example dataset of 5 biological identities across 12 time intervals. Values
#' represent counts of activity events (e.g., detections or captures) per
#' interval. This dataset is provided for examples and vignettes.
#'
#' @format A numeric matrix with 5 rows (biological identities) and 12 columns
#'   (time intervals):
#' \describe{
#'   \item{Rows}{Biological identities (`bioID1` … `bioID5`)}
#'   \item{Columns}{Time intervals (`INT1` … `INT12`)}
#'   \item{Values}{Counts of activity per identity × interval}
#' }
#' @examples
#' ex1
#' rowSums(ex1)   # total activity per biological identity
#' colSums(ex1)   # total activity per time interval
"ex1"
