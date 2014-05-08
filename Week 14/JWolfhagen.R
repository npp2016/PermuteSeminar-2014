hummingbirds <- read.tree("hum294.tre") #reading a .tre file
str(hummingbirds)
hummingbirds$tip.label #gives us the whole list of the hummingbirds
hist(cophenetic(hummingbirds))
sites <- read.csv("SiteXspp.csv", row.names = 1)
head(sites)
#Make these sites and tipnames have the same labels so they can be matched
tipnames <- strsplit(hummingbirds$tip.label, split = "\\.")
newtree <- hummingbirds
for(i in 1:length(tipnames)) #fixing the tip names to be in the same format as the SiteXSpecies matrix
{
  newtree$tip.label[i] <- paste(tipnames[[i]][1], tipnames[[i]][2], sep = ".")
}
newtree$tip.label
#Limiting the community matrix data to the ones in the phylogeny
newsites <- sites[,colnames(sites)%in%newtree$tip.label]
codists <- cophenetic(newtree) #the cophenetic distance matrix
#Making a dataframe of hte Sites and their Mean-Phylogenetic-Distance
sitempd <- data.frame(rownames(sites), mpd(newsites, codists))
names(sitempd) <- c("Sites", "MPD")
head(sitempd)
#We randomize the SiteXSpecies matrix, then compute test statistic for everyone
??permat
library(vegan)

MPDtester <- function(sitematrix, originalmpd, tree)
{
  randommatrix <- commsimulator(sitematrix, method = "r00")
  newmpd <- mpd(randommatrix, cophenetic(tree))
  newsitempd <- data.frame(rownames(sites), newmpd)
  names(newsitempd) <- c("Sites", "MPD1")
  newsitempd
}
MPDlist <- list(sitempd)
for(j in 2:10)
{
  MPDlist[[j]] <- MPDtester(newsites, codists, newtree)
  names(MPDlist[[j]]) <- c("Sites", paste("MPD", j, sep = ""))
}
?melt
library(reshape)
?melt
MPDLIST <- cast(melt(MPDlist), Sites~L1~value)
MPDLIST
head(melt(MPDlist))
head(MPDLIST)
##Could not figure out the melting.