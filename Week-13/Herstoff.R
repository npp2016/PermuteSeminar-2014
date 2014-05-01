library(reshape2)
library(ggplot2)
library(vegan)
## Trying again... uploading new data (tweaked in Excel)
desmids <-read.csv("Week-13/Spp by Swamp vs. NaCihadle.csv")
  desmids[1]<-NULL
  desmids[1]<-NULL ## removing col 1 and 2 (words) so only numbers (for vegdist)
    head(desmids)
des.dist <-vegdist(desmids, binary=T)

###########################################################################

#between two sites
distance<-vegdist(data, binary = TRUE)
attach(environment)
R<-anosim(distance, environment$habitat)
M<-(length(data$Taxon)*(length(data$Taxon)-1))/2

#between site of the bog

#between sites of teh swamps


###########################################################################

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
