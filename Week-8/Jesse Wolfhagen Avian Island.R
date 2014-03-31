library(maptools)
avian.data <- read.csv("Week-8/ avian_island.csv")
#Use chull() to create a convex hull around the whole area
hullthings <- chull(latlong)
plot(abs(avian.data))
latlong <- abs(avian.data)
hullthings <- c(hullthings, hullthings[1])
lines(latlong[hullthings,])
#Shows a map of the area with the complex hull
##Take a sample of the species locations around one "cluster"
sample <- latlong[which(latlong[,1] < 67.766),]
#Perform the same method to get a complex hull around the cluster
lines <- chull(sample)
lines <- c(lines, lines[1])
plot(sample)
lines(sample[lines,])
#Create a PPP object (point pattern) of the sample
#Make a window that is the polygon complex hull
Window <- owin(poly = list(x = c(sample[chull(sample),2]), y = c(sample[chull(sample),1])))
sampleppp <- ppp(sample[,2], sample[,1], window = Window)
plot(sampleppp)
#use Kest() to test against CSR (complete spatial randomness)
Kest(sampleppp)
plot(Kest(sampleppp))