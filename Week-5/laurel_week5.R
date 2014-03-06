dolphin<-read.csv("Dolphin data.csv")

groups<-dolphin$Group_No
x.ab<-length(groups[which(dolphin$A==1 & dolphin$B==1)])
y.a.ab<-length(groups[which(dolphin$A==1 & dolphin$B==0)])
y.b.ab<-length(groups[which(dolphin$A==0 & dolphin$B==1)])