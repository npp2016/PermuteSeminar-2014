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

####Excersize Two

#Seminar 1 - Bootstrap test
require(ggplot2)

#Repeat the experiment 1000 times
global_means<-replicate(1000,max(runif(1000,0,5)))
hist(global_means)

#make a dataframe
draws<-data.frame(d=global_means)

#1000 bootstrap replicates of 1 experiment
j<-runif(1000,0,5)
b<-replicate(1000,max(sample(j,replace=TRUE)))

boots<-data.frame(b=b)

#compare histograms

ggplot() + geom_histogram(data=draws,aes(x=d),fill="blue" ) + geom_histogram(data=boots,aes(x=b),fill="red",alpha=.4)

ggplot() + geom_density(data=draws,aes(x=d),fill="blue" ) + geom_density(data=boots,aes(x=b),fill="red",alpha=.4)


#Probability that the max value is the final dataset
# If we have 1000 values, there is one max value 

require(ggplot2)

#Repeat the experiment 1000 times
global_means<-replicate(1000,var(rcauchy(1000,1,2)))
hist(global_means)


#make a dataframe
draws<-data.frame(d=global_means)

#1000 bootstrap replicates of 1 experiment
j<-cauchy(1000,1,2)
b<-replicate(1000,var(sample(j,replace=TRUE)))

boots<-data.frame(b=b)

#compare histograms

ggplot() + geom_histogram(data=draws,aes(x=d),fill="blue" ) + geom_histogram(data=boots,aes(x=b),fill="red",alpha=.4)

ggplot() + geom_density(data=draws,aes(x=d),fill="blue" ) + geom_density(data=boots,aes(x=b),fill="red",alpha=.4)
