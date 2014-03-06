data <- read.csv("Dolphin+data.csv")
names(data) <- c("Group", LETTERS[1:18])
##Take the HWI measurement
#x/(x+yab+0.5(ya+yb))
#x is # of encounters
#ya is # of dolphin A but not B
#You calculate the HWI for each dyad and the sum is given.
hwi <- function(a, b) #two columns of the dataset (they're both vectors of equal length, 1s and 0s)
{
  x <- 0
  ya <- 0
  yb <- 0
  for(i in 1:length(a))
  {
    if(a[i] == 1 & b[i] == 1)
    {
      x <- sum(x, 1)
    }
    if(a[i] == 1 & b[i] == 0)
    {
      ya <- sum(ya, 1)
    }
    if(a[i] == 0 & b[i] == 1)
    {
      yb <- sum(yb, 1)
    }
  }
  x/(x + 0.5*(ya + yb)) #returns the HWI for that dyad
}
runs <- 1000 #define how many times you want to run the randomization
outputdata <- list(data[which(sum())]) #start with the original data
for(l in 2:runs) #creates randomized data matrices by switching pairs of observations
{
  flag <- F
  ##Start with your matrix that you swap
  while(flag == F)
  {
    swapdata <- outputdata[[l - 1]] #iteratively use previous data matrix for next randomization
    ##Grab two columns and two rows
    columns <- sample(2:19, 2)
    rows <- sample(1:38, 2)
    #First scenario: 1|0 0|1
    if(outputdata[[l-1]][rows[1],columns[1]] == 1 & outputdata[[l-1]][rows[1],columns[2]] == 0 & outputdata[[l-1]][rows[2],columns[1]] == 0 & outputdata[[l-1]][rows[2],columns[2]] == 1)
    {
      swapdata[rows[1], columns[1]] = 0
      swapdata[rows[1], columns[2]] = 1
      swapdata[rows[2], columns[1]] = 1
      swapdata[rows[2], columns[2]] = 0
      flag = T
    }
    #Second scenario: 0|1 1|0
    if(outputdata[[l-1]][rows[1], columns[1]] == 0 & outputdata[[l-1]][rows[1], columns[2]] == 1 & outputdata[[l-1]][rows[2], columns[1]] == 1 & outputdata[[l-1]][rows[2], columns[2]] == 0)
    {
      swapdata[rows[1], columns[1]] = 1
      swapdata[rows[1], columns[2]] = 0
      swapdata[rows[2], columns[1]] = 0
      swapdata[rows[2], columns[2]] = 1
      flag = T
    }
  }
  #saves the new, random data matrix
  outputdata[[l]] <- swapdata
}
##Now it needs to run the HWI for every dyad within a data matrix (and do this for all matrices). Save HWIs in a way that maintains the data matrix and the dyad
hwi(outputdata[[1]][,2], outputdata[[1]][,3])
outputdata[[1]][,2]
#Making HWI values for each dyad
dyads <- matrix(NA, ncol = 153, nrow = length(outputdata)) #list of 153 reflecting each dyad, each item should hold length(outputdata) measures
counter <- 1
for(m in 2:18) #go through each column as the focal one (don't do group 18)
{
  for(n in (m+1):19) #pairs the focal dyad with all of the higher-numbered groups (makes all possible dyads)
  {
    hwis <- c() #resets the hwis vector for each dyad
    for(o in 1:length(outputdata)) #collecting the HWI values for a specific dyad across all matrices
    {
      hwis <- c(hwis, hwi(outputdata[[o]][,m], outputdata[[o]][,n])) #collects HWI values for all matrices
    }
    dyads[,counter] <- hwis
    counter <- counter + 1
  }
}
##Calculate the test statistic S for each data matrix to test for random association
#S = sum(rows)sum(columns) (o_ij - e_ij)^2/D^2
#o_ij: HWI for a dyad
#e_ij: Expected value is just the mean of the dyad HWI for all runs
#D: number of total individuals (sum(data) without the group numbers)
D <- sum(data[2:19]) #171
statistic <- c() #the statistic value for each data matrix
for(p in 1:length(outputdata)) #going through each data matrix
{
  value <- c()
  for(q in 1:ncol(dyads))
  {
    value <- c(value, ((dyads[p,q] - mean(dyads[,q]))^2)/D^2)
  }
  statistic <- c(statistic, sum(value))
}
sum(statistic >= statistic[1])/length(statistic) #the empirical p-value