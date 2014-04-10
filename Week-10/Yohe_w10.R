setwd("~/github_permute/PermuteSeminar-2014/Week-10")

counts<-read.csv("speciescounts.csv")
site<-read.csv("site_groupings.csv")
#assuming every plant takes up same amount of space
#null model is there is no interactions among species
##########################################################
#Parameters    											  
##########################################################

reps<- 100			
#number of replicates for each sample size

samps <- c(5,10,20,50,100,800)	
#sample sizes, in number of represented individuals

pool.range <- c(20,100)		
#range of species richness of total species pool (includes natives, exotics, and "bare spaces")

NEprop<- c(.75,.15,.1)		
#proportion of, respectively, natives, exotics, and bare spaces in pool (totals to 1)

##########################################################

#Output holding array:

#	row 1 is native richness
#	row 2 is exotic richness
#	columns are sample sizes
#	3rd dimension is replicates, of length [reps]

output<- array(0,dim=c(2,length(samps),reps))

tot.pool<- round(runif(reps,pool.range[1],pool.range[2]))	
#randomly generate [reps]-length vector of total pool sizes


#LOOP over replicates

for (j in 1:reps){
  print(j)	#progress output
  
  #determine pool composition for replicate 
  natives <- paste("N",c(1:round(NEprop[1]*tot.pool[j])))	#list of native species  
  exotics <-paste("E",c(1:round(NEprop[2]*tot.pool[j])))	#list of exotic species
  zeros <- paste("Z",c(1:round(NEprop[3]*tot.pool[j])))	#list of free spaces  
  allspp <- c(natives,exotics,zeros)				#list of all species and blanks
  
  #randomly construct simulated community
  ind.vec <- floor(rlnorm(length(allspp),8,1))		
  #create list of abundances for each species, from lognormal abundance distribution 
  comm <- rep(allspp[1],ind.vec[1])				
  #populate first species in pool with its associated abundance
  
  for(i in 2:length(allspp)) {				#loop over all remaining species    
    comm <- c(comm,rep(allspp[i],ind.vec[i]))		
    #populate remaining species with associated abundances   
  }							#close loop
  
  
  
  #sample community using different sample sizes
  for(i in 1:length(samps)) {						
    #LOOP for different sample sizes
    rs <- sample(comm,samps[i])					#draw randomly from community pool of individuals with given sample size
    output[1,i,j] <- length(unique(rs[is.element(rs,natives)]))	#total richness of natives in the sample
    output[2,i,j] <- length(unique(rs[is.element(rs,exotics)]))	#total richness of exotics in the sample
    
  }	#end sample size loop		
  
}		#end replicate loop


##########################################################
#Graphical output
##########################################################

#Plot native-exotic richness relationship of largest sampling size
plot(output[1,6,],output[2,6,],pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,max(output[1:2,6,])),ylim=c(0,max(output[1:2,6,])))
abline(lsfit(output[1,6,],output[2,6,]))		#least-squares regression line



#Plot native-exotic richness relationship of next smallest sampling size
screen(2,F)
plot(output[1,5,],output[2,5,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[5]),ylim=c(0,samps[5]))
abline(lsfit(output[1,5,],output[2,5,]))		#least-squares regression line
abline(samps[5],-1,lty=4)				#data constraint envelope, based on sample size



#Plot native-exotic richness relationship of next smallest sampling size
screen(3,F)
plot(output[1,4,],output[2,4,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[4]),ylim=c(0,samps[4]))
abline(lsfit(output[1,4,],output[2,4,]))		#least-squares regression line
abline(samps[4],-1,lty=4)				#data constraint envelope, based on sample size



