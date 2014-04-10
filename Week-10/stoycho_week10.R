counts<-read.csv("speciescounts.csv")
data<-cast(counts,Site+Quadrat~Species,value='Count' ,fun=sum)
data<-as.data.frame(data)
column.data<-melt(data,id=c('Site','Quadrat'))
data<-cast(column.data, Site~variable, value='value', fun=sum)





reps<-100
samples<-c(5,10,20,50,100,800)
pool.range<-c(20,100)
NE.prop<-c(.75,.15,.1)

output<-array(0,dim=c(2,length(samples),reps))


tot.pool<-round(runif(reps,pool.range[1],pool.range[2])) 

for (j in 1:reps){
  
  print(j)
  
  natives<-paste("N",c(1:round(NE.prop[1]*tot.pool[j])))	#list of native species
  
  exotics<-paste("E",c(1:round(NE.prop[2]*tot.pool[j])))	#list of exotic species
  
  zeros<-paste("Z",c(1:round(NE.prop[3]*tot.pool[j])))	#list of free spaces
  
  allspp<-c(natives,exotics,zeros)				
    
  ind.vec<-floor(rlnorm(length(allspp),8,1))		#create list of abundances for each species, from lognormal abundance distribution
  
  comm<-rep(allspp[1],ind.vec[1])				#populate first species in pool with its associated abundance
  
  for(i in 2:length(allspp)) {				#loop over all remaining species
    
    comm<-c(comm,rep(allspp[i],ind.vec[i]))		#populate remaining species with associated abundances
    
  }							#close loop
  
  
  
  #sample community using different sample sizes
  
  
  
  for(i in 1:length(samples)) {						#LOOP for different sample sizes
    
    rs<-sample(comm,samples[i])					#draw randomly from community pool of individuals with given sample size
    
    output[1,i,j]<-length(unique(rs[is.element(rs,natives)]))	#total richness of natives in the sample
    
    output[2,i,j]<-length(unique(rs[is.element(rs,exotics)]))	#total richness of exotics in the sample
    
  }	#end sample size loop		
  
  
  
}		#end replicate loop


close.screen(all=T)				

split.screen(figs=c(2,3))

plot(output[1,6,],output[2,6,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,max(output[1:2,6,])),ylim=c(0,max(output[1:2,6,])))


abline(lsfit(output[1,6,],output[2,6,]))  	#least-squares regression line
screen(2,F)

plot(output[1,5,],output[2,5,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samples[5]),ylim=c(0,samples[5]))

abline(lsfit(output[1,5,],output[2,5,]))  	#least-squares regression line

abline(samples[5],-1,lty=4)				#data constraint envelope, based on sample size
```


## Plot native-exotic richness relationship of next smallest sampling size
```
screen(3,F)

plot(output[1,4,],output[2,4,],pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samples[4]),ylim=c(0,samples[4]))

abline(lsfit(output[1,4,],output[2,4,]))		#least-squares regression line

abline(samples[4],-1,lty=4)				#data constraint envelope, based on sample size
```


## Plot native-exotic richness relationship of next smallest sampling size
```
screen(4,F)

plot(jitter(output[1,3,]),jitter(output[2,3,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samples[3]),ylim=c(0,samples[3]))

abline(lsfit(output[1,3,],output[2,3,]))		#least-squares regression line

abline(samples[3],-1,lty=4)				#data constraint envelope, based on sample size

```

## Plot native-exotic richness relationship of next smallest sampling size
```
screen(5,F)

plot(jitter(output[1,2,]),jitter(output[2,2,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samples[2]),ylim=c(0,samples[2]))

abline(lsfit(output[1,2,],output[2,2,]))		#least-squares regression line

abline(samples[2],-1,lty=4)				#data constraint envelope, based on sample size

```

## Plot native-exotic richness relationship of next smallest sampling size
```
screen(6,F)

plot(jitter(output[1,1,]),jitter(output[2,1,]),pch=".",xlab="native richness",ylab="exotic richness",xlim=c(0,samples[1]),ylim=c(0,samples[1]))

abline(lsfit(output[1,1,],output[2,1,]))		#least-squares regression line

abline(samples[1],-1,lty=4)				#data constraint envelope, based on sample size
```
