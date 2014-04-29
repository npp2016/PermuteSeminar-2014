## Week 12 data and R code

library(AICcmodavg) ## need this package for this week.
## Reading in Sam's R code (from knitr file)
birds <- read.csv("Week-12/bird_habitat.csv")
colnames(birds)
## [1] "easting"      "northing"     "elevation"    "rock"         "farm"         "plant1"      
## [7] "plant2"       "plant3"       "bird.present"

## Sam's models.
mod1 <- glm(bird.present ~ elevation, birds, family = binomial)
mod2 <- glm(bird.present ~ farm, birds, family = binomial)
mod3 <- glm(bird.present ~ northing + easting, birds, family = binomial)

aictab(list(mod1, mod2, mod3), modnames = c("Elevation", "Farm", "Position"))

## Outputs below from aictab...
##Model selection based on AICc :
  
##  K   AICc Delta_AICc AICcWt Cum.Wt      LL
##Farm      2 220.68       0.00   0.90   0.90 -108.32
##Position  3 225.91       5.24   0.07   0.97 -109.92
##Elevation 2 227.39       6.71   0.03   1.00 -111.67

## Sam says: Out of these three candidate models, the one using farmland as a predictor is heavily favored.

## Heather L says: Another possible package for auto model-selection with AIC: glmulti


##============================================================================================================

##Me playing models:

m.1<- glm(bird.present ~ rock + plant1 + plant2 + plant3, birds, family=binomial)
m.2<- glm(bird.present ~ rock + plant1, birds, family=binomial)
m.3<- glm(bird.present ~ rock + plant2, birds, family=binomial)
m.4<- glm(bird.present ~ rock + plant3, birds, family=binomial)
aictab(list(m.1, m.2, m.3, m.4), modnames = c("Plants.all", "plants.1", "plants.2", "plants.3"))

## Model selection based on AICc :
## K   AICc Delta_AICc AICcWt Cum.Wt      LL
##plants.2   3 225.29       0.00   0.49   0.49 -109.60
##plants.1   3 226.89       1.60   0.22   0.71 -110.41
##plants.3   3 226.99       1.70   0.21   0.93 -110.45
##Plants.all 5 229.06       3.77   0.07   1.00 -109.43

## Here, plant #2 seems to be the most VIP.

##============================================================================================================

sum(birds$bird.present) ## 37 total observations out of 300.
sum(birds$rock) ## 29 total observations out of 300.
sum(birds$farm) ## 27 total observations out of 300.

sum(birds$plant1>0) ## 46 total observations out of 300.
sum(birds$plant2>0) ## 111 total observations out of 300.
sum(birds$plant3>0) ## 167 total observations out of 300.





