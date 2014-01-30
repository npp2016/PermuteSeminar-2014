a<-rnorm(100,mean=1,sd=3)
d<-matrix(1,1000)
for(i in 1:1000)
{
  f<-sample(a,100,replace=T)
  e<-mean(f)
  d[i]<-e
  
}
hist(d)
