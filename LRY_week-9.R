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

#start of range
start<-rle(bird$Sp1)$length[1]+1
range.length<-rle(bird$Sp1)$length[2]
top.edge<-length(bird$Elevation)-range.length
new.start<-sample(1:(top.edge),1)
new.vector<-c(rep(0, (length(bird$Elevation)-(new.start+range.length))), rep (1, top.edge), rep(0, new.start))
#caculate 
i<-1
hylid$presence<-c()
for (i in 1:length(hylid$Elevation)){
  hylid$presence[i]<-sum(hylid[i,])-hylid$Elevation[i]
  i<-i+1
}
plot(hylid$Elevation, hylid$presence)


