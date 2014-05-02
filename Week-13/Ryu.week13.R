# Chloe - week 13

setwd("C:/Users/haeyeong86/Documents/PermuteSeminar-2014/Week-13")
data<-read.csv("Svoboda_T2_csv.csv")
data

data1<-read.csv("Svoboda_Supp.T2.csv")
rownames(data1)<-data1[,1]
data1<-data1[,-c(1)]
head(data1)
  # transpose rows and colums
  # this is to have sites in rows and species in colums
data1<-t(data1)

data2<-read.csv("Svoboda_supp_T2_longform.csv")
head(data2)

gps.data<-read.csv("Svoboda_GPS.csv")
gps.data


# pca
pca.data1<-prcomp(data1, scale=T)
biplot(pca.data1)
plot(pca.data1)
summary(pca.data1)

# cca
cca.data1<-cca(data1)
cca.data1
plot(cca.data1)
summary(cca.data1)

  # NMDS
library(vegan)
nmds.data1 <- metaMDS(data1, distance = "bray", trymax = 20, trace = 1)
nmds.data1
  # plot sites
plot(nmds.data1, type = "n")
text(nmds.data1, display = "sites", cex = 0.7)
  # plot species
plot(nmds.data1, type = "n")
text(nmds.data1, display = "species", cex = 0.7)

  # overlay the two plots on top of one another
plot(nmds.data1)
ordilabel(nmds.data1, display = "sites", font = 3, col = "black")
#ordilabel(nmds.data1, display = "species", font = 2, col = "red")

  # ANOSIM
library(vegan)

# make a dataframe for just the groupings of swamps
data1.grp <- matrix(nrow=18, ncol=3)
data1.grp[,1]<-c(rep(1,9),rep(2,9))
data1.grp[,2]<-rep(c(1,1,1,2,2,2,3,3,3),2)
data1.grp[,3]<-rep(c(1,2,3),3)
colnames(data1.grp)<-c("habitat", "site", "pool")
data1.grp

# test differences between habitat (swamp vs. NaCihadle)
anosim(data1, data1.grp[,1], permutations = 999, distance = "bray")
# Result
# R=0.7491 at the sig leve of 0.001 
# Habiats are significantly different!

# test differences between sites within the habitat, swamp
anosim(data1[c(1:9),], data1.grp[,2], permutations = 999, distance = "bray")
# Result
# R=0.9177 at the sig level of 0.005 
# Sites within swamp are significantly different!

# test differences between sites within the habitat, NaCihadle
anosim(data1[c(10:18),], data1.grp[,2], permutations = 999, distance = "bray")
# Result
# R=0.3704 at the sig level of 0.037 
# Sites within NaCihadle are significantly different!

# test differences between pools within the habitat, swamps
anosim(data1[c(1:9),], data1.grp[,3], permutations = 999, distance = "bray")
# Result
# R=-0.3045 at the sig level of 0.934 
# pools within swamp sites are not significantly different!

# test differences between pools within the habitat, NaCihadle
anosim(data1[c(10:18),], data1.grp[,3], permutations = 999, distance = "bray")
# Result
# R=0.1317 at the sig level of 0.255 
# pools within NaCihadle are not significantly different!