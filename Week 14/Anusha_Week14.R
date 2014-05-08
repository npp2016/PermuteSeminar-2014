library(picante)


setwd("C://Users//Anusha//Documents//GitHub//PermuteSeminar-2014//Week 14/")

Tree <- read.tree(file="hum294.tre")
siteSp <- read.csv("SiteXspp.csv")

## Calculate cophenetic scores- measures of relatedness
coScore <- cophenetic(Tree)
histCophen <- hist(coScore)

splitted <- strsplit(Tree$tip.label, "\\.")
splitTips <- sapply(splitted, function(x){paste(x[1:2], collapse =".")})
Tree$tip.label <- splitTips

mpd(siteSp, coScore)
