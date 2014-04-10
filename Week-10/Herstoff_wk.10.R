## Emily Herstoff
## April 10, 2014
## Null models and spatial distributions

#####=========================================================================================
## from Fridley 2004 code ########
#####=========================================================================================

##Simulation of native-exotic richness relationship in randomly constructed communities

#Sampled with different sample sizes

#Written for SPlus 6.0



#Jason D. Fridley

#CB 3280, Coker Hall

#University of North Carolina at Chapel Hill

#Chapel Hill, NC 27312

#phone 919.962.6934

#fridley@unc.edu

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

output_array<- array(data = 0, dim = c(2,length(samps), reps))
## output_array(0,dim=c(2,length(samps),reps))

## output_array<- matrix(data=0,nrow=dim(2,length(samps))),ncol=length(reps))

tot.pool<- round(runif(reps,pool.range[1],pool.range[2]))	
#randomly generate [reps]-length vector of total pool sizes


#LOOP over replicates
for (j in 1:reps){
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
  }		#close loop
  
    
  #sample community using different sample sizes
  for(i in 1:length(samps)) {						
    #LOOP for different sample sizes
    rs <- sample(comm,samps[i])					#draw randomly from community pool of individuals with given sample size
    output_array[1,i,j] <- length(unique(rs[is.element(rs,natives)]))	#total richness of natives in the sample
    output_array[2,i,j] <- length(unique(rs[is.element(rs,exotics)]))	#total richness of exotics in the sample    
  }	#end sample size loop	
  
}		#end replicate loop


##########################################################
#Graphical output
##########################################################

#Plot native-exotic richness relationship of largest sampling size
plot(output_array[1,6,],output_array[2,6,],pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,max(output_array[1:2,6,])),ylim=c(0,max(output_array[1:2,6,])))
abline(lsfit(output_array[1,6,],output_array[2,6,]))		#least-squares regression line


#Plot native-exotic richness relationship of next smallest sampling size
plot(output_array[1,5,],output_array[2,5,],pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,samps[5]),ylim=c(0,samps[5]))
abline(lsfit(output_array[1,5,],output_array[2,5,]))		#least-squares regression line
abline(samps[5],-1,lty=4)				#data constraint envelope, based on sample size


#Plot native-exotic richness relationship of next smallest sampling size
plot(output_array[1,4,],output_array[2,4,],pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,samps[4]),ylim=c(0,samps[4]))
abline(lsfit(output_array[1,4,],output_array[2,4,]))		#least-squares regression line
abline(samps[4],-1,lty=4)				#data constraint envelope, based on sample size


#Plot native-exotic richness relationship of next smallest sampling size
plot(jitter(output_array[1,3,]),jitter(output_array[2,3,]),pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,samps[3]),ylim=c(0,samps[3]))
abline(lsfit(output_array[1,3,],output_array[2,3,]))		#least-squares regression line
abline(samps[3],-1,lty=4)				#data constraint envelope, based on sample size


#Plot native-exotic richness relationship of next smallest sampling size
plot(jitter(output_array[1,2,]),jitter(output_array[2,2,]),pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,samps[2]),ylim=c(0,samps[2]))
abline(lsfit(output_array[1,2,],output_array[2,2,]))		#least-squares regression line
abline(samps[2],-1,lty=4)				#data constraint envelope, based on sample size


#Plot native-exotic richness relationship of next smallest sampling size
plot(jitter(output_array[1,1,]),jitter(output_array[2,1,]),pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,samps[1]),ylim=c(0,samps[1]))
abline(lsfit(output_array[1,1,],output_array[2,1,]))		#least-squares regression line
abline(samps[1],-1,lty=4)				#data constraint envelope, based on sample size

######
## It works! Re-creates figure 1 from the paper. ##
#####=========================================================================================




############## Now playing with Emily I's dataset ############################################

## read in Emily's data from github
sp.ct <-   read.csv(file="speciescounts.csv")
site.gr <- read.csv(file="site_groupings.csv")

head(sp.ct)
  ##  Site Quadrat                 Species Count Origin
  ## 1 B1GH       1        Asarum canadense     2      N
  ## 2 B1GH       2  Dryopteris camyloptera     1      N
head(site.gr)
  ## Site    River Elevation
  ## 1 B1GH Ballston riverbank
  ## 2 B1GL Ballston riverbank


##########################################################
##Input a bunch of parameters to run the model, same as above.

reps.2 <- 100  		
#number of replicates for each sample size

samps.2 <- c(5,25,50,100)	
#sample sizes, in number of represented individuals

