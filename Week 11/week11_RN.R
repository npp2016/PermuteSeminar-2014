data <- read.csv("epipalassemblages.csv", row.names = 1)
head (data)
install.packages("devtools")

require (devtools)

install_github("ggbiplot","vqv" )
library ("vegan")
require (ggbiplot)
require (vqv)

pcs <- prcomp(data[,1:31], scale = T)

ggbiplot(pcs)