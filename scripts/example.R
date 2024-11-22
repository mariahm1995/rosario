source("scripts/rosario.R")
source("scripts/rosario_visualization.R")
source("scripts/czekanowski_index.R")
source("scripts/pianka_index.R")
source("scripts/temp_overlap.R")
source("scripts/temp_overlap_plot.R")

data <- read.csv("example.csv", row.names = 1)

rosario_model <- rosario(data)

rosario_visualization(rosario_model, row = 7)

results <- temp_overlap(data = data, method = "pianka", nsim = 1000)

temp_overlap_plot(results)

