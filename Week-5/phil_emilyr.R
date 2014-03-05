library(animation)
library(gplots)

#read data
data<- read.csv("C:/R/Dolphindata.csv", header=T)
data<-data[,2:19]
#make a backup of the data for later comparison
datainit=data

#set chain length
samps=500



#calculate HWI from data
calculateHWI<-function(data){
X=matrix(nrow=18,ncol=18)

for(i in 1:18){
  for(j in 1:18){
    X[i,j]=sum(data[,i]*data[,j])
  }
}

Ya=matrix(nrow=18,ncol=18)

for(i in 1:18){
  for(j in 1:18){
    Ya[i,j]=sum(data[,i]*(data[,j]!=1))
  }
}

Yb=matrix(nrow=18,ncol=18)


for(i in 1:18){
  for(j in 1:18){
    Yb[i,j]=sum(data[,j]*(data[,i]!=1))

  }
}
  
  
  HWI=X/(X+0.5*(Ya+Yb))

  return(HWI)
}

#Make changes to the matrix
switchMatrix<-function(data,changes){
  submatrixa=matrix(nrow=2,data=c(0,1,1,0))
  submatrixb=matrix(nrow=2,data=c(1,0,0,1))
  indexis=1:40
  indexjs=1:18
  switched=0
  while(switched==0){
    for(swap in 1:changes){
      js=sample(indexjs,2,replace=FALSE)
      is=sample(indexis,2,replace=FALSE)
      
      test.submatrix=matrix(nrow=2,data=c(data[is[1],js[1]],data[is[1],js[2]],data[is[2],js[1]],data[is[2],js[2]]))
      if(sum(test.submatrix==submatrixa)==4|sum(test.submatrix==submatrixb)==4){
        a=data[is[1],js[1]]
        b=data[is[1],js[2]]
        c=data[is[2],js[1]]
        d=data[is[2],js[2]]
        data[is[1],js[1]]=b
        data[is[1],js[2]]=a
        data[is[2],js[1]]=d
        data[is[2],js[2]]=c        
        switched=1
      }
    }
  }
  return(data)
}


#initiate array to hold HWI's



results=array(dim=c(18,18,samps))
#initiate matrix to track how often an element has been swapped
switched.elements=matrix(nrow=40,ncol=18,data=0)
#initiate vector to contain test stat at each point in chain
S=vector()
#using animate package to visualise changes in the matrix
saveGIF(interval = 0.01,ani.height = 600, ani.width = 3000, expr={par(mfrow=c(1,5))
                                                                  colors=colorRampPalette(c("white", "green", "red"))(n = 20)
                                                                  for(i in 1:samps){
                                                                    #perform swaps in matrix
                                                                    data_temp=switchMatrix(data,1)
                                                                    #which elements were swapped
                                                                    changed=data_temp!=data
                                                                    #track how often each element has changed
                                                                    switched.elements=switched.elements+changed
                                                                    #update to next step in change
                                                                    data=data_temp
                                                                    #calculate HWI
                                                                    results[,,i]=calculateHWI(data)
                                                                    #estimate mean HWI from steps created so far
                                                                    for(p in 1:18){
                                                                      for(k in 1:18){
                                                                        meanHWI=mean(results[p,k,],na.rm=T) 
                                                                      }
                                                                    }
                                                                    #calculate and histogram S
                                                                    S[i]=sum((results[,,i]-meanHWI)^2/18)
                                                                    hist(S,xlim=c(10,11))
                                                                    #histogram number of times each element is swapped
                                                                    hist(switched.elements,xlim=c(0,20),ylim=c(0,720))
                                                                    #which elements are swapped most?
                                                                    image(z=t(switched.elements),col=colors,zlim=c(0,20),x=(0:18),y=(0:40))
                                                                    #How do HWI change
                                                                    image(as.matrix(results[,,i]),col=colors,zlim=c(0,1))
                                                                    #display new Matrix
                                                                    textplot(as.matrix(data),cmar = 1.4,rmar = 0.8,col.data=(changed+1),cex=1)
                                                                  }
})





S=vector()
for(i in 1:samps){
  S[i]=sum((results[,,i]-meanHWI)^2/18)
}
  

sobs=sum((calculateHWI(datainit)-meanHWI)^2/18)

sum(S>=sobs)/samps
hist(S)
abline(v=sobs)
datacols=matrix(nrow=18,ncol=18,data=1)
datacols[1,1]=2
textplot(as.matrix(data),cmar = 0.8,rmar = 0.8)

