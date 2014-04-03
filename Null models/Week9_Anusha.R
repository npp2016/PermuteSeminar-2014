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
head(humm)

## Plot and look at Richness vs Elevation
plot(humm$Elevation, humm$Richness)

humm[26,] <- colSums(humm)
tail(humm)
