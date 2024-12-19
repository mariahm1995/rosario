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

#Add error for rows where the sum is not 100%

rosario <- function(data){
  require(dplyr)
  
  ide_no <- nrow(data)
  time_n <- ncol(data)
  
  act_patterns <- list()
  
  for (j in 1:ide_no) {
    intervals <- list()
    for (x in 1:time_n) {
      
      models <- as.data.frame(matrix(NA, ncol = time_n, nrow = 2))
      row.names(models) <- c("set","mirror")
      
      module_logic <- as.logical((1:time_n %/% x))
      module_sequence <- c(which(module_logic), which(!module_logic))
      models[1,] <- as.numeric(data[j,][module_sequence])
      models[2,] <- rev(as.numeric(data[j,][module_sequence]))
    
      intervals[[x]] <- models
    }
    intervals_rearrenge <- list()
    intervals_rearrenge[[1]] <- intervals[[1]]
    temp_intervals <- rev(intervals[c(2:time_n)])
    
    for (k in 1:length(temp_intervals)) {
      intervals_rearrenge[[k+1]] <-  temp_intervals[[k]]
    }
    act_patterns[[j]] <- intervals_rearrenge
  }
  names(act_patterns) <- rownames(data)
  return(act_patterns)
}


