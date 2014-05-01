library(reshape2)
library(ggplot2)

## Seeing how Sam's melt works
desmids <- read.csv("Week-13/Svoboda_Supp.T2.csv")
desmids.me <- melt(desmids) ## Using Taxon as id variables
  head(desmids.me)
desmids.me <- cbind(desmids.me, 
                   colsplit(desmids.me$variable, "_", c("ecosystem")))

desmids.me$site <- substr(as.character(desmids.me$sitepool), 1, 1)
desmids.me$pool <- substr(as.character(desmids.m$sitepool), 3, 3)
desmids.m <- desmids.m[c("Taxon", "value", "ecosystem", "site", "pool")]

head(desmids.m)
write.csv(desmids.m, "Svoboda_supp_T2_longform.csv")


library(vegan)
??anosim ## Analysis of Similarities
?? vegdist ## Dissimilarity Indices for Community Ecologists

## Using vegdist to calculate dissimilarity indicies
vegdist(x=desmids, method="bray", binary=FALSE, diag=FALSE, upper=FALSE, na.rm = FALSE) 

