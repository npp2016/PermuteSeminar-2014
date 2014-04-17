# chloe's code week 11

data<-read.csv("C:/Users/HaeYeong/Documents/PermuteSeminar-2014/Week 11/epipalassemblages.csv")


?ordihull


  # get rid of the unnecessary colums and rows
data.mod<-data[,c(2:32)]
  # PCA
rownames(data.mod)<-data$Site
pca<-prcomp(data.mod,scale=T)
biplot(pca)
  
  # CCA
library(vegan)
a<-cca(data.mod)
biplot(a)

  # group types of artefacts into separate groups

