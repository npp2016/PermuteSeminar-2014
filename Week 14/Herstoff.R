library(picante)
require(picante)
setwd("~/PermuteSeminar-2014/Week 14")

hum <- read.tree("hum294.tre") ## read in phylogenetic tree
  str(hum) ## to see structure of the new class of things
hum$tip.label ## show tip labels for tree
cophenetic.phylo(hum) 
  ## cophenetic score = pairwise matrix of relatedness of tips to most recent common ancestor node
  ## more related, 0; less related= higher#s.
  ## metric of relatedness.
hist(cophenetic.phylo(hum))
  ## hist the cophenetic score/relatedness... seems R-skew (lots of unrelated spp)

##The other two data sets for today:
sites <-read.csv('Sites.csv')
siteXspp <- read.csv("SiteXspp.csv")

colnames(siteXspp)
  ## need to reformat the strings so hum and siteXspp are same thing.
strsplit(colnames(siteXspp),"//.")
strsplit((hum$tip.label),"//.")

newtree<-read.tree("newtree.tre")
newtree ## Jon B. fixed the original 'hum' tree so it has the same format as the siteXspp
  cophenetic.phylo(newtree)
  newtree$tip.label ## same as before
sum(!newtree$tip.label %in% colnames(siteXspp))
  ## how many things have NOT (!) the same name between (%in%) the two sets?

## mean phylo diversity, fcn within picante package
?mpd ##mpd(samp, dis, abundance.weighted=FALSE)
nsxs<-siteXspp[,colnames(siteXspp) %in%newtree$tip.label] ## setting as 0 1's

codis <-cophenetic.phylo(newtree) ##making dis as the cophenetic distance...
newT <- prune.sample(samp=siteXspp, phylo=newtree) ## prune newtree data...

mean.phylo.dist<- mpd(samp=nsxs, dis = codis, abundance.weight=F) ## Jon B. knows all the things. 
hist(mean.phylo.dist) ##mean phylo distances between spp in siteXsp. Makes a test stat for every site

## Compare observed value (mpd) to randomized values...
## Create distribution of observations for the sites and create randomizations.

## matrix of site X species
require(vegan)
?commsimulator
new.matrix<-matrix()

##working on getting a working function...
out<-commsimulator(nsxs, "R00", nsimul=10)



