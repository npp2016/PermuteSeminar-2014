library(reshape2)
library(ggplot2)
library(vegan)

###########################################################################

## Trying again... uploading new data (tweaked in Excel)
desmids <-read.csv("Week-13/Spp by Swamp vs. NaCihadle.csv")
  desmids[1]<-NULL
  desmids[1]<-NULL ## removing col 1 and 2 (words) so only numbers (for vegdist)
    head(desmids)
des.dist <-vegdist(desmids, binary=F)

###########################################################################

## Pirated from Laurel- trying to to see how stuff works.

setwd("/Users/emilypetchler/Documents/GitHub/PermuteSeminar-2014.test/Week-13/")

data<-read.csv("Svoboda_Supp.T2.csv") ## Data from supp figure on species
  data<-na.omit(data)
  data<-data[,-1] ## get rid of species names
  data<-t(data)   ## transpose the data.

environment<-read.csv("Svoboda_T2_csv.csv", row.names=1) ## abiotic conditions
  environment$habitat<-0
  environment$habitat[1:10]<-"swamp"
  environment$habitat[11:20]<-"bog"
environment<-environment[-1,]
environment<-environment[-10,]

#between two sites
distance<-vegdist(data, binary = TRUE)
attach(environment)
R<-anosim(distance, environment$habitat)
M<-(length(data$Taxon)*(length(data$Taxon)-1))/2

#between site of the bog

#between sites of teh swamps

