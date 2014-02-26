# Permute seminar February 20, 2014
# Anusha Shankar

# Set working directory
setwd("C://Users/Anusha/Documents/GitHub/PermuteSeminar-2014/Week-4/")

# Read in csv file
hormone <- read.csv("hormone_data.csv")
# Define number of samples
n <- nrow(hormone)

# Calculate mean hormone level and deviations from the mean
z0 <- mean(hormone$level)
zt <- hormone$level- z0

# Linear regression of shifted-by-one hormone values
regr <- lm(hormone[2:n,2]~hormone[1:(n-1),2])

beta <- regr$coefficients[2]

error <- matrix(0,n)

for(i in 2:n) {
  error[i] <- zt[i] - (beta*zt[i-1])
}

## Define a beta function ------TODO--------
estim_beta <- function(zt) {
  z0 <- mean(hormone$level)
  zt <- hormone$level- z0
  regr <- lm(hormone[2:n,2]~hormone[1:(n-1),2])
  
  beta <- regr$coefficients[2]
  
}

## Bootstrap- sample with replacement
z_new <- matrix(0,n)
for(i in 1:n) {
  z_new <- sample(zt,size=n,replace=T)
}

