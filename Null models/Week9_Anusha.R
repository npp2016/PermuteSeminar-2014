## Set working directory
setwd("C://Users/Anusha/Documents/GitHub/PermuteSeminar-2014/Null models/")

## Read in hummingbird file
humm <- read.csv("Hummingbirds.csv")

# Check the data
head(humm)

# Remove "Elev_" from elevation column and save as number
humm[,1] <- as.numeric(gsub(pattern="Elev_", x=humm[,1], replacement="", fixed=T))
# Check the data
head(humm[,1])

## Get richness per elevation
humm$Richness <- rowSums(humm[,2:51])

## Tells you which rows each value starts at, and how many rows at a time
rle(humm$Sp1)

## Plot and look at Richness vs Elevation
plot(humm$Elevation, humm$Richness)

## Sum number of elevation stations each species is present at
humm[26,] <- colSums(humm)

## Create matrix of 0s with same dimensions as the humm matrix
newHumm <- matrix(0, ncol=51, nrow=25)

newHumm[,1] <- humm[1:25,1]
colnames(newHumm) <- colnames(humm[,1:51])

## Calculate how many rows are available from the end of the col to start the 1s
n <- length(humm$Elevation)
 
## Loop to replace new matrix with 1s in different places along the column
for(i in 2:51) {
  TotalElev <- humm[n,i]
  free <- (25 - TotalElev + 1)
  x <- seq(1,free)
  Row <- sample(x, 1)
  y <- Row + TotalElev - 1
  for(j in Row:y){
    newHumm[j,i] <- 1  
  }
}