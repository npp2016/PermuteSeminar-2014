#Point Patterns in Seal Imagery - Ben Weinstein

require(maptools)
require(raster)
require(reshape)
require(ggplot2)

#Read in data
pts<-SpatialPoints(readShapePoints("Week 8/AVIA_shapefile/AVIAseals.shp"))

#view data
plot(pts)

#Create distance matrix
distP<-pointDistance(pts,longlat=TRUE)

#set diag to NA, no distance to itself
diag(distP)<-NA

hist(distP)

#min distance for each point
nearestN<-apply(distP,1,min,na.rm=TRUE)

#turn to raster
r<-raster(pts)
res(r)<-.0001
r<-rasterize(pts,r,fun="count")
plot(r)

polycord<-coordinates(pts)[chull(coordinates(pts)),]
library(sp)

p <- Polygon(rbind(polycord,polycord[1,]))
ps<- Polygons(list(p),1)
sps = SpatialPolygons(list(ps))

#raster polygon
polyR<-rasterize(x=sps,r)
plot(polyR)


randomD<-lapply(1:5,function(x){
  randomP<-sampleRandom(polyR,size=length(pts),sp=TRUE)
  
  #Create distance matrix
  
  distP<-pointDistance(randomP,longlat=TRUE)
  
  #set diag to NA, no distance to itself
  diag(distP)<-NA
  
  #min distance for each point
  nearestN<-apply(distP,1,min,na.rm=TRUE)
  
  return(nearestN)})

names(randomD)<-1:length(randomD)

#melt data

melt.dat<-melt(randomD)

ggplot(melt.dat,aes(x=value,fill=factor(L1)))  + geom_density(alpha=.9) + xlim(0,50) + geom_density(data=melt())
