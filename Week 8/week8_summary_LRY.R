setwd("~/github_permute/PermuteSeminar-2014/Paulet Island")

#read in the shape file 
pts<-readShapePoints("AVIA seals.shp")

lat<-pts$Lat
long<-pts$Long

#get the indices of lat long on the convex hull
convex<-chull(lat, long)
plot(lat[convex], long[convex])
plot(lat[convex], long[convex], type = "l")
#see the coordinates on the graph
points(lat, long)



min.lat<-min(lat)
min.long<-min(long)
max.lat<-max(lat)
max.long<-max(long)

pts.matrix<-matrix(c(lat,long), ncol = 2)
pp <- as.ppp(pts.matrix, c(min.lat, max.lat, min.long, max.long))
#calculate G-statistic
g.stat<-Gest(pp)
