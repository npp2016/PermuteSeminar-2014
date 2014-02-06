#Exercise 1 - Normal distribution
#Test statistic: mean

##step1
#Draw 1000 random samples from N(1,3) with n=100 and plot the mean of each sample
a<-list()
for (i in 1:1000){
  a[[i]]<-rnorm(100,1,3)
}
mean.a<-c()
for (i in 1:1000){
mean.a[i]<-mean(a[[i]])
}
hist1<-hist(mean.a)

##step2
#Draw 1000 bootstrap samples from one sample of n=100 and plot the mean of each sample
b<-list()
c<-rnorm(100,1,3)
for (i in 1:1000){
  b[[i]]<-sample(c,size=length(c),replace=T)
}
mean.b<-c()
for (i in 1:1000){
  mean.b[i]<-mean(b[[i]])
}
hist2<-hist(mean.b)

#plot
plot(hist1, col="red",xlab="X bar", main="multiple draw(red) vs. bootstrap(blue)",freq=F)
plot(hist2, col="blue", add=TRUE,freq=F)

#Exercise 2 - Uniform distribution
#Test statistic: Maximum value(Xn)

##step 1
#Draw 1000 random samples of n=100 from unif(0,5) and plot the max.value of each sample
x<-list()
for (i in 1:1000){
x[[i]]<-runif(100,0,5)
}
max.x<-c()
for (i in 1:1000){
max.x[i]<-max(x[[i]])
}
hist3<-hist(max.x)

##step2
#Draw 1000 bootstrap samples from a sample with n=100 of unif(0,5) and plot the max. value of each bootstrap sample
d<-runif(100,0,5)
y<-list()
for (i in 1:1000){
  y[[i]]<-sample(d,size=length(d),replace=T)
}
max.y<-c()
for (i in 1:1000){
max.y[i]<-max(y[[i]])
}
hist4<-hist(max.y)

#plot
plot(hist3, col="red", xlab="max(X)", main="multiple draw(red) vs. bootstrap(blue)",freq=F)
plot(hist4, col="blue", add=TRUE,freq=F)

#Exercise3 - Cauchy Distribution
#Test statistic: mean

#step1
#Draw 1000 random samples of n=100
m<-list()
for (i in 1:1000){
  m[[i]]<-rcauchy(100,1,2)
}
mean.m<-c()
for (i in 1:1000){
mean.m[i]<-mean(m[[i]])
}
hist5<-hist(mean.m)

#step2
#Draw 1000 bootstrap sample
k<-rcauchy(1000,1,2)
n<-list()
for (i in 1:1000){
  n[[i]]<-sample(k,size=length(k),replace=T)
}
mean.n<-c()
for (i in 1:1000){
mean.n[i]<-mean(n[[i]])
}
hist6<-hist(mean.n)

#plot
plot(hist5, col="red", xlab="X bar", main="multiple draw(red) vs. bootstrap(blue)", freq=F)
plot(hist6, col="blue", add=TRUE, freq=F)
