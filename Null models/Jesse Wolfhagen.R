setwd("C:/Users/Jesse Wolfhagen/Desktop/GitHub/PermuteSeminar-2014/Null models/")
#Bring in the datasets
hummingbirds <- read.csv("Hummingbirds.csv")
hummingbirds$Elevation <- as.numeric(gsub("Elev_", "", hummingbirds$Elevation))
hylids <- read.csv("Hylids.csv")
hylids$Elevation <- as.numeric(gsub("Elev_", "", hylids$Elevation))
#Calculate the richnesses
Bird.Richness <- c()
Hylid.Richness <- c()
for(i in 1:nrow(hummingbirds))
{
  Bird.Richness <- c(Bird.Richness, sum(hummingbirds[i,-1]))
  Hylid.Richness <- c(Hylid.Richness, sum(hylids[i,-1]))
}
birds <- data.frame(hummingbirds, Bird.Richness)
plot(birds$Elevation, birds$Bird.Richness)
hylids <- data.frame(hylids, Hylid.Richness)
plot(hylids$Elevation, hylids$Hylid.Richness)
#They both somewhat show lumped distributions (hummingbirds much more so)
#Now to create a null model based on the mid-domain effect

nullmatrix <- function(data)
{
  randommatrix <- matrix(ncol = ncol(data), nrow = nrow(data))
  for(j in 1:ncol(data))
  {
    if(sum(data[,j]) > 0)
    {
      rangelength <- rle(data[,j])$lengths[which(rle(data[,j])$values == 1)] #find how many 1s (length of range)
      newstart <- sample(1:(nrow(data)-rangelength), 1) #sample a new start area where the range would fit inside
      randommatrix[,j] <- c(rep(0, nrow(data)-(newstart+rangelength)), rep(1, rangelength), rep(0, newstart)) #put the new vector
    }
    if(sum(data[,j]) == 0) #If no presences, just give zeros
    {
      randommatrix[,j] <- rep(0, nrow(data)) #make the new matrix
    }
  }
  randommatrix
}

fakebirds <- nullmatrix(birds[,c(-1,-52)]) #one iteration
fakebirds
fake <- birds[,c(-1,-52)]
fakebirds
sum(birds != fakebirds)
plot(birds$Elevation, )