library(picante)
library(geiger)
library(vegan)


setwd("C://Users//Anusha//Documents//GitHub//PermuteSeminar-2014//Week 14/")

Tree <- read.tree(file="hum294.tre")
siteSp <- read.csv("SiteXspp.csv", row.names=1)

## Renaming tip names to remove the last numbers in the tip names
splitted <- strsplit(Tree$tip.label, "\\.")
splitTips <- sapply(splitted, function(x){paste(x[1:2], collapse =".")})
Tree$tip.label <- splitTips
## pruneTree <- prune.sample(siteSp, Tree)

## Trying to prune site by spp matrix siteSp[,colnames(siteSp) %in% tree$tip.label]

# transposed sitexspp matrix
spp <- t(siteSp)
newTree <- treedata(Tree, spp, sort=T, warnings=T)$phy
newSp <- treedata(Tree, spp, sort=T, warnings=T)$data
newSp <- t(newSp)

## Calculate cophenetic scores- measures of relatedness
coScore <- cophenetic(newTree)
histCophen <- hist(coScore)

## Calculating mean pairwise distance
phyDist <- mpd(newSp, coScore)


