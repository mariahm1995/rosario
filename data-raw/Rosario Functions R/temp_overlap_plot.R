temp_overlap_plot <- function(results) {
  require(ggplot2)
  
  data_plot <- as.data.frame(results$null_niche_overlap)
  colnames(data_plot) <- c("values")
  
  plot <- ggplot(data_plot, aes(x = values)) + geom_histogram(fill="#f2f2f2", color="#595959") +
    geom_vline(aes(xintercept = results$observed_niche_overlap),
               color="#ae2012", linetype="dashed") + theme_light() +
    labs(x = "Niche overlap", y = "Number of pseudo-assamblages")
  return(plot)
}
