data <- read.csv("Dolphin+data.csv")
names(data) <- c("Group", LETTERS[1:18])
##Take the HWI measurement
#x/(x+yab+0.5(ya+yb))
#x is # of encounters
#ya is # of dolphin A but not B
#You calculate the HWI for each dyad and the sum is given.
hwi <- function(a, b) #two columns of the dataset
{
  x <- sum(data[,a] == 1 & data[,b] == 1)
  ya <- sum(data[,a] == 1 & data[,b] == 0)
  yb <- sum(data[,a] == 0 & data[,b] == 1)
  x/(x + 0.5*(ya + yb))
}
outputdata <- list()
flag <- F
for(l in 1:1)
{
##Start with your matrix that you swap
while(flag == F)
{
swapdata <- data
##Grab two columns
columns <- sample(2:19, 2)
rows <- sample(1:38, 2)
#First scenario: 1|0 0|1
if(data[rows[1],columns[1]] == 1 & data[rows[1],columns[2]] == 0 & data[rows[2],columns[1]] == 0 & data[rows[2],columns[2]] == 1)
{
  swapdata[rows[1], columns[1]] = 0
  swapdata[rows[1], columns[2]] = 1
  swapdata[rows[2], columns[1]] = 1
  swapdata[rows[2], columns[2]] = 0
  flag = T
}
#Second scenario: 0|1 1|0
if(data[rows[1], columns[1]] == 0 & data[rows[1], columns[2]] == 1 & data[rows[2], columns[1]] == 1 & data[rows[2], columns[2]] == 0)
{
  swapdata[rows[1], columns[1]] = 1
  swapdata[rows[1], columns[2]] = 0
  swapdata[rows[2], columns[1]] = 0
  swapdata[rows[2], columns[2]] = 1
  flag = T
}
}
outputdata <- list(outputdata, swapdata)
}