##Draw 100 numbers from a normal distribution (mean = 1, sd = 3)
#Get distribution of xbar through drawing from the distribution directly
#Then get distribution of xbar through bootstrapping
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
##Second Example: Draw 1000 from a uniform distribution (min = 0, max = 5)
#Get a distribution of the largest value (Xn)
#Use the same methodology (compare direct draws and bootstrapped draws)
unifstudy <- runif(1000, min = 0, max = 5)
#Distribution of direct draws
directmax <- c()
for(i in 1:1000)
{
  directmax <- c(directmax, max(runif(1000, min = 0, max = 5)))
}
hist(directmax)
#Distribution of bootstrap
bsmax <- c()
for(i in 1:1000)
{
  bsmax <- c(bsmax, max(sample(unifstudy, 1000, replace = T)))
}
hist(bsmax)
##Third Example: Using Cauchy Distribution
#Test statistic: mean
cauchystudy <- rcauchy(1000, 1, 2) #location = 1, scale = 2
directmean <- c()
for(i in 1:1000)
{
  directmean <- c(directmean, mean(rcauchy(1000, 1, 2)))
}
hist(directmean)
bsmean <- c()
for(i in 1:1000)
{
  bsmean <- c(bsmean, mean(sample(cauchystudy, 1000, replace = T)))
}
hist(bsmean)