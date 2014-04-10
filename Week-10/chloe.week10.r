# Chloe - week10

# read in the .csv file
site.groupings<-read.csv("C:/Users/HaeYeong/Documents/PermuteSeminar-2014/Week-10/site_groupings.csv")
site.groupings

species.counts<-read.csv("C:/Users/HaeYeong/Documents/PermuteSeminar-2014/Week-10/speciescounts.csv")
species.counts
head(species.counts)
length(unique(species.counts$Site))
length(unique(species.counts$Quadrat))
length(unique(species.counts$Species))

  # Draw a random number between 20-100 for species richness in the species pool
spp.no<-c(1:sample(c(20:100),1))
  # Draw abundance for each species from a lognormal distribution
spp.abundance<-round(rlnorm(spp.no,meanlog=8,sdlog=1))

  # make spp.mat with all the variables
spp.mat<-cbind(spp.no,spp.abundance)
spp.mat<-as.data.frame(spp.mat)

  # 75% native (N), 15% exotic (E), 10% blank (B)
  # assign N, E, and B
spp.mat$type<-NA
spp.mat$type[1:(round(0.75*nrow(spp.mat))-1)]<-c("N")
spp.mat$type[round(0.75*nrow(spp.mat)):(round(0.75*nrow(spp.mat))+round(0.15*nrow(spp.mat))-1)]<-c("E")
spp.mat$type[(round(0.75*nrow(spp.mat))+round(0.15*nrow(spp.mat))):nrow(spp.mat)]<-c("B")

all.sampled.spp<-c()
for (i in 1:nrow(spp.mat)){
  a<-c(rep(i,spp.mat[i,2]))
  all.sampled.spp<-c(all.sampled.spp,a)
}

  # sample individuals from the species pool for each quadrat with different sample size
quadrat5<-sample(all.sampled.spp,5)
quadrat10<-sample(all.sampled.spp,10)
quadrat20<-sample(all.sampled.spp,20)
quadrat50<-sample(all.sampled.spp,50)
quadrat100<-sample(all.sampled.spp,100)
quadrat800<-sample(all.sampled.spp,800)

  # calculate the number of N, E, and B in each quadrat
quadrat5.NEB<-c()
for (i in 1:length(quadrat5)){
  quadrat5.NEB[i]<-as.character(spp.mat[quadrat5[i],3])
}

quadrat10.NEB<-c()
for (i in 1:length(quadrat10)){
  quadrat10.NEB[i]<-as.character(spp.mat[quadrat10[i],3])
}

quadrat20.NEB<-c()
for (i in 1:length(quadrat20)){
  quadrat20.NEB[i]<-as.character(spp.mat[quadrat20[i],3])
}

quadrat50.NEB<-c()
for (i in 1:length(quadrat50)){
  quadrat50.NEB[i]<-as.character(spp.mat[quadrat50[i],3])
}

quadrat100.NEB<-c()
for (i in 1:length(quadrat100)){
  quadrat100.NEB[i]<-as.character(spp.mat[quadrat100[i],3])
}

quadrat800.NEB<-c()
for (i in 1:length(quadrat800)){
  quadrat800.NEB[i]<-as.character(spp.mat[quadrat800[i],3])
}

  # count the number of N and E in each quadrat

q5.NE<-as.data.frame(table(quadrat5.NEB))
q5.NE.ratio<-q5.NE[q5.NE$]/q5.NE[]
q10.NE<-as.data.frame(table(quadrat10.NEB))
q10.NE.ratio<-
q20.NE<-as.data.frame(table(quadrat20.NEB))
q20.NE.ratio<-
q50.NE<-as.data.frame(table(quadrat50.NEB))
q50.NE.ratio<-
q100.NE<-as.data.frame(table(quadrat100.NEB))
q100.NE.ratio<-
q800.NE<-as.data.frame(table(quadrat800.NEB))
q800.NE.ratio<-
  # do the above 100 times for each quadrat

for (i in 1:100){
  <-
    return()
}