library(reshape2)
library(ggplot2)
library(plyr)
library(vegan)

desmids <- read.csv("Svoboda_Supp.T2.csv")
head(desmids)
desmids.m <- melt(desmids)
head(desmids.m)
gps <- read.csv("Svoboda_GPS.csv")
names(gps) <- c("variable", "lat", "lon")
desmids.m <- join(desmids.m, gps[c("variable", "lat", "lon")])

desmids.m <- cbind(desmids.m, 
                   colsplit(desmids.m$variable, "_", c("ecosystem", "sitepool")))

desmids.m$site <- substr(as.character(desmids.m$sitepool), 1, 1)
desmids.m$pool <- substr(as.character(desmids.m$sitepool), 3, 3)
desmids.m <- desmids.m[c("Taxon", "value", "ecosystem", "site", "pool", "lat", "lon")]

head(desmids.m)
write.csv(desmids.m, "Svoboda_supp_T2_longform.csv")

unique(desmids.m$Taxon)

desmids.t <- dcast(desmids.m, ecosystem + site + pool ~ Taxon)
desmids.dist <- dist(desmids.t[ , 3:98])
plot(hclust(desmids.dist))

ano.ecosystem <- anosim(desmids.dist, desmids.t$ecosystem)
ano.site <- anosim(desmids.dist, desmids.t$site)
ano.pool <- anosim(desmids.dist, desmids.t$pool)

summary(ano.ecosystem)
summary(ano.site)
summary(ano.pool)


desmid.adonis <- adonis(desmids.dist ~ ecosystem + site + pool, data=desmids.t)
summary(desmid.adonis)
plot(desmid.adonis)
