dolphins <- read.csv("/Users/emilypetchler/Documents/GitHub/PermuteSeminar-2014.test/Week-5/Dolphin data.csv")
dolphins <- as.matrix(dolphins[ , 2:ncol(dolphins)])

dolphins

## Use the vegan package to test.
library(vegan)
dolph.veg<- oecosimu(dolphins, nestedchecker, "r0")
dolph.veg

## sequential model, one-sided test, a vector statistic
out.dolph <- oecosimu(dolphins, decorana, "swap", burnin=100, thin=10, 
                statistic="evals", alt = "greater")
out.dolph
