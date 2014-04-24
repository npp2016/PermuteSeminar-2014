## Week 12 data and R code

library(AICcmodavg) ## need this package for this week.
## Reading in Sam's R code (from knitr file)
birds <- read.csv("Week-12/bird_habitat.csv")
colnames(birds)

mod1 <- glm(bird.present ~ elevation, birds, family = binomial)
mod2 <- glm(bird.present ~ farm, birds, family = binomial)
mod3 <- glm(bird.present ~ northing + easting, birds, family = binomial)

aictab(list(mod1, mod2, mod3), modnames = c("Elevation", "Farm", "Position"))

##Model selection based on AICc :
  
##  K   AICc Delta_AICc AICcWt Cum.Wt      LL
##Farm      2 220.68       0.00   0.90   0.90 -108.32
##Position  3 225.91       5.24   0.07   0.97 -109.92
##Elevation 2 227.39       6.71   0.03   1.00 -111.67




