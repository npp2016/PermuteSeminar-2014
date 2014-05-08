setwd("~/github_permute/PermuteSeminar-2014/Week-13")
library(vegan)

data<-read.csv("Svoboda_Supp.T2.csv", row.names=1)
data<-na.omit(data)
data<-data[,-1]
data<-t(data)
environment<-read.csv("Svoboda_T2_csv.csv")
environment$habitat<-0
environment$habitat[1:10]<-"swamp"
environment$habitat[11:20]<-"bog"
environment<-environment[-1,]
environment<-environment[-10,]

#between two sites
distance<-vegdist(data)
R<-anosim(distance, environment$habitat)
M<-(length(data$Taxon)*(length(data$Taxon)-1))/2

#between site of the bog

#between sites of teh swamps