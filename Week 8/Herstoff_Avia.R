library(spatstat)
library(maptools)
beginner

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
pt.ppp <- as.ppp(pts.matrix, pt.matrix$window(3587))
g.stat<- Gest(pt.ppp, )


