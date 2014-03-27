data<-read.csv("paulet_island1.csv")
plot(data)
k<-Kest(data)
?Kest
w<-c(min(data$lat),max(data$lat),min(data$long),max(data$long))
window.data<-as.ppp(X=data,W=w)
K.big<-Kest(window.data)
plot(K.big)

w.small<-c(-63.576,-63.572,-55.795,-55.78)
data.small<-as.ppp(X=data, W=w.small)
K.small<-Kest(data.small)
plot(K.small)
