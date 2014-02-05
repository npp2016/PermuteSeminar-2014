a<-rnorm(100,mean=1,sd=3)
d<-matrix(1,1000)
for(i in 1:1000)
{
  f<-sample(a,100,replace=T)
  e<-mean(f)
  d[i]<-e
  
}
hist(d)
e<-matrix(1,1000)
for (i in 1:1000)
{
  l<-sample(rnorm(100,mean=1,sd=3))
  j<-mean(l)
  e[i]<-j
}
par(mfrow=c(1,2))
hist(d)
hist(e)

#uniform (0,5) will draw 1000 draws from a uniform. or draw one sample and bootstrap 1000 times. statistic: the largest value
uni.draw<-runif(1000,min=0,max=5)
uni.draw.matrix<-matrix(1,1000)
for(i in 1:1000)
{
  f<-sample(uni.draw,1000,replace=T)
  e<-max(f)
  uni.draw.matrix[i]<-e
  
}
hist(uni.draw.matrix)
uni.sample<-matrix(1,1000)
for (i in 1:1000)
{
  l<-sample(runif(1000,min=0,max=5))
  j<-max(l)
  uni.sample[i]<-j
}
par(mfrow=c(1,2))
hist(uni.draw.matrix)
hist(uni.sample)
#uniform sample does not work! most of the time 100 will be the largest one-because most of the time you come up with a few numbers; from original you will be going from a continuous dist. what is the prob that the largest num in your dataset is also the largest in your bootstap
#pick a card every time: 1/1000 time to get a particular number and then raise to 1000 times. have to have gotten everythign else n times; have to avoided the biggest number 1000 times b/c only getting one number
#prob did not get the biggest one: n-1^n 1-1/n did not get the biggest value then raise to n-you avoidd the biggest value then 1-that is the prob that you did get the biggest value in your dataset. prob as this whole thing goes to zero is e^-1
#there is a 63% chance that your largest value is what you had in the largest dataset, which is not if you had done the experiment 1000 times.
#so is just stuck on the largest value
#this si the same for any quantile or median-will be a small set of numbers that will always come up

#another example: long-tailed statistical distributions.  the koshi distribution. has no defined mean or variance.
#bootstrap fails when the moments do not have defined values.
hist(rcauchy(1000,location=1,2))
#mean

cauchy.draw<-rcauchy(1000,1,2)
cauchy.draw.m<-matrix(1,1000)
for(i in 1:1000)
{
  f<-sample(cauchy.draw,1000,replace=T)
  e<-mean(f)
  cauchy.draw.m[i]<-e
  
}

cauchy.sample<-matrix(1,1000)
for (i in 1:1000)
{
  l<-sample(rcauchy(1000,1,2))
  j<-mean(l)
  cauchy.sample[i]<-j
}
par(mfrow=c(1,2))
hist(cauchy.draw.m)
hist(cauchy.sample)