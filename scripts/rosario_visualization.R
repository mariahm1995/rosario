#' rosario
#'
#' This function model pseudo-assemblages based on empirical temporal activity 
#' patterns of each species using the ROSARIO methodology (Castro-Arellano et al 2010)
#' 
#' @param numvec A numeric vector or matrix with activity pattern time series for 
#' each species
#'
#' @return A list with all the permutations in the time series
#' @export
#'
#' @examples rosario(c(40, 25, 18, 10, 5, 2))
#' 
#' 

rosario_visualization <- function(rosario_model, row){
  require(ggplot2)
  require(ggpubr)
  time_n <- length(rosario_model[[1]])

  interval_plot <- list()
  for (i in 1:time_n) {
    rosario_model[[row]][[i]]
    plot_data <- as.data.frame(t(rosario_model[[row]][[i]]))
    plot_data$names <- rownames(plot_data)
    set <- ggplot(data = plot_data, aes(y = set, x = names)) + 
      geom_bar(stat="identity") + theme_light() + 
      theme(axis.title = element_blank(), axis.text = element_blank())
    mirror <- ggplot(data = plot_data, aes(y = mirror, x = names)) + 
      geom_bar(stat="identity") + theme_light() + 
      theme(axis.title = element_blank(), axis.text = element_blank())
    interval_plot[[i]] <- ggarrange(set, mirror)
  }
  
  plot_summary <- ggarrange(plotlist = interval_plot, ncol = 1, nrow = length(interval_plot),
                            common.legend = TRUE)  
  
  annotate_figure(
    plot_summary,
    bottom = text_grob("Time intervals", size = 10),   # Common x-axis label
    left = text_grob("Frequency of occurrences", size = 10, rot = 90),
  )
  
}

