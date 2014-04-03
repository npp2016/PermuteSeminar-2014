setwd("C://Users/Anusha/Documents/GitHub/PermuteSeminar-2014/Null models/")

humm <- read.csv("Hummingbirds.csv")

head(humm)

humm[,1] <- as.numeric(gsub(pattern="Elev_", x=humm[,1], replacement="", fixed=T))
head(humm[,1])
