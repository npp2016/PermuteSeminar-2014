library(vegan)

# Set working directory
setwd("C://Users\\Anusha\\Documents\\GitHub\\PermuteSeminar-2014\\Week-13")

svob <- read.csv("Svoboda_Supp.T2.csv", row.names=1)
env <- read.csv("Svoboda_T2_csv.csv", row.names=1)
head(svob)
head(env)

# Add column to env data to define swamp vs. bog
env <- env[-1,]
env <- env[-10,]
env$Type <- 0
env$Type[1:9] <- "Swamps"
env$Type[10:18] <- "Bogs"
head(env)

# n is the number of samples being considered
n <- nrow(svob)
M <- n*(n-1)/2

swamps <- svob[,1:9]
bogs <- svob[,10:18]

svob_t <- t(svob)

## Using vegdist of the vegan package to calculate Bray-Curtis dissimilarity index
svob_bray <- vegdist(x=svob_t,method="bray",binary=T, na.rm=T)
attach(env)
sites.ano <- anosim(svob_bray, env$Type)
summary(sites.ano)
detach(env)

dune.dist <- vegdist(dune)
attach(dune.env)
dune.ano <- anosim(dune.dist, Management)
summary(dune.ano)
detach(dune.env)
