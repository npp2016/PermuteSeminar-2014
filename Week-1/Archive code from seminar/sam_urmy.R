# Week 1 script

MU <- 1
SD <- 3

sample_size <- 100
n <- 1000
replicates <- rep(0, n)
bootstraps <- rep(0, n)
x <- rnorm(sample_size, MU, SD)

for (i in 1:n) {
  replicates[i] <- mean(rnorm(n, MU, SD))
  bootstraps[i] <- mean(sample(x, sample_size, replace=T))
}

par(mfrow=c(2, 1))
hist(replicates, 30)
hist(bootstraps, 30)
par(mfrow=c(1, 1))

mean(bootstraps) - mean(replicates)
sd(bootstraps) - sd(replicates)
# sd(bootstraps) is the SE of the mean



#################
# Second exercise
#################

replicate_max <- rep(0, n)
bootstrap_max <- rep(0, n)
MIN <- 0
MAX <- 5
x2 <- runif(sample_size, MIN, MAX)

for (i in 1:n) {
  replicate_max[i] <- max(runif(sample_size, MIN, MAX))
  bootstrap_max[i] <- max(sample(x2, sample_size, replace=T))
}

par(mfrow=c(2, 1))
hist(replicate_max, 20)
hist(bootstrap_max, 20)
par(mfrow=c(1, 1))


#####################
# Cauchy Distribution
#####################

hist(rcauchy(1000, 1, 2), 30)

replicate_var <- bootstrap_var <- rep(0, n)
x3 <- rcauchy(sample_size, 1, 2)

for (i in 1:n) {
  replicate_var[i] <- var(rcauchy(sample_size, 1, 2))
  bootstrap_var[i] <- var(sample(x3, sample_size, replace=T))
}

par(mfrow=c(2, 1))
hist(replicate_var, 20)
hist(bootstrap_var, 20)
par(mfrow=c(1, 1))
