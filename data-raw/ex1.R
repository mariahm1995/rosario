## code to prepare `ex1` dataset goes here

usethis::use_data(ex1, overwrite = TRUE)
ex1 <- read.csv("data-raw/rosario_sripts/Matrices/Ex1.csv", row.names=1, header= TRUE)
ex1 <- as.matrix(ex1)
use_data(ex1, overwrite = TRUE)
