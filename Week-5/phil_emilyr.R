data<- read.csv("~/R/PermuteSeminar/PermuteSeminar-2014/Week-5/Dolphin+data.csv", header=F)
data<-data[,2:19]
datainit=data
calculateHWI<-function(data){
X=matrix(nrow=18,ncol=18)

diag(together)<-0
for(i in 1:18){
  for(j in 1:18){
    X[i,j]=sum(data[,i]*data[,j])
  }
}

Ya=matrix(nrow=18,ncol=18)

diag(together)<-0
for(i in 1:18){
  for(j in 1:18){
    Ya[i,j]=sum(data[,i]*(data[,j]!=1))
  }
}

Yb=matrix(nrow=18,ncol=18)

diag(together)<-0
for(i in 1:18){
  for(j in 1:18){
    Yb[i,j]=sum(data[,j]*(data[,i]!=1))
  }
}


HWI=X/(X+0.5*(Ya+Yb))
return(HWI)
}


switchMatrix<-function(data,changes){
submatrixa=matrix(nrow=2,data=c(0,1,1,0))
submatrixb=matrix(nrow=2,data=c(1,0,0,1))
index=1:18
switched=0
while(switched==0){
for(swap in 1:changes){
js=sample(index,2,replace=FALSE)
is=sample(index,2,replace=FALSE)

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



samps=500
results=array(dim=c(18,18,samps))


for(i in 1:samps){
  
  data=switchMatrix(data,1)
  results[,,i]=calculateHWI(data)
}

meanHWI=matrix(nrow=18,ncol=18)

for(i in 1:18){
  for(j in 1:18){
    meanHWI=mean(results[i,j,]) 
  }
}

s=vector()
for(i in 1:samps){
  S[i]=sum((results[,,i]-meanHWI)^2/18)
}
  
sobs=sum((calculateHWI(datainit)-meanHWI)^2/18)

sum(S>=sobs)/samps
hist(S)
abline(v=sobs)