#Plot native-exotic richness relationship of next smallest sampling size
screen(4,F)
plot(jitter(output[1,3,]),jitter(output[2,3,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[3]),ylim=c(0,samps[3]))
abline(lsfit(output[1,3,],output[2,3,]))		#least-squares regression line
abline(samps[3],-1,lty=4)				#data constraint envelope, based on sample size



#Plot native-exotic richness relationship of next smallest sampling size
screen(5,F)
plot(jitter(output[1,2,]),jitter(output[2,2,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[2]),ylim=c(0,samps[2]))
abline(lsfit(output[1,2,],output[2,2,]))		#least-squares regression line
abline(samps[2],-1,lty=4)				#data constraint envelope, based on sample size



#Plot native-exotic richness relationship of next smallest sampling size
screen(6,F)
plot(jitter(output[1,1,]),jitter(output[2,1,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[1]),ylim=c(0,samps[1]))
abline(lsfit(output[1,1,],output[2,1,]))		#least-squares regression line
abline(samps[1],-1,lty=4)				#data constraint envelope, based on sample size

######

#now do it with emilys data

site.matrix<- cast(counts, Site + Quadrat  ~ Species, value='Count', fun=sum)
site.matrix<-as.data.frame(site.matrix)
#make NAs 0
site.matrix[is.na(site.matrix)]<-0

#continue to sort
column.quad <- melt(site.matrix, id=c('Site', 'Quadrat'))
#column.quad<-as.data.frame(column.quad)
species.plot<- cast(column.quad, Site~variable, value='value', fun=sum)


#assuming every plant takes up same amount of space
#null model is there is no interactions among species
##########################################################
#Parameters      										  
##########################################################

reps<- 100			
#number of replicates for each sample size

samps <- c(5,10,20,50,100,800)	
#sample sizes, in number of represented individuals

pool.range <- c(20,100)		
#range of species richness of total species pool (includes natives, exotics, and "bare spaces")

NEprop<- c(.50,.10,.40)		
#proportion of, respectively, natives, exotics, and bare spaces in pool (totals to 1)

##########################################################

#Output holding array:

#	row 1 is native richness
#	row 2 is exotic richness
#	columns are sample sizes
#	3rd dimension is replicates, of length [reps]

output<- array(0,dim=c(2,length(samps),reps))

tot.pool<- round(runif(reps,pool.range[1],pool.range[2]))	
#randomly generate [reps]-length vector of total pool sizes


#LOOP over replicates

for (j in 1:reps){
  print(j)	#progress output
  
  #determine pool composition for replicate 
  natives <- paste("N",c(1:round(NEprop[1]*tot.pool[j])))	#list of native species  
  exotics <-paste("E",c(1:round(NEprop[2]*tot.pool[j])))	#list of exotic species
  zeros <- paste("Z",c(1:round(NEprop[3]*tot.pool[j])))	#list of free spaces  
  allspp <- c(natives,exotics,zeros)				#list of all species and blanks
  
  #randomly construct simulated community
  ind.vec <- floor(rlnorm(length(allspp),8,1))		
  #create list of abundances for each species, from lognormal abundance distribution 
  comm <- rep(allspp[1],ind.vec[1])				
  #populate first species in pool with its associated abundance
  
  for(i in 2:length(allspp)) {				#loop over all remaining species    
    comm <- c(comm,rep(allspp[i],ind.vec[i]))		
    #populate remaining species with associated abundances   
  }							#close loop
  
  
  
  #sample community using different sample sizes
  for(i in 1:length(samps)) {						
    #LOOP for different sample sizes
    rs <- sample(comm,samps[i])					#draw randomly from community pool of individuals with given sample size
    output[1,i,j] <- length(unique(rs[is.element(rs,natives)]))	#total richness of natives in the sample
    output[2,i,j] <- length(unique(rs[is.element(rs,exotics)]))	#total richness of exotics in the sample
    
  }	#end sample size loop		
  
}		#end replicate loop


##########################################################
#Graphical output
##########################################################

#Plot native-exotic richness relationship of largest sampling size
plot(output[1,6,],output[2,6,],pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,max(output[1:2,6,])),ylim=c(0,max(output[1:2,6,])))
abline(lsfit(output[1,6,],output[2,6,]))		#least-squares regression line



#Plot native-exotic richness relationship of next smallest sampling size
screen(2,F)
plot(output[1,5,],output[2,5,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[5]),ylim=c(0,samps[5]))
abline(lsfit(output[1,5,],output[2,5,]))		#least-squares regression line
abline(samps[5],-1,lty=4)				#data constraint envelope, based on sample size



#Plot native-exotic richness relationship of next smallest sampling size
screen(3,F)
plot(output[1,4,],output[2,4,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[4]),ylim=c(0,samps[4]))
abline(lsfit(output[1,4,],output[2,4,]))		#least-squares regression line
abline(samps[4],-1,lty=4)				#data constraint envelope, based on sample size



#Plot native-exotic richness relationship of next smallest sampling size
screen(4,F)
plot(jitter(output[1,3,]),jitter(output[2,3,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[3]),ylim=c(0,samps[3]))
abline(lsfit(output[1,3,],output[2,3,]))		#least-squares regression line
abline(samps[3],-1,lty=4)				#data constraint envelope, based on sample size



#Plot native-exotic richness relationship of next smallest sampling size
screen(5,F)
plot(jitter(output[1,2,]),jitter(output[2,2,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[2]),ylim=c(0,samps[2]))
abline(lsfit(output[1,2,],output[2,2,]))		#least-squares regression line
abline(samps[2],-1,lty=4)				#data constraint envelope, based on sample size



#Plot native-exotic richness relationship of next smallest sampling size
screen(6,F)
plot(jitter(output[1,1,]),jitter(output[2,1,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[1]),ylim=c(0,samps[1]))
abline(lsfit(output[1,1,],output[2,1,]))		#least-squares regression line
abline(samps[1],-1,lty=4)				#data constraint envelope, based on sample size

######
