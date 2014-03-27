library(spatstat)
library(maptools)
library(ggplot2)
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
g.stat<- Gest(pp) ## ignore the error message
## Check test output
g.stat 
plot(g.stat)

###=========================================================================

## Now to permute.
## Trying to have seals randomly walk several steps with brownian motion and then re-plot/recalc G stat

## Jon B's random walk function
## NOTE: not quite working yet for seal data on Avian Island...

movement <- function(steps, mode = "normal", p1 = 0, p2 = 1){
  if(mode == "normal"){
    distances <- abs(rnorm(steps, p1, p2))
  }
  if(mode == "lognormal"){
    distances <- rlnorm(steps, p1, p2)
  }
  if(mode == "uniform"){
    distances <- abs(runif(steps, p1, p2))
  }
  return(distances)
}

random_walk.2 <- function(steps, left.p = .5, up.p = .5, mode = "normal", p1 = 0, p2 = 1){
  
  horizontal <- sample(c(-1,1), steps, replace = T, prob = c(left.p, 1-left.p))
  vertical <- sample(c(-1,1), steps, replace = T, prob = c(up.p, 1-up.p))
  moving.horiz <- movement(steps, mode, p1, p2)
  moving.vert <- movement(steps, mode, p1, p2)
  
  walker <- matrix(c(0, 0), nrow = steps+1, ncol = 2, byrow = T)
  for(i in 1:steps){
    # Horizontal Movement
    if(horizontal[i] == 1){
      walker[i+1,1] <- walker[i,1] + moving.horiz[i]
    }
    if(horizontal[i] == -1){
      walker[i+1,1] <- walker[i,1] - moving.horiz[i]
    }
    
    # Vertical Movement
    if(vertical[i] == 1){
      walker[i+1,2] <- walker[i,2] + moving.vert[i]
    }
    if(vertical[i] == -1){
      walker[i+1,2] <- walker[i,2] - moving.vert[i]
    }
  }
  
  colnames(walker) <- c("x", "y")
  walker <- as.data.frame(walker)
  
  return(walker)       
}

rw <- random_walk.2(1000, p2 = 10)

plot.mw <- function(df){
  p <- ggplot(df, aes(x = x, y = y, colour = ind))
  p <- p + geom_line()
  print(p)
}

multiple_walkers <- function(num.walk, parms, plot = T){
  rw <- list()
  for(i in 1:num.walk){
    rw[[i]] <- random_walk.2(parms$steps, parms$left.p, parms$up.p, parms$mode, parms$p1, parms$p2)
  }
  all.rw <- do.call(rbind, rw)
  id <- rep(1:num.walk, each = parms$steps+1)
  all.rw<- cbind(all.rw, ind = factor(id))
  
  if(plot){
    plot.mw(all.rw)
  }
  return(all.rw)
}

params <- data.frame(steps = 1000, left.p = .5, up.p = .5, mode = "normal", p1 = 0, p2 = 1)

mw <- multiple_walkers(10, params)



