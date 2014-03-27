library(spatstat)
library(maptools)
beginner ## getting help files for spatstat... 

## Avia Island seals
setwd("~/PermuteSeminar-2014/Week 8/AVIA shapefile/")
## read in data from shape file
av <- readShapePoints("AVIA seals.shp")

plot(av) ## plot all data
plot(av$Lat, av$Long) ## plot by lat/long
  lat <- av$Lat
  long <- av$Long

## Convex hull; get indicies of this
convex <- chull(lat, long)
plot(lat[convex], long[convex], type='l') ## plot lat/long WRT convex hull indices
points(lat, long) ## adds seals to the plot above so you can see where they are

## Calculate the G-stat using spatstat package
help(spatstat)

## will need lat/long as matrix
pts.matrix <- matrix(c(lat, long), ncol=2)

## finding the max/min of each lat/long point
min.lat<-min(lat)
min.long<-min(long)
max.lat<-max(lat)
max.long<-max(long)

#calculate G-statistic
pp <- as.ppp(pts.matrix, c(min.lat, max.lat, min.long, max.long))
g.stat<- Gest(pp)
## Check test output
g.stat 
plot(g.stat)

