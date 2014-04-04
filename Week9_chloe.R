# Chloe's week 9

  # read in the data
setwd("C:/Users/HaeYeong/Documents/PermuteSeminar-2014/Null models")
hummingbird<-read.table("Hummingbirds.txt",header=T)
hylids<-read.table("Hylids.txt",header=T)

  # change column names - delete 'elev'
  # to remove, to replace with, where to look for the data
x1<-as.numeric(gsub("Elev_","",hummingbird[,1]))
x2<-as.numeric(gsub(pattern="Elev_",replacement="",x=hylids[,1],fixed=T))

hummingbird[,1]<-c(x1)
hylids[,1]<-c(x2)

  # plot the species richness along the elevation gradient
for (i in 1:nrow(hummingbird)){
  hummingbird$richness[i]<-sum(hummingbird[i,])
}

rowSums(hummingbird[,c(2:51)])
sum(hummingbird[,])
plot(hummingbird$Elevation,hummingbird$richness)


  # calculate the range for each species
sum1<-matrix(nrow=1,ncol=ncol(hummingbird)-1)
for(i in 2:ncol(hummingbird)){
  sum1[i]<-sum(hummingbird[,i])
}

  # remove NA
sum1<-sum1[!is.na(sum1)]

  # create blank matrix
shifted<-matrix(nrow=25, ncol=ncol(hummingbird)-1, 0)

  # identify the rows from which the 1s can be placed
a<-c(rep(25,ncol(hummingbird)-1))
startingrows<-c(a)-c(sum1)+1
  
  # place 1s from the starting point

for(i in 1:50){
  k<-startingrows[i]
  x<-sample(c(1:k),1)  
    for(j in x:(x+sum1[i]-1)){
      shifted[j,i]<-1
    }
}

  # repeat the above for 1000 times
