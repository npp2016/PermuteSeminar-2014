library(reshape2)
library(ggplot2)

## Seeing how Sam's melt works
desmids <- read.csv("Week-13/Svoboda_Supp.T2.csv")
desmids.m <- melt(desmids) ## Using Taxon as id variables
  head(desmids.m)
desmids.m <- cbind(desmids.m, 
                   colsplit(desmids.m$variable, "_", c("ecosystem", "sitepool")))

desmids.m$site <- substr(as.character(desmids.m$sitepool), 1, 1)
desmids.m$pool <- substr(as.character(desmids.m$sitepool), 3, 3)
desmids.m <- desmids.m[c("Taxon", "value", "ecosystem", "site", "pool")]

head(desmids.m)
write.csv(desmids.m, "Svoboda_supp_T2_longform.csv")
