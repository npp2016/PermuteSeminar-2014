#this we are trying to recreate the null distribution
#in the paper-figure out the number of species; random draw-r for the lognormal.
#mean of the lognormal distributon (8=5000 individuals; SD=1)
reps<-100  		#number of replicates for each sample size

samps<-c(5,10,20,50,100,800)	#sample sizes, in number of represented individuals

pool.range<-c(20,100)		#range of species richness of total species pool (includes natives, exotics, and "bare spaces")

NEprop<-c(.75,.15,.1)		#proportion of, respectively, natives, exotics, and bare spaces in pool (totals to 1)

output<-array(0,dim=c(2,length(samps),reps))

tot.pool<-round(runif(reps,pool.range[1],pool.range[2]))  #randomly generate [reps]-length vector of total pool sizes

for (j in 1:reps){
  
  print(j)	#progress output
  
  
  #determine pool composition for replicate
  
  natives<-paste("N",c(1:round(NEprop[1]*tot.pool[j])))	#list of native species
  
  exotics<-paste("E",c(1:round(NEprop[2]*tot.pool[j])))	#list of exotic species
  
  zeros<-paste("Z",c(1:round(NEprop[3]*tot.pool[j])))	#list of free spaces
  
  allspp<-c(natives,exotics,zeros)				
  #list of all species and blanks
  
  #randomly construct simulated community
  
  ind.vec<-floor(rlnorm(length(allspp),8,1))		#create list of abundances for each species, from lognormal abundance distribution
  
  comm<-rep(allspp[1],ind.vec[1])				#populate first species in pool with its associated abundance
  
  for(i in 2:length(allspp)) {				#loop over all remaining species
    
    comm<-c(comm,rep(allspp[i],ind.vec[i]))		#populate remaining species with associated abundances
    
  }							#close loop

for(i in 1:length(samps)) {						#LOOP for different sample sizes
  
  rs<-sample(comm,samps[i])					#draw randomly from community pool of individuals with given sample size
  
  output[1,i,j]<-length(unique(rs[is.element(rs,natives)]))	#total richness of natives in the sample
  
  output[2,i,j]<-length(unique(rs[is.element(rs,exotics)]))	#total richness of exotics in the sample
  
}}	#end sample size loop

#now have all the data-so need to graph it
#need to have three figures by two in one sheet
par(mfrow=c(2,3))
##
plot(output[1,6,],output[2,6,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,max(output[1:2,6,])),ylim=c(0,max(output[1:2,6,])))



abline(lsfit(output[1,6,],output[2,6,]))  	#least-squares regression line
###
plot(output[1,5,],output[2,5,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[5]),ylim=c(0,samps[5]))

abline(lsfit(output[1,5,],output[2,5,]))  	#least-squares regression line

abline(samps[5],-1,lty=4)				#data constraint envelope, based on sample size
##
plot(output[1,4,],output[2,4,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[4]),ylim=c(0,samps[4]))

abline(lsfit(output[1,4,],output[2,4,]))  	#least-squares regression line

abline(samps[4],-1,lty=4)				#data constraint envelope, based on sample size
##

plot(jitter(output[1,3,]),jitter(output[2,3,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[3]),ylim=c(0,samps[3]))

abline(lsfit(output[1,3,],output[2,3,]))  	#least-squares regression line

abline(samps[3],-1,lty=4)				#data constraint envelope, based on sample size
##
plot(jitter(output[1,2,]),jitter(output[2,2,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[2]),ylim=c(0,samps[2]))

abline(lsfit(output[1,2,],output[2,2,]))  	#least-squares regression line

abline(samps[2],-1,lty=4)				#data constraint envelope, based on sample size
##
plot(jitter(output[1,1,]),jitter(output[2,1,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[1]),ylim=c(0,samps[1]))

abline(lsfit(output[1,1,],output[2,1,]))  	#least-squares regression line

abline(samps[1],-1,lty=4)				#data constraint envelope, based on sample size

##so the figures look fairly similar to those developed by the paper

#now need to do the permutation test and the null model-can we reject the null model with their data
species<-read.csv("/Users/rebeccakulp/Documents/Classes/2014/Stats II/PermuteSeminar-2014/Week-10/speciescounts.csv",head=T)
library(reshape)
site.sp.quad <- cast(species, Site + Quadrat +Origin~ Species, value='Count')

site.sp.quad <- as.data.frame(site.sp.quad)
site.sp.quad[is.na(site.sp.quad)] <- 0
column.quad <- melt(site.sp.quad, id=c('Site', 'Quadrat','Origin'))
names(column.quad)
#"Site"     "Quadrat"  "variable" "value" 
#made the species column name as variable-so something to keep in mind and count is now value
#we want to sum the number of I and N individuals by site (she will be wanting
#to sum across all the quadrates sampled-which will be a larger areas) 
#so will be adding accross everything
sites<-aggregate(value~Site+Origin,data=column.quad,FUN="sum")
site.sp.quad <- cast(sites, Site + value~ Origin)
site.sp.quad <- cast(sites, Origin~ Site)
site.sp.quad[is.na(site.sp.quad)] <- 0
column.quad <- melt(site.sp.quad, id=c('Site', 'Origin'))
site.sp.quad <- cast(sites, Site + Origin~ value)
invasive<-subset(sites[1:19,c(1,3)])
native<-subset(sites[20:43,c(1,3)])
dataset<-cbind(invasive,native)
site.sp.quad[is.na(site.sp.quad)] <- 0
column.quad <- melt(site.sp.quad, id=c('Site', "Origin"))
names(column.quad)

#are Emilies data consistent with a null model or not???-will need to condense it togther and find an answer of if follows null or not!