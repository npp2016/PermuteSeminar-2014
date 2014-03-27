#Point Patterns in Seal Imagery - Ben Weinstein
  
require(maptools)
require(raster)

#Read in data

pts<-SpatialPoints(readShapePoints("Week 8/AVIA_shapefile/AVIAseals.shp"))

#view data
plot(pts)

#Create distance matrix
 
distP<-pointDistance(pts,longlat=TRUE)


