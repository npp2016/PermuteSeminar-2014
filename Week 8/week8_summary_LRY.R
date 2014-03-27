setwd("~/Desktop/GitHub/PermuteSeminar-2014/Week 8/AVIA shapefile/")

require(maptools)
#read in the shape file 
pts<-readShapePoints("AVIAseals.shp")

lat<-pts$Lat
long<-pts$Long

#get the indices of lat long on the convex hull
convex<-chull(lat, long)
plot(lat[convex], long[convex])
plot(lat[convex], long[convex], type = "l")
#see the coordinates on the graph
points(lat, long)

require(ggplot2)
hull <- data.frame(x=lat[convex],y=long[convex])

ggplot(data.frame(lat = lat, long = long), aes(x = lat, y = long)) + geom_point() +
  geom_path(data = hull, aes(x=hull$x, y = hull$y), col = "blue") 
  

min.lat<-min(lat)
min.long<-min(long)
max.lat<-max(lat)
max.long<-max(long)

pts.matrix<-matrix(c(lat,long), ncol = 2)
pp <- as.ppp(pts.matrix, c(min.lat, max.lat, min.long, max.long))
#calculate G-statistic
g.stat<-Gest(pp)

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

random_walk.2 <- function(start, steps, left.p = .5, up.p = .5, mode = "normal", p1 = 0, p2 = 1){
  
  horizontal <- sample(c(-1,1), steps, replace = T, prob = c(left.p, 1-left.p))
  vertical <- sample(c(-1,1), steps, replace = T, prob = c(up.p, 1-up.p))
  moving.horiz <- movement(steps, mode, p1, p2)
  moving.vert <- movement(steps, mode, p1, p2)
  
  walker <- matrix(start, nrow = 1, ncol = 2, byrow = T)
  for(i in 1:steps){
    # Horizontal Movement
    if(horizontal[i] == 1){
      walker[i,1] <- walker[i,1] + moving.horiz[i]
    }
    if(horizontal[i] == -1){
      walker[i,1] <- walker[i,1] - moving.horiz[i]
    }
    
    # Vertical Movement
    if(vertical[i] == 1){
      walker[i,2] <- walker[i,2] + moving.vert[i]
    }
    if(vertical[i] == -1){
      walker[i,2] <- walker[i,2] - moving.vert[i]
    }
  }
  
  colnames(walker) <- c("x", "y")
  walker <- as.data.frame(walker)
  
  return(walker)       
}


plot.mw <- function(df){
  p <- ggplot(df, aes(x = x, y = y, colour = ind))
  p <- p + geom_path()
  print(p)
}

multiple_walkers <- function(start, num.walk, parms, plot = T){
  rw <- list()
  for(i in 1:num.walk){
    rw[[i]] <- random_walk.2(start[i,], parms$steps, parms$left.p, parms$up.p, parms$mode, parms$p1, parms$p2)
  }
  all.rw <- do.call(rbind, rw)
  id <- 1:num.walk
  all.rw<- cbind(all.rw, ind = factor(id))
  
  if(plot){
    plot.mw(all.rw)
  }
  return(all.rw)
}

params <- data.frame(steps = 1, left.p = .5, up.p = .5, mode = "uniform", p1 = 0, p2 = .001)

test <- matrix(c(0,0,0,0), nrow = 2, ncol = 2)
multiple_walkers(test, nrow(test), params)

start.mat<- matrix(c(lat = lat, long = long), ncol = 2)
mw <- multiple_walkers(start.mat, nrow(start.mat), params, plot = F)
head(mw)

ggplot(data.frame(lat = lat, long = long), aes(x = lat, y = long)) + geom_point() +
  geom_path(data = hull, aes(x=hull$x, y = hull$y), col = "blue") +
  geom_point(data = mw, aes(x=x,y=y), col = "darkgreen")
