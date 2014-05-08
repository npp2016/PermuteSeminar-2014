library(picante)
library(geiger)
library(vegan)


setwd("Week 14/")

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

d<-function(x){
  a<-commsimulator(newSp[1:10,],method="r00")
  b<-mpd(a,coScore)
  return(data.frame(Site=rownames(a),b))
  
}

out<-lapply(1:10,d)

names(out)<-1:10
m.out<-melt(out)

mat<-cast(m.out,Site~L1,value.var="value")

head(m.out)

require(ggplot2)
ggplot(m.out,aes(x=value,color=Site)) + geom_density() + facet_wrap(~Site)
