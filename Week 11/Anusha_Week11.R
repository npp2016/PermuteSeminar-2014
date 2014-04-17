require(vegan)
require(devtools)
require(ggbiplot)
## installed "ggbiplot", "vqv"

setwd("C:\\Users\\Anusha\\Documents\\GitHub\\PermuteSeminar-2014\\Week 11")

paleodata <- read.csv("epipalassemblages.csv", row.names=1)

pca.paleo <- prcomp(paleodata[,1:31])

ggbiplot(pca.paleo,labels=rownames(paleodata)) + theme_bw()
