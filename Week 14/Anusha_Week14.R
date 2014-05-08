library(picante)


setwd("C://Users//Anusha//Documents//GitHub//PermuteSeminar-2014//Week 14/")

Tree <- read.tree(file="hum294.tre")

## Calculate cophenetic scores- measures of relatedness
cophenScore <- cophenetic(Tree)
histCophen <- hist(cophenScore)

splitted <- (strsplit(Tree$tip.label, "\\."))

splitted[]
