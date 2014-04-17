epipal <- read.csv("epipalassemblages.csv")
names(epipal)
epipalnums <- epipal[,-c(1,33,34,35)]
epipca <- prcomp(epipalnums, scale = T)
biplot(epipca)
library(vegan)
NMDSepipal <- metaMDS(epipalnums, distance = "bray", trace = 1)
plot(NMDSepipal)
epipalcca <- cca(epipalnums~epipal$Period)
epipalcca
##Trying out kmeans to find the groups? Try 2 based on the plots
epipalgroups <- kmeans(epipalnums, 3)
epipalgroups
#Using 3 groups there's a vector of the clusters
clustergroups <- c(2,1,1,1,3,3,3,3,2,1,1,3,3,3,3,3,3)
groupings <- data.frame(epipal, clustergroups)
groupings
#These groupings don't seem to be related to the Period or Region groups. Curious.