library(reshape2)
library(ggplot2)

## Trying again... uploading new data (tweaked in Excel)
desmids <-read.csv("Week-13/Spp by Swamp vs. NaCihadle.csv")
desmids[1]<-NULL
head(desmids)

library(vegan)
??anosim ## Analysis of Similarities
??vegdist ## Dissimilarity Indices for Community Ecologists

## Using vegdist to calculate dissimilarity indicies
desmids.t <- t(desmids) ##transpose desmid data
## Rename row/columns so they're numeric (for vegdist)
desmids.t[2,]<-1


desmid.dist<-vegdist(desmids.t)
vegdist(x=desmids, method="bray", binary=FALSE, diag=FALSE, upper=FALSE, na.rm = FALSE) 



data(dune)
data(dune.env)
dune.dist <- vegdist(dune)
attach(dune.env)
dune.ano <- anosim(dune.dist, Management)
summary(dune.ano)
plot(dune.ano)
