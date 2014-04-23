library(plyr)
library(reshape)
library(ggplot2)
library(rgl)
source("fractal_landscape.R")

iter <- 7
n1 <- 2^iter + 1
x <- seq(0, 50, len=n1) # km
y <- seq(0, 50, len=n1) # km

#make landscape
set.seed(9)
z <- mountains(iter)
z <- (z - min(z))
z <- z * 500
z[z < 340] <- 340
colnames(z) <- x
rownames(z) <- y
data <- melt(z, varnames=c('x', 'y'))
names(data)[3] <- 'z'
ggplot(data, aes(x=x, y=y, fill=z)) + geom_raster()

n <- dim(data)[1]

# make a color overlay for the 3-D plot
colors <- color.matrix(z, 24)
persp3d(x, y, z, aspect=c(1,1,.2), col=colors)


# make up bare rock data
data$rock <- FALSE
data$rock[data$z > 700] <- rbinom(n=n, size=1, prob=0.2)
data$rock[data$z > 800] <- rbinom(n=n, size=1, prob=0.4)
data$rock[data$z > 9000] <- 1
ggplot(data, aes(x=x, y=y, fill=rock)) + geom_raster()

# make up farm data
data$farm <- FALSE
data$farm[data$z < 350] <- rbinom(n=n, size=1, prob=0.7)
ggplot(data, aes(x=x, y=y, fill=farm)) + geom_raster()

# make up plants
where.plants <- ! (data$farm | data$rock)
n.plant <- sum(where.plants)
data$plant1 <- 0
data$plant1[where.plants] <- rbinom(n.plant, size=1, prob=0.2)
data$plant2 <- 0
data$plant2[where.plants] <- rbinom(n.plant, size=1, prob=0.4)
data$plant3 <- 0
data$plant3[where.plants] <- rbinom(n.plant, size=1, prob=0.7)
data$plant4 <- 0
data$plant4[where.plants] <- rbinom(n.plant, size=1, prob=0.05)

plant.max.cover <- c(0.3, 0.4, 0.1, 0.2)
for (i in 1:4) {
  this.plant <- paste("plant", i, sep="")
  plant.present <- data[ , this.plant] != 0
  data[plant.present, this.plant] <- runif(sum(plant.present), 0, plant.max.cover[i])
}

ggplot(data, aes(x=x, y=y, fill=plant1)) + geom_raster()
ggplot(data, aes(x=x, y=y, fill=plant2)) + geom_raster()
ggplot(data, aes(x=x, y=y, fill=plant3)) + geom_raster()
ggplot(data, aes(x=x, y=y, fill=plant4)) + geom_raster()

# make up bird nest locations
logistic <- make.link("logit")$linkinv
beta <- rnorm(9, sd=0.001)
data$p.bird <- logistic(as.matrix(data[ , 1:9]) %*% beta - 1.8)
data$p.bird[data$farm | data$rock] <- 0.01
hist(data$p.bird)
ggplot(data, aes(x=x, y=y, fill=p.bird)) + geom_raster()

data$bird.present <- rbinom(n, size=1, prob=data$p.bird)
ggplot(data, aes(x=x, y=y, fill=bird.present)) + geom_raster()


# simulate a random survey
sample.size <- 300
collected.data <- data[sample(1:n, sample.size), ]
collected.data <- collected.data[ , c(1:8, 11)]
names(collected.data)[1:3] <- c('easting', 'northing', 'elevation')
rownames(collected.data) <- 1:sample.size
head(collected.data)

pairs(collected.data)

write.csv(collected.data, file="../bird_habitat.csv")
