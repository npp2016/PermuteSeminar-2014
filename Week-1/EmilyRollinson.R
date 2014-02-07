###EXERCISE 1

#N(1,sd=3)
#Draw from the above distribution (1000 original "samples")
#Draw from that distribution 1000 times

sampledmeans<-replicate(1000,mean(rnorm(100,sd=3)))
                        
#Then draw just once and bootstrap from that 1000 times
sample<-rnorm(100,sd=3)
bootstrappedmeans<-replicate(1000,mean(sample(sample,replace=TRUE)))


#overlay histograms
par(mfrow = c(1,2))
hist(sampledmeans, col="cadetblue")
hist(bootstrappedmeans, col="indianred", add=TRUE)




###EXERCISE 2
#As before but the sample statistic is the largest value
#Draw 1000 from 0 to 5 (uniform distribution) store the largest (do this a thousand times)

studymax<-replicate(1000,max(runif(100, min=0, max=5)))

#Then repeat - draw 1000 from 0 to 5

sampmax<-runif(100,min=0, max=5)
bsmax<-replicate(1000,max(sample(sampmax,replace=TRUE)))

#plot
hist(studymax, col="red")
hist(bsmax, col="blue", add=TRUE)


#EXAMPLE 3 - Cauchy distribution
#as above, sample variance 1000 times, and then sample once and bootstrap

#actually sampling
studyvar<-replicate(1000,var(rcauchy(1000,1,2)))

#bootstrap
sampvar<-rcauchy(1000,1,2)
bsvar<-replicate(1000,var(sample(sampvar,replace=TRUE)))

#plot
par(mfrow = c(1,2))
hist(studyvar, col="red")
hist(bsvar, col="blue")
