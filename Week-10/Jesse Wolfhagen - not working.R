##Replicate figure 1 of the Fridley, et al. 2004 paper
#Using Fridley Code from their paper
reps <- 100 #number of communities
samples <- c(5, 10, 20, 50, 100, 800) #sample sizes of individuals (per patch?)
##We want a list of matrices
outputlist <- list()
outputmatrix <- matrix(NA, nrow = 2, ncol = length(samples))
pools <- runif(reps, min = 20, max = 100)
for(l in 1:reps) {
for(i in 1:ncol(outputmatrix)) #fill the arrays with abundances
{
  species <- c()
  species <- c(rep(1, round(0.75*pools[i])), rep(2, round(0.15*pools[i])), rep(3, round(0.1*pools[i])))
  #Next step is to get the abundance for each species
  indiv.vector <- floor(rlnorm(length(species), 8, 1)) #vector of abundances
  community <- c()
  for(j in 1:length(species))
  {
    community <- c(community, rep(species[j], indiv.vector[j]))
  }
  #Now sample the communities at different sample sizes (see samples)
  record <- sample(community, size = samples[i])
  outputmatrix[,i] <- c(sum(record == 1), sum(record == 2)) #native, exotic
}
outputlist[[l]] <- outputmatrix
}
##Now I should actually to plot this
maxes <- c()
for(m in 1:length(outputlist))
{
  maxes <- c(maxes, max(outputlist[[m]]))
}
plot(NA, xlim = c(0,max(maxes)), ylim = c(0,max(maxes)), xlab = "Native species richness", ylab = "Exotic species richness") #plot window
for(n in 1:length(outputlist))
{
  points(x = outputlist[[n]][1,6], y = outputlist[[n]][2,6])
}
##THIS DID NOT WORK OH GOSH DO NOT USE IT