library(picante)
library(ape)
library(geiger)
setwd("~/github_permute/PermuteSeminar-2014/Week 14")

#read in the tree
tree<-read.tree("newtree.tre")
#hist(dist)

data<-read.csv("SiteXspp.csv", row.names = 1)
#transpose
t.data<-t(data)


tree<-treedata(tree,t.data,sort=T,warnings=T)$phy
t.data<-treedata(tree,t.data,sort=T,warnings=T)$data
data<-t(t.data)

#check the tree and the data
colnames(tree)%in%tree$tip.label

dist<-cophenetic(tree)

#calculate the mean pairwise distance
mean.phy.dist<-mpd(data, dist)

permute<-commsimulator(data, mean.phy.dist, method= "r00")


