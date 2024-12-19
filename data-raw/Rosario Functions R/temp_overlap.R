#' Assemblage-wide temporal niche segregation
#'
#' @param mat A matrix with species per time columns.
#' @param method A measure of temporal niche overlap between pairs of species
#'
#' @return A matrix with pairwise overlaping temporal resource use.
#' @export
#'
#' @examples
#' n = 5
#' k = 12
#' m = matrix(ifelse(runif(n*k) > 0.5, 1, 0), ncol = k)

#' temp_overlap_test(m, method = "pianka")
#'
#' m = t(apply(m, 1, function(x)x/sum(x)))
#' temp_overlap(Ex1, method = "pianka")
#'
#' #' m = t(apply(m, 1, function(x)x/sum(x)))
#' temp_overlap_test(m, method = "czekanowski")
#'

temp_overlap_test <- function(data, method, nsim) {
  require(gtools)


  if (!(mean(rowSums(data)) == 100 || mean(rowSums(data) == 1))) {
    stop("The sum of all rows should be 1 or 100")
  }

  if (mean(rowSums(data)) == 100 & method == "czekanowski") {
    data <- data/100
  }

  # rosario_model <- rosario(data)
  data <- ex1
  ide_no <- length(rosario_model)
  int_no <- ncol(data)
  obs_overlap <- as.data.frame(combinations(n = length(rownames(data)),
                                            r = 2, v = rownames(data)))
  obs_overlap$overlap_niche <- NA

  for (i in 1:nrow(obs_overlap)) {
    ind1 <- obs_overlap[i,1]
    ind2 <- obs_overlap[i,2]
    if (method == "pianka") {
      obs_overlap[which(obs_overlap[,1] == ind1 & obs_overlap[,2] == ind2), 3] <- pianka_index(data[which(rownames(data) == ind1), ],
                                                                                               data[which(rownames(data) == ind2), ] )
    }
    if (method == "czekanowski") {
      obs_overlap[which(obs_overlap[,1] == ind1 & obs_overlap[,2] == ind2), 3] <- czekanowski_index(data[which(rownames(data) == ind1),], data[which(rownames(data) == ind2),])
    }
  }
  niche_overlap_comm <- mean(obs_overlap[,3])
  colnames(obs_overlap)[1:2] <- c("identity1", "identity2")
  niche_overlap_pseudo_assem <- c()
  for (k in 1:nsim) {
    pseudo_assem <- as.data.frame(matrix(NA, nrow = ide_no, ncol = int_no))
    for (i in 1:ide_no) {
      random1 <- sample(c(1:ide_no), size = ide_no, replace = TRUE)
      random2 <- sample(c(1:int_no), size = ide_no, replace = TRUE)
      random3 <- sample(c(1:2), size = ide_no, replace = TRUE)
      pseudo_assem[i,] <- as.numeric(rosario_model[[random1[i]]][[random2[i]]][random3[i],])
    }

    null_overlap <- as.data.frame(combinations(n = length(rownames(pseudo_assem)),
                                               r = 2, v = rownames(pseudo_assem)))
    null_overlap$overlap_niche <- NA

    for (i in 1:nrow(null_overlap)) {
      ind1 <- null_overlap[i,1]
      ind2 <- null_overlap[i,2]

      if (method == "pianka") {
        null_overlap[which(null_overlap[,1] == ind1 & null_overlap[,2] == ind2), 3] <- pianka_index(pseudo_assem[which(rownames(pseudo_assem) == ind1),], pseudo_assem[which(rownames(pseudo_assem) == ind2),])      }
      if (method == "czekanowski") {
        null_overlap[which(null_overlap[,1] == ind1 & null_overlap[,2] == ind2), 3] <- czekanowski_index(pseudo_assem[which(rownames(pseudo_assem) == ind1),], pseudo_assem[which(rownames(pseudo_assem) == ind2),])
      }
    }
    niche_overlap_pseudo_assem[k] <- mean(null_overlap[,3])
  }
  p_value <- t.test(x = niche_overlap_pseudo_assem, mu = niche_overlap_comm)
  results <- list(obs_overlap, niche_overlap_comm, p_value, niche_overlap_pseudo_assem)
  names(results) <- c("niche_overlap_ide", "observed_niche_overlap", "p_value", "null_niche_overlap")
  return(results)
}

