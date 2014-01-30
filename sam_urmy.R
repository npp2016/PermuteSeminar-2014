# Week 1 script

MU <- 1
SD <- 3

sample_size <- 100
n <- 1000
replicates <- rep(0, n)
bootstraps <- rep(0, n)
X <- rnorm(sample_size, MU, SD)

for (i in 1:n) {
  replicates[i] <- mean(rnorm(n, MU, SD))
  bootstraps[i] <- mean(sample(x, n, replace=T))
}

par(mfrow=c(2, 1))
hist(replicates, 30)
hist(bootstraps, 30)
mean(bootstraps) - mean(replicates)
sd(bootstraps) - sd(replicates)
