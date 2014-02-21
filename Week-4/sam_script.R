###############################################################################
# Functions
###############################################################################
estimate.beta <- function(z) {
  mod.ar <- lm(z[2:n] ~ z[1:(n-1)] + 0)
  return(coefficients(mod.ar)[[1]])
}

simulate.series <- function(n, epsilon, beta) {
  zboot <- rep(0, n)
  eps.boot <- sample(epsilon, n, replace=T)
  for (i in 2:n) {
    zboot[i] = beta * zboot[i-1] + eps.boot[i]
  } 
  return(zboot)
}

###############################################################################
# Script
###############################################################################
hormone <- read.csv("Week-4/hormone_data.csv")
z0 <- mean(hormone$level)
z <- hormone$level - z0
n <- length(z)

plot.ts(z)

beta.hat <- estimate.beta(z)

epsilon <- rep(0, n)
for (i in 2:n) {
  epsilon[i] <- z[i] - beta.hat * z[i-1]
}
hist(epsilon)


nboot <- 1000
beta.boot <- rep(0, nboot)
for (i in 1:nboot) {
  z.star <- simulate.series(n, epsilon, beta.hat)
  beta.boot[i] <- estimate.beta(z.star)
}
hist(beta.boot)
mean(beta.boot)
sd(beta.boot)
