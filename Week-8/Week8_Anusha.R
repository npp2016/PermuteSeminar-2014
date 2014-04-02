require(shapefiles)
require(maptools)
require(grDevices)
require(alphahull)
require(plyr)
require(spatstat)

setwd("D:\\Toshiba_Desktop\\Stony Brook\\Course Work\\Spring 2014\\Permute Seminar\\March27")

aviancsv <- read.csv("AVIA_table.txt")
avian <- abs(aviancsv)

avOutline <- chull(aviancsv)

avdata <- read.table(file = "AVIA_table.txt",header = TRUE, fill = TRUE)
nomissing <- na.omit(avdata) #chull function does not work with missing data

#getting the convex hull of each unique point set
plot(abs(avian), cex = 0.5)
hpts_av <- chull(avian)
hpts_av <- c(hpts_av, hpts_av[1])
lines(avian[hpts_av, ])

samp <- avian[which(avian$latitude< 67.766),]
plot(samp)
hpts <- chull(samp)
hpts <- c(hpts, hpts[1])
lines(samp[hpts, ])
lat <- range(samp$latitude)
lon <- range(samp$longitude)
ppp.samp <- ppp(samp$latitude, samp$longitude, lat, lon)

##nndist in spatstat calculates distance to nearest neighbour.
## Can specify first nearest, second nearest, third...