pool.range.2 <- c(20,100)		
#range of species richness of total species pool (includes natives, exotics, and "bare spaces")

NEprop.2 <- c(.71,.19,.1)		
#proportion of, respectively, natives, exotics, and bare spaces in pool (totals to 1)

##########################################################
#Output holding array:

#  row 1 is native richness
#	 row 2 is exotic richness
#	 columns are sample sizes
#	 3rd dimension is replicates, of length [reps]

## Create an array for species.
output_array.2<- array(data = 0, dim = c(2,length(samps.2), reps.2))

tot.pool.2<- round(runif(reps,pool.range[1],pool.range[2]))	
#randomly generate [reps]-length vector of total pool sizes


#LOOP over replicates
for (j in 1:reps){
  #determine pool composition for replicate 
  natives.2 <- paste("N",c(1:round(NEprop.2[1]*tot.pool.2[j])))	#list of native species  
  exotics.2 <-paste("E",c(1:round(NEprop.2[2]*tot.pool.2[j])))	#list of exotic species
  zeros.2 <- paste("Z",c(1:round(NEprop.2[3]*tot.pool.2[j])))	#list of free spaces  
  allspp.2 <- c(natives,exotics,zeros)				#list of all species and blanks
  
  #randomly construct simulated community
  ind.vec.2 <- floor(rlnorm(length(allspp.2),8,1))		
  #create list of abundances for each species, from lognormal abundance distribution 
  comm.2 <- rep(allspp.2[1],ind.vec.2[1])				
  #populate first species in pool with its associated abundance
  
  for(i in 2:length(allspp)) {				#loop over all remaining species    
    comm <- c(comm,rep(allspp[i],ind.vec[i]))		
    #populate remaining species with associated abundances   
  }		#close loop
  
  
  #sample community using different sample sizes
  for(i in 1:length(samps.2)) {						
    #LOOP for different sample sizes
    rs.2 <- sample(comm.2,samps.2[i])					#draw randomly from community pool of individuals with given sample size
    output_array.2[1,i,j] <- length(unique(rs.2[is.element(rs.2,natives.2)]))	#total richness of natives in the sample
    output_array.2[2,i,j] <- length(unique(rs.2[is.element(rs.2,exotics.2)]))	#total richness of exotics in the sample    
  }	#end sample size loop	
}		#end replicate loop


##########################################################
#Graphical output
##########################################################

#Plot native-exotic richness relationship of largest sampling size
plot(output_array[1,6,],output_array[2,6,],pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,max(output_array[1:2,6,])),ylim=c(0,max(output_array[1:2,6,])))
abline(lsfit(output_array[1,6,],output_array[2,6,]))		#least-squares regression line


#Plot native-exotic richness relationship of next smallest sampling size
plot(output_array[1,5,],output_array[2,5,],pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,samps[5]),ylim=c(0,samps[5]))
abline(lsfit(output_array[1,5,],output_array[2,5,]))		#least-squares regression line
abline(samps[5],-1,lty=4)				#data constraint envelope, based on sample size


#Plot native-exotic richness relationship of next smallest sampling size
plot(output_array[1,4,],output_array[2,4,],pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,samps[4]),ylim=c(0,samps[4]))
abline(lsfit(output_array[1,4,],output_array[2,4,]))		#least-squares regression line
abline(samps[4],-1,lty=4)				#data constraint envelope, based on sample size


#Plot native-exotic richness relationship of next smallest sampling size
plot(jitter(output_array[1,3,]),jitter(output_array[2,3,]),pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,samps[3]),ylim=c(0,samps[3]))
abline(lsfit(output_array[1,3,],output_array[2,3,]))		#least-squares regression line
abline(samps[3],-1,lty=4)				#data constraint envelope, based on sample size


#Plot native-exotic richness relationship of next smallest sampling size
plot(jitter(output_array[1,2,]),jitter(output_array[2,2,]),pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,samps[2]),ylim=c(0,samps[2]))
abline(lsfit(output_array[1,2,],output_array[2,2,]))		#least-squares regression line
abline(samps[2],-1,lty=4)				#data constraint envelope, based on sample size


#Plot native-exotic richness relationship of next smallest sampling size
plot(jitter(output_array[1,1,]),jitter(output_array[2,1,]),pch=".",xlab="native richness",ylab="exotic richness",
     xlim=c(0,samps[1]),ylim=c(0,samps[1]))
abline(lsfit(output_array[1,1,],output_array[2,1,]))		#least-squares regression line
abline(samps[1],-1,lty=4)				#data constraint envelope, based on sample size

######
## It works! Re-creates figure 1 from the paper. ##



