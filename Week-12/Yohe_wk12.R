setwd("~/github_permute/PermuteSeminar-2014/Week-12")
library(AICcmodavg)

#the point is to bootstrap the data  and rerun the AIC
birds<-read.csv("bird_habitat.csv")
mod1 <- glm(bird.present ~ elevation, birds, family=binomial)
mod2 <- glm(bird.present ~ farm, birds, family=binomial)
mod3 <- glm(bird.present ~ northing + easting, birds, family=binomial)
aictab(list(mod1, mod2, mod3), modnames=c("Elevation", "Farm", "Position"))

