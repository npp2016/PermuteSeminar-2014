library(spatstat)
library(ggplot2)
library(rgl)

avian <- read.csv("avian_island.csv", header=F)
names(avian) <- c("lat", "lon")
xrange <- range(avian$lon)
yrange <- range(avian$lat)
avian.ppp <- ppp(avian$lon, avian$lat, xrange=xrange, yrange=yrange)

paulet <- read.csv("paulet_island.csv", header=F)
names(paulet) <- c("lat", "lon")
paulet <- subset(paulet, ! lat %in% c(0, 1) & ! lon %in% c(0, 1))
paulet <- na.exclude(paulet)
xrange <- range(paulet$lon)
yrange <- range(paulet$lat)
paulet.ppp <- ppp(paulet$lon, paulet$lat, xrange=xrange, yrange=yrange)

par(mfrow=c(1, 2))
plot(lat ~ lon, avian)
plot(lat ~ lon, paulet)
par(mfrow=c(1, 1))

nearest.distances <- data.frame(
  island=c(rep("Avian", dim(avian)[1]), rep("Paulet", dim(paulet)[1])),
  first=c(nndist(avian.ppp), nndist(paulet.ppp)),
  second=c(nndist(avian.ppp, k=2), nndist(paulet.ppp, k=2)),
  third=c(nndist(avian.ppp, k=3), nndist(paulet.ppp, k=3))
)

ggplot(nearest.distances, aes(x=first)) + geom_histogram() +
  facet_grid(island~.)
ggplot(nearest.distances, aes(x=first, y=second, color=island)) + geom_density2d()
ggplot(nearest.distances, aes(x=first, y=third, color=island)) + geom_density2d()
ggplot(nearest.distances, aes(x=second, y=third, color=island)) + geom_density2d()


# plot in 3d
with(nearest.distances,
  plot3d(first, second, third, col=as.numeric(island))
)
