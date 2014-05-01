#observed r in different ranks; shuffle and then recalcualte.

#first need to do a bray-curtis
#0,1 data will default to bray-cutis
#input the data:
data<-read.csv("/Users/rebeccakulp/Documents/Classes/2014/Stats II/PermuteSeminar-2014/Week-13/Svoboda_supp_T2_longform.csv",head=T)


swamp<-subset(data,data$ecosystem%in%c("Swamp"))
swamp$ecosystem<-factor(swamp$ecosystem)
swamp<-swamp[,c(2,3,5,6)]

#need to first get the data in the right form, where will have the pools on the 
#column and the species on the top, so then the bradely-curtis similarilty
#will be between everything
library(reshape)
swamp.matrix<-melt(swamp,id=c("site","pool","Taxon"))
#do not use the melt function first!  did not put it in the right function
#row by column; row~column
matrix<-cast(swamp,site+pool~Taxon)
dcast(swamp,site+pool~Taxon)
#made separate column to group the variables-take the two and past it together site pool
#function is anosim function-need to get this in for the right format

?anosim
anosim(dat=swamp,grouping=pool)
library(vegan)
#we are comparing the pools of the bog
#to use the vegdist need to get it in a format for the community data matrix
vegdist