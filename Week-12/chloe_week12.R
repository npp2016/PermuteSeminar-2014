# Week 12 - Chloe

# Information theory
# goal: devise ways to compress the data with minimum loss of information

# p-value vs. AIC

# p-value
# makes the reviewers happy!
# models need to be nested
# does not tell the probability of the model being true
# significance level is arbitrarily set regardeless of sample size
# with high n, easier to reject! and it could just be the matter of sample size

# AIC
# models are free from being nested
# however, the model structure is held constant
# as n increases, the AIC difference between models gets higher
# (the rank order does not change though)
# this is the same issue with p-value, because with high n, the p-value testing gets more conclusive
# this method does not make the assumption that the models you selected will contain the true model
# you are just looking which one is better than the other

# exploratory vs. predictive models

# exploratory: aims to understand the underlying mechanism of the process
# ex. climate modelers
# predictive models: goal is to just predict without understanding what the mechanism is
# ex. weather modelers

# ensemble 
# ensemble models always results in better fit than a single model
# Heather: ensemble models just really are predictive models. They are hard to explain the mechanism.

# Imputation
# Driscoll et al. removes data with missing covariance
  # should check if the missing covariance are missing at random or not random: is related to some traits of the covariates that produce them
# ways to do this without throwing out data => 'Imputation'
# imputation is the process of replacing missing data with substituted values.
# 1. sample with replacement from the remaining values and create covariance
# 2. model the covariate values as the function of the other variables

# Bootstrap and AIC fundamentally ask different questions!
# Bootstrap
# Q: what is the likelihood of seeing the pattern of your sample (random subset of the population)
# AIC
# Q: Given the sample, what are the models that explain it the best?
# AIC followed by Bootstrap will be a combination of both

# Approach for mechanisitc models and predictive models should be different!
# If you are aiming to identify the mechanism, don't let the computer do it for you!
# meaning, the biologically relevant variables should be chosen a priori
# However, for the purpose of 'prediction', then it will be fine to throw in all the variable that even seem to be not really relevant.

 

# Exercise
# load in data
setwd("C:/Users/haeyeong86/Documents/PermuteSeminar-2014/Week-12")
data<-read.csv("C:/Users/haeyeong86/Documents/PermuteSeminar-2014/Week-12/bird_habitat.csv")

# another R packag for AIC
# package 'glmulti'