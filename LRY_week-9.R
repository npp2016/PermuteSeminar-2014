#is it possible that the same pattern is produced by different processes?
bird<-read.csv("Hummingbirds.csv")
bird$Elevation<-as.numeric(gsub("Elev_", "", bird$Elevation))

hylid<-read.csv("Hylids.csv")
hylid$Elevation<-as.numeric(gsub("Elev_", "", hylid$Elevation))

#summarize the presence of species at each elevation
i<-1
bird$presence<-c()
for (i in 1:length(bird$Elevation)){
  bird$presence[i]<-sum(bird[i,])-bird$Elevation[i]
  i<-i+1
}
plot(bird$Elevation, bird$presence)

null.matrix<-function(data)
{
  randomatrix<-matrix(nrow=nrow(data), ncol=ncol(data))
  for (j in 1:ncol(data)){
    #start<-rle(data$Sp1)$length[1]+1
    if (sum(data[,j])>0)
      {
        range.length<-rle(data[,j])$length[which(rle(data[,j])$values == 1)]
        top.edge<-nrow(data-range.length
        new.start<-sample(1:(top.edge),1)
        randomatrix[,j]<-c(rep(0,(nrow(data)-(new.start+range.length))), rep (1, top.edge), rep(0, new.start))  
    }
    if (sum(data[,j])>0){
      randomatrix[,j]<-rep(0, nrow(data))
    }
    
  }
  randomatrix
}


fake.bird<-null.matrix(bird[,c(-1,-52)])

#start of range
#caculate 
i<-1
hylid$presence<-c()
for (i in 1:length(hylid$Elevation)){
  hylid$presence[i]<-sum(hylid[i,])-hylid$Elevation[i]
  i<-i+1
}
plot(hylid$Elevation, hylid$presence)


