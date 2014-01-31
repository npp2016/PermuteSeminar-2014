t<-c()
for(i in 1:1000){
  x<-rcauchy(1000,1,2)
  t[i]<-mean(x)
}

x<-rcauchy(1000,1,2)
hist(t,col="red")

xstarbar<-c()
for(i in 1:1000){
  xstar<-sample(x,1000,replace=TRUE)
  xstarbar[i]<-mean(xstar)
}
hist(xstarbar,col="blue",add=TRUE)