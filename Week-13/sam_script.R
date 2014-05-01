library(reshape2)
library(ggplot2)

desmids <- read.csv("Svoboda_Supp.T2.csv")
head(desmids)
desmids.m <- melt(desmids)
head(desmids.m)
desmids.m <- cbind(desmids.m, 
                   colsplit(desmids.m$variable, "_", c("ecosystem", "sitepool")))

desmids.m$site <- substr(as.character(desmids.m$sitepool), 1, 1)
desmids.m$pool <- substr(as.character(desmids.m$sitepool), 3, 3)
desmids.m <- desmids.m[c("Taxon", "value", "ecosystem", "site", "pool")]

head(desmids.m)
write.csv(desmids.m, "Svoboda_supp_T2_longform.csv")
