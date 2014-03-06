global.data<-rcauchy(1000,1,2)
data.mean<-vector()
for(i in 1:1000)
{
  data<-rcauchy(1000,1,2)
  data.mean[i]<-mean(data)
}
bootstrap.data<-vector()
for(i in 1:1000)
{
  bootstrap<-sample(global.data,100,replace=T)
  bootstrap.data[i]<-mean(bootstrap)
}
mean(bootstrap.data)
hist(data.mean, col="red")
hist(bootstrap.data,col="blue", add=T)

unif.data<-runif(100,0,5)
max(unif.data)

exp.unif<-vector()
for(i in 1:1000)
{
  data<-runif(100,0,5)
  exp.unif[i]<-max(data)
}
boot.unif<-vector()
for(i in 1:1000)
{
  data<-sample(unif.data,100,replace=T)
  boot.unif[i]<-max(data)
}
hist(exp.unif, col="red", breaks=50)
hist(boot.unif, col="blue", add=T)

