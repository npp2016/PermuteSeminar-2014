#upload data
paulet<-read.csv("/Users/rebeccakulp/Documents/Classes/2014/Stats II/PermuteSeminar-2014/Week-8/paulet_island1.csv")
plot(paulet)
#looks lie there is different places
library(spatstat)
plot(paulet)
data<-ppp(paulet$lat,paulet$long,window=w)
w <- owin(xrange=c(min(paulet$lat),max(paulet$lat)),yrange=c(min(paulet$long),max(paulet$long))) 
names(paulet)
K<-Kest(data)
#when had the window too big; it showed duplicates; needed to narrow the range.
#have error with the duplicate datas-so made the window (make one plane could have gotten duplicate data becuase considering all on the same level)
data<-ppp(paulet$lat,paulet$long,window=w)
w <- owin(xrange=c(-63.576,-63.570),yrange=c(-55.80,-55.78)) 
K<-Kest(data)
plot(K)
plot(data)
#show that the spatial pattern does not follow the null distribution, as the line does not fall on the poisson
#next steps 