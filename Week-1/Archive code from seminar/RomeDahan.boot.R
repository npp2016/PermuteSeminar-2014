#Rome Dahan's Bootstrap
xbar<-c()
for(i in 1:1000){
x<-rnorm(100,1,sd=3)
xbar[i]<-mean(x)
}
x<-rnorm(100,1,3)
xbarstar<-c()
for(i in 1:1000){
  xstar<-sample(x,100,replace=TRUE)
  xbarstar[i]<-mean(xstar)
}

hist(xbar,col="red")
hist(xbarstar,col="blue",add=TRUE)