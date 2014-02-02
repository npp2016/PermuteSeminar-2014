#Rome Dahan's Bootstrap
x<-rnorm(100,1,sd=3)

xbar<-mean(x)

xbarstar<-c()
for(i in 1:1000){
  xstar<-sample(x,100,replace=TRUE)
  xbarstar[i]<-mean(xstar)
}
xbar1<-mean(xbarstar)

hist(x,col="red")
hist(xbarstar)