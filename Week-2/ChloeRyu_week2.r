###Chloe Ryu - Week 2
##Group exercise

# fit distribution
data<-read.csv("C:/Users/Chloe/Documents/PermuteSeminar-2014/Week-2/ClutchSize.csv")
clutchsize<-c()
clutchsize<-data[,"Clutch_size"]
clutchsize
hist(clutchsize)
nrow(data)
library(fitdistrplus)
fitdist(clutchsize,"gamma")
fitdist(clutchsize,"lnorm")
hist(rgamma(1000,4.11,1.19),add=T,col="blue")
hist(rlnorm(1000,1.11,0.50),add=T,col="red")

#sample by species

bootstrap<-matrix(nrow=1000,ncol=1)
for (i in 1:1000){
  bootstrap[i]<-mean(sample(clutchsize,nrow(data),replace=T))
}
hist(bootstrap)
abline(v=mean(bootstrap),col="red")

#sample by family

f<-matrix(nrow=1000,ncol=length(unique(data$Family)))
g<-matrix(nrow=1000,ncol=1)
mean.clutchsize<-matrix(nrow=1000,ncol=length(unique(data$Family)))
for (i in 1:1000){
  f[i,]<-sample(data$Family,length(unique(data$Family)),replace=T)
  for (j in 1:length(unique(data$Family))){
    mean.clutchsize[i,j]<-mean(data[data$Family==f[i,j], "Clutch_size"])
    g[i]<-mean(mean.clutchsize[i,])
  }
}

g
total.mean.clutchsize<-mean(g)
total.mean.clutchsize

#sample at all levels
#sample from family, ex. f[1,] and for the selected genus, resample at genus level


genus<-list()
for (j in 1:length(unique(data$Family))){
genus[j]<-data[data$Family==f[1,j],"Genus_name"]
}
genus
unique(genus)

unique(genus)

genus.length<-matrix(nrow=108,ncol=1)
for (i in 1:length(unique(data$Family))){
genus.length[i]<-length(genus[[i]])
}
total.genus.length<-sum(genus.length)
total.genus.length

resample.genus<-sample(genus,size=total.genus.length,replace=T)
resample.genus


