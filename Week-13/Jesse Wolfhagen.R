library(vegan)
data <- read.csv("Svoboda_Supp.T2.csv")
#Locations: Swamp_1, Swamp_2, Swamp_3, NaCihadle_1, NaCihadle_2, NaCihadle_3
desmids <- read.csv("Svoboda_supp_T2_longform.csv")
##We want to look at the R value between the pools of the swamp
#Each pool has 3 replicates
#The R value is calculated by the (avg(similarities btwn) - avg(similarities wthn))/(n(n-1)/2)/2
Rmaker_swamp <- function(data) #simplified by assuming pools within swamp
{
  Rbtwn <- mean()
}
swamp1.1 <- desmids[which(desmids$ecosystem == "Swamp" & desmids$site == 1 & desmids$pool == 1),c(2,3)]
swamp1.2 <- desmids[which(desmids$ecosystem == "Swamp" & desmids$site == 1 & desmids$pool == 2), c(2,3)]
swampdata <- data.frame(unique(desmids$Taxon))
for(i in 1:3) #each pool
{
  for(j in 1:3) #each replicate
  {
    valuedata <- desmids$value[which(desmids$ecosystem == "Swamp" & desmids$site == i & desmids$pool == j)]
    swampdata <- data.frame(swampdata, valuedata)
  }
}
names(swampdata) <- c("Taxon", "Site1.1", "Site1.2", "Site1.3", "Site2.1", "Site2.2", "Site2.3", "Site3.1", "Site3.2", "Site3.3")
Rmaker <- function(data, grp1, grp2, grp3) #vectors indicating which columns of swampdata to consider as groups
{
  group1 <- rowSums(data[,grp1])
  group2 <- rowSums(data[,grp2])
  group3 <- rowSums(data[,grp3])
  for(i in 1:length(group1))
  {
    if(group1[i] > 0)
    {
      group1[i] <- 1
    }
    if(group2[i] > 0)
    {
      group2[i] <- 1
    }
    if(group3[i] > 0)
    {
      group3[i] <- 1
    }
  } #Creates the three larger groups
  Rbtwns <- c(sum((group1 + group2 == 2)), sum((group1 + group3 == 2)), sum((group2 + group3 == 2)))
  Rwithins <- c(sum(data[,grp1[1]] + data[,grp1[2]] == 2), sum(data[,grp1[1]] + data[,grp1[2]] == 2), sum(data[,grp1[2]] + data[,grp1[3]] == 2),
                sum(data[,grp2[1]] + data[,grp2[2]] == 2), sum(data[,grp2[1]] + data[,grp2[2]] == 2), sum(data[,grp2[2]] + data[,grp2[3]] == 2),
                sum(data[,grp3[1]] + data[,grp3[2]] == 2), sum(data[,grp3[1]] + data[,grp3[2]] == 2), sum(data[,grp3[2]] + data[,grp3[3]] == 2))
  Rval <- (mean(Rbtwns) - mean(Rwithins))/((sum(data[,2:10])*(sum(data[,2:10] - 1)))/4)
  Rval
}
#Now to do the permutation test
Rvaltest <- Rmaker(swampdata, 2:4, 5:7, 8:10) #original data
for(j in 1:999)
{
  newlist <- sample(2:10, 9, replace = F) #redrawing the three groups
  Rvaltest <- c(Rvaltest, Rmaker(swampdata, newlist[1:3], newlist[4:6], newlist[7:9]))
}
sum(Rvaltest >= Rvaltest[1])/length(Rvaltest) #0.001
sum(abs(Rvaltest) >= abs(Rvaltest[1]))/length(Rvaltest) #testing two-sided, p = 0.516
hist(Rvaltest)
abline(v = Rvaltest[1])
