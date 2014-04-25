setwd("~/github_permute/PermuteSeminar-2014/Week 11")

data<-read.csv("epipalassemblages.csv", row.names=1)

my.prc<-prcomp(data[1:31], scale. = T)
ggbiplot(my.prc)