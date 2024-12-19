getwd()
#setwd("~/Desktop/Matrix")
source("data-raw/Rosario Functions R/rosario.R")
source("data-raw/Rosario Functions R/czekanowski_index.R")
source("data-raw/Rosario Functions R/pianka_index.R")
source("data-raw/Rosario Functions R/rosario_visualization.R")
source("data-raw/Rosario Functions R/temp_overlap.R")
source("data-raw/Rosario Functions R/temp_overlap_plot.R")

#Example with Dr. Castro Matrix Cronocoincident 1
ex1 <- read.csv("data-raw/rosario_sripts/Matrices/Ex1.csv", row.names=1, header= TRUE)
head(ex1)
install.packages("gtools")
temp_overlap_test(data=Ex1, method = "pianka", nsim = 1000)

randomEx1 <- rosario(Ex1)
randomEx1$spp1[[1]]

rosario_visualization(randomEx1, 1)
resultsEx1 <- temp_overlap(data=Ex1, method = "pianka", nsim = 1000)
resultsEx1
temp_overlap_plot(resultsEx1)

data <- read.csv("data-raw/rosario_sripts/Matrices/Random_h12_3.csv", row.names=1, header= TRUE)
head(data)
randomh12_3 <- rosario(data)

length(randomh12_3$Sp1)
rosario_visualization(randomh12_3 , 3)
results <- temp_overlap(data=data, method = "pianka", nsim = 10)
results
temp_overlap_plot(results)

#####Random highly specialized
### matrix 24*96
Ex24.96<-read.csv("ex24-96.csv", row.names=1, header= TRUE)
head(Ex24.96)
randomEx24.96<-rosario(Ex24.96)
rosario_visualization(randomEx24.96,20)
resultsEx24.96<-temp_overlap(data=Ex24.96, method = "pianka", nsim = 1000)
resultsEx24.96
temp_overlap_plot(resultsEx24.96)

###Example with  matrix 12*96
Ex12.96<-read.csv("ex12-96.csv", row.names=1, header= TRUE)
head(Ex12.96)
randomEx12.96<-rosario(Ex12.96)
rosario_visualization(randomEx12.96,11)
resultsEx12.96<-temp_overlap(data=Ex12.96, method = "pianka", nsim = 10000)
resultsEx12.96
temp_overlap_plot(resultsEx12.96)

###Example with  matrix 6*288 random highly specialized
Ex6.288<-read.csv("ex6-288.csv", row.names=1, header= TRUE)
head(Ex6.288)
randomEx6.288<-rosario(Ex6.288)
rosario_visualization(randomEx6.288,11)
resultsEx6.288<-temp_overlap(data=Ex6.288, method = "czekanowski", nsim = 10000)
resultsEx6.288
temp_overlap_plot(resultsEx6.288)

###Example with  matrix 3*288 random highly specialized
Ex3.288<-read.csv("ex3-288.csv", row.names=1, header= TRUE)
head(Ex3.288)
randomEx3.288<-rosario(Ex3.288)
rosario_visualization(randomEx3.288,10)
resultsEx3.288<-temp_overlap(data=Ex3.288, method = "czekanowski", nsim = 10000)
resultsEx3.288
temp_overlap_plot(resultsEx3.288)

####Moderate
###Example with largest matrix 24*96 random highly specialized
Ex24.96<-read.csv("ex24-96.csv", row.names=1, header= TRUE)
head(Example)
randomExample<-rosario(Example)
rosario_visualization(randomExample,20)
resultsExample<-temp_overlap(data=Example, method = "pianka", nsim = 100)
resultsExample
temp_overlap_plot(resultsExample)

###Example with  matrix 12*288 random highly specialized
Ex12.288<-read.csv("ex12-288.csv", row.names=1, header= TRUE)
head(Ex12.288)
randomEx12.288<-rosario(Ex12.288)
rosario_visualization(randomEx12.288,11)
resultsEx12.288<-temp_overlap(data=Ex12.288, method = "pianka", nsim = 10000)
resultsEx12.288
temp_overlap_plot(resultsEx12.288)

###Example with  matrix 6*288 random highly specialized
Ex6.288<-read.csv("ex6-288.csv", row.names=1, header= TRUE)
head(Ex6.288)
randomEx6.288<-rosario(Ex6.288)
rosario_visualization(randomEx6.288,11)
resultsEx6.288<-temp_overlap(data=Ex6.288, method = "czekanowski", nsim = 10000)
resultsEx6.288
temp_overlap_plot(resultsEx6.288)

###Example with  matrix 3*288 random highly specialized
Ex3.288<-read.csv("ex3-288.csv", row.names=1, header= TRUE)
head(Ex3.288)
randomEx3.288<-rosario(Ex3.288)
rosario_visualization(randomEx3.288,10)
resultsEx3.288<-temp_overlap(data=Ex3.288, method = "czekanowski", nsim = 10000)
resultsEx3.288
temp_overlap_plot(resultsEx3.288)



