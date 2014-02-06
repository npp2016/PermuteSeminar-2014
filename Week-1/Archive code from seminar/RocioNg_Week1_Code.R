# 1/30/14 

##----EXCERCISE 1-----##

# Experiment based on Normal distribution
  sample <- rnorm(100,1, sd=3)
  mean <- mean(sample)
#running experiment multiple (1000X) times
  sample_means <- c()
  for (i in 1:1000) {
    experiment <- rnorm(100,1, sd=3)
    sample_means[i] <-mean(experiment)
      }

##BootStrapping##
  experiment2 <- rnorm(100,1,3)
  Boot_samples <- c()
  for (i in 1:1000) {
    bootstrap <- sample(experiment2, 100, replace = T)
    Boot_samples[i] <- mean (bootstrap)
  }
  
#plotting histograms

  hist(sample_means, border = "red", main = NA, lwd = 3)
  abline(v = mean(sample_means), col = "red", lwd = 2)
  hist(Boot_samples, border = "blue", add = T, main = NA, lwd = 3)
  abline(v = mean(Boot_samples), col = "blue", lwd = 2)

#--EXCERCISE 2--#
  
  #uniform distribution
  Usample <- runif(1000,min = 0, max = 5)
  # Run 1000X
  Usample_max <- c()
    for (i in 1:1000){
      Usample_max [i] <- max(runif(1000, 0, 5))
    }
  #BootStrapping
  Boot_Usample_max <- c()
    for (i in 1:1000){
      Boot_Usample_max[i] <- max(sample(Usample, 1000, replace = 2))
    }
  
  hist(Usample_max, border = "red")
  hist(Boot_Usample_max, border = "blue", add = T)
  
#--Excercise 3 --#
  
  #Cauchy Distribution
  Csample <- rcauchy(1000,location = 1, scale = 2)
  #Run 1000X
  Csample_var <- c()
    for (i in 1:1000) {
      Csample_var[i]<- var(rcauchy(1000, 1, 2))
          }
  #bootstrapping
    Boot_Csample_var <- c()
      for (i in 1:1000){
        Boot_Csample_var[i] <- var(sample(Csample, 1000, replace = T))
      }
  
  hist(Csample_var, border = "red")
  hist(Boot_Csample_var, border = "blue", add = T)
  