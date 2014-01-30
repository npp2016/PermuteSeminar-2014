##Draw 100 numbers from a normal distribution (mean = 1, sd = 3)
#Get distribution of xbar through drawing from the distribution directly
#Then get distribution of xbar through bootstrapping
library(boot)
library(bootstrap)
study <- rnorm(100, mean = 1, sd = 3) #original data
#Get distribution of direct draws
directxbar <- c() #hold means
for(i in 1:1000)
{
  directxbar <- c(directxbar, mean(rnorm(100, mean = 1, sd = 3)))
}
#Get distribution through bootstrap
bsxbar <- c()
for(i in 1:1000)
{
  bsxbar <- c(bsxbar, mean(sample(study, 100, replace = T)))
}
par(mfrow = c(1,2))
hist(directxbar)
hist(bsxbar)
#Checking parameters of the two distributions
mean(directxbar)
mean(bsxbar)
sd(directxbar)
sd(bsxbar)