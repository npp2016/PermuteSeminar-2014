#Simulation of native-exotic richness relationship in randomly constructed communities

**Sampled with different sample sizes**

**Written for SPlus 6.0**



**Jason D. Fridley**

**CB 3280, Coker Hall**

**University of North Carolina at Chapel Hill**

**Chapel Hill, NC 27312**

**phone 919.962.6934**

**fridley@unc.edu**


## Parameters													  
```
reps_100			#number of replicates for each sample size

samps_c(5,10,20,50,100,800)	#sample sizes, in number of represented individuals

pool.range_c(20,100)		#range of species richness of total species pool (includes natives, exotics, and "bare spaces")

NEprop_c(.75,.15,.1)		#proportion of, respectively, natives, exotics, and bare spaces in pool (totals to 1)

```


Output holding array:

	row 1 is native richness

	row 2 is exotic richness

	columns are sample sizes

	3rd dimension is replicates, of length [reps]

```
output_array(0,dim=c(2,length(samps),reps))



tot.pool_round(runif(reps,pool.range[1],pool.range[2]))	#randomly generate [reps]-length vector of total pool sizes
```


## LOOP over replicates
```
for (j in 1:reps){

	print(j)	#progress output



	#determine pool composition for replicate

	natives_paste("N",c(1:round(NEprop[1]*tot.pool[j])))	#list of native species

	exotics_paste("E",c(1:round(NEprop[2]*tot.pool[j])))	#list of exotic species

	zeros_paste("Z",c(1:round(NEprop[3]*tot.pool[j])))	#list of free spaces

	allspp_c(natives,exotics,zeros)				
	#list of all species and blanks



	#randomly construct simulated community

	ind.vec_floor(rlnorm(length(allspp),8,1))		#create list of abundances for each species, from lognormal abundance distribution

	comm_rep(allspp[1],ind.vec[1])				#populate first species in pool with its associated abundance

	for(i in 2:length(allspp)) {				#loop over all remaining species

		comm_c(comm,rep(allspp[i],ind.vec[i]))		#populate remaining species with associated abundances

	}							#close loop



	#sample community using different sample sizes



	for(i in 1:length(samps)) {						#LOOP for different sample sizes

		rs_sample(comm,samps[i])					#draw randomly from community pool of individuals with given sample size

		output[1,i,j]_length(unique(rs[is.element(rs,natives)]))	#total richness of natives in the sample

		output[2,i,j]_length(unique(rs[is.element(rs,exotics)]))	#total richness of exotics in the sample

	}	#end sample size loop		



}		#end replicate loop
```


## Graphical output



```
graphsheet(pages=T)				#open new graphsheet

close.screen(all=T)				

split.screen(figs=c(2,3))
```


## Plot native-exotic richness relationship of largest sampling size

```
plot(output[1,6,],output[2,6,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,max(output[1:2,6,])),ylim=c(0,max(output[1:2,6,])))



abline(lsfit(output[1,6,],output[2,6,]))		#least-squares regression line
```


## Plot native-exotic richness relationship of next smallest sampling size

```
screen(2,F)

plot(output[1,5,],output[2,5,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[5]),ylim=c(0,samps[5]))

abline(lsfit(output[1,5,],output[2,5,]))		#least-squares regression line

abline(samps[5],-1,lty=4)				#data constraint envelope, based on sample size
```


## Plot native-exotic richness relationship of next smallest sampling size
```
screen(3,F)

plot(output[1,4,],output[2,4,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[4]),ylim=c(0,samps[4]))

abline(lsfit(output[1,4,],output[2,4,]))		#least-squares regression line

abline(samps[4],-1,lty=4)				#data constraint envelope, based on sample size
```


## Plot native-exotic richness relationship of next smallest sampling size
```
screen(4,F)

plot(jitter(output[1,3,]),jitter(output[2,3,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[3]),ylim=c(0,samps[3]))

abline(lsfit(output[1,3,],output[2,3,]))		#least-squares regression line

abline(samps[3],-1,lty=4)				#data constraint envelope, based on sample size

```

## Plot native-exotic richness relationship of next smallest sampling size
```
screen(5,F)

plot(jitter(output[1,2,]),jitter(output[2,2,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[2]),ylim=c(0,samps[2]))

abline(lsfit(output[1,2,],output[2,2,]))		#least-squares regression line

abline(samps[2],-1,lty=4)				#data constraint envelope, based on sample size

```

## Plot native-exotic richness relationship of next smallest sampling size
```
screen(6,F)

plot(jitter(output[1,1,]),jitter(output[2,1,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samps[1]),ylim=c(0,samps[1]))

abline(lsfit(output[1,1,],output[2,1,]))		#least-squares regression line

abline(samps[1],-1,lty=4)				#data constraint envelope, based on sample size
```
