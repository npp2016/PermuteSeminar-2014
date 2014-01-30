#Seminar 1 - Bootstrap test
require(ggplot2)

#Repeat the experiment 1000 times
global_means<-replicate(1000,mean(rnorm(100,sd=3)))
hist(global_means)

#make a dataframe
draws<-data.frame(d=global_means)

#1000 bootstrap replicates of 1 experiment
j<-rnorm(100,sd=3)
b<-replicate(1000,mean(sample(j,replace=TRUE)))

boots<-data.frame(b=b)

#compare histograms
ggplot() + geom_histogram(data=draws,aes(x=d),fill="blue" ) + geom_histogram(data=boots,aes(x=b),fill="red",alpha=.4)
