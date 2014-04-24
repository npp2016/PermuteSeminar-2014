require(AICcmodavg)

setwd("C:\\Users/Anusha/Documents/GitHub/PermuteSeminar-2014/Week-12/")

thrush <- read.csv("bird_habitat.csv")

head(thrush)

# Building the models
mod1 <- glm(bird.present ~ elevation, thrush, family=binomial)
mod2 <- glm(bird.present ~ farm, thrush, family=binomial)
mod3 <- glm(bird.present ~ northing + easting, thrush, family=binomial)
aictab(list(mod1, mod2, mod3), modnames=c("Elevation", "Farm", "Position"))

# Bootstrap the data and run the AIC
