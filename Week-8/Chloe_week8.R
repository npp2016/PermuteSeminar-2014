# Chloe- week8
# package 'spatstat' 
# package 'shapefiles'
# using Avian Island shapefile

setwd("C:/Users/HaeYeong/Documents/PermuteSeminar-2014/Week-8/AVIA shapefile")

library(shapefiles)
avia.dbf<-read.dbf("AVIA seals.dbf")
avia.shp<-read.shp("AVIA seals.shp")
avia.shx<-read.shx("AVIA seals.shx")

avia.dbf.lat.long<-avia.dbf$dbf[,2:3]
plot(avia.dbf.lat.long)

# need to convert to ppp format
ww<-c(min(avia.dbf$dbf$Lat),max(avia.dbf$dbf$Lat),min(avia.dbf$dbf$Long),max(avia.dbf$dbf$Long))
avia.ppp<-as.ppp(X=avia.dbf.lat.long,W=ww)

KK<-Kest(avia.ppp)
plot(KK)

# function 'chull'
# read in data using the text file
setwd("C:/Users/HaeYeong/Documents/PermuteSeminar-2014/Week-8")
paulet<-read.csv("paulet_island1.csv")

plot(paulet)

# calculate K function
library(spatstat)

# need to convert to ppp format
w<-c(min(paulet$lat),max(paulet$lat),min(paulet$long),max(paulet$long))
paulet.ppp<-as.ppp(X=paulet,W=w)

K<-Kest(paulet.ppp)
plot(K)

# plot AVIA and Paulet together
par(mfrow=c(1,2))
plot(K)
plot(KK)

# reduce window (subsample) and compute K again
w1<-c(-63.576,-63.572,min(paulet$long),-55.780)
paulet.ppp2<-as.ppp(X=paulet,W=w1)

K2<-Kest(paulet.ppp2)
plot(K2)


# function 'nndist' calculates the distance between the nearest neigbor

# test whether the difference is significant
E <- envelope(Y=paulet.ppp, fun=Kest, nsim = 39)
