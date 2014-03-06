

#Chloe week 5

#Dolphin association

setwd("C:/Users/Chloe/Documents/PermuteSeminar-2014/Week-5")
dolphins<- read.csv("Dolphin data.csv", header=T)
dolphins <- as.matrix(dolphins[ , 2:ncol(dolphins)])


######################## LOAD IN FUNCTIONS #####################

# 1) function 'hwi'
# measuring hwi (association)
# data = data matrix, a and b = individual colum number 

hwi=function(data,a,b){
  a.b.present<-which(dolphins[,a]==1&dolphins[,b]==1)
  a.present<-which(dolphins[,a]==1&dolphins[,b]==0)
  b.present<-which(dolphins[,a]==0&dolphins[,b]==1)
  x<-length(a.b.present)
  y.a<-length(a.present)
  y.b<-length(b.present)
  return(x/(x+0.5*(y.a+y.b)))
}

# 2) function 'hwi.matrix.mean'
# measuring mean of hwi of a data matrix

hwi.matrix.mean=function(data){
  hwi.ij<-matrix(nrow=18,ncol=18)
  for (i in 1:17){
    for (j in (i+1):18){
      hwi.ij[i,j]<-hwi(data,i,j)
    }
  }
  hwi.matrix.mean<-mean(hwi.ij,na.rm=TRUE)
  return(hwi.matrix.mean)
}

# 3) function 'S.matrix'
# measuring overall association (S) of a matrix

S.matrix=function(data){
  S.ij<-matrix(nrow=18,ncol=18)
  for (i in 1:17){
    for (j in (i+1):18){
      S.ij[i,j]<-(hwi(dolphins,i,j)-eij)^2/18^2
    }
  }
  S.matrix<-sum(S.ij,na.rm=TRUE)
  return(S.matrix)
}

# 4) function 'rand.matrix'
# generating random matrix

rand.matrix=function(data){
  
  # pick two random individuals (a,b)
  ind<-c(1:18)
  a.b<-sample(ind,2,replace=FALSE)
  a<-a.b[1]
  b<-a.b[2]
  
  # pick two random groups (g1, g2)
  group<-c(1:40)
  g1.g2<-sample(group,2,replace=FALSE)
  g1<-g1.g2[1]
  g2<-g1.g2[2]
  
  # change 0 to 1 and 1 to 0 for those selected cells
  random.data<-data
  random.data[g1,a]<-ifelse(data[g1,a]==0,1,0)
  random.data[g1,b]<-ifelse(data[g1,b]==0,1,0)
  random.data[g2,a]<-ifelse(data[g2,a]==0,1,0)
  random.data[g2,b]<-ifelse(data[g2,b]==0,1,0)
  return(random.data)
}


############ END OF FUNCTIONS ####################  

# generate 100 random matrix from dolphin data
# and calculate eij

random.matrix<-list()
hwi.matrix.mean<-c()

for (i in 1:100){
  random.matrix[[i]]<-rand.matrix(dolphins)
  hwi.matrix.mean[i]<-hwi.matrix.mean(random.matrix[[i]])
}
eij=mean(hwi.matrix.mean)

random.matrix<-rand.matrix(dolphins)
random.matrix

# once eij is calculated, calculate S for dolphins
S.dolphins=S.matrix(dolphins)

# calculate S for all randomly generated data matrices

S.random.matrix<-c()

for (i in 1:100){
  S.random.matrix[i]<-S.matrix(random.matrix[[i]])
}

hist(S.random.matrix)
abline(v=S.dolphins, col="red")
