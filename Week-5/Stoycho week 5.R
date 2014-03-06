
data<-read.csv("Dolphin data.csv")
data[,1]<- NULL
#my attempts during seminar
groups<-data$Group.Number
x.ab<-length(groups[which(data$A==1 & data$B==1)])
y.a.ab<-length(groups[which(data$A==1 & data$B==0)])
y.b.ab<-length(groups[which(data$B==1 & data$A==0)])
HWI.ab<-x.ab/(x.ab+.5*(y.a.ab+y.b.ab))

dolphins<-toupper(letters[1:18])
HWI<-c()
i=1
for(i in 1:1000)
{
  a<-sample(dolphins,1)
  b<-sample(dolphins,1)
  
  x<-length(groups[which(data[a]==1 & data[b]==1)])
  y.a<-length(groups[which(data[a]==1 & data[b]==0)])
  y.b<-length(groups[which(data[b]==1 & data[a]==0)])
  HWI[i]<-x/(x+.5*(y.a+y.b))
}
HWI.mean<-mean(HWI)
HWI.mean

pattern.1<-matrix(c(1,0,0,1), nrow=2, ncol=2)
pattern.2<-matrix(c(0,1,1,0),nrow=2, ncol=2)

#working code based on Rocio's code

HWI<- function(mat,a,b)
{
  match<-rowSums(mat[,c(a,b)])==2
  x<-sum(match)
  y.a<- sum(mat[!match, a]) 
  y.b <-  sum(mat[!match, b])
  return (x/(x + .5*(y.a+y.b)))
}
HWI(data,1,2)

all.pairs<-function(mat)
{
  pair<- matrix(nrow=ncol(data), ncol=ncol(data))
  for(i in 1:ncol(data))
  {
    for (j in 1:ncol(data))
    {
      pair[i,j]<-HWI(data,i,j)
    }
  }
  return(pair)
}
all.pairs(data)
all.HWI<-all.pairs(data)
hist(all.HWI)

data.list<- list()
x<-0
while (x < 10)
{
  pick.row <- sample(1:nrow(data), 2)
  pick.col <- sample(1:ncol(data), 2)
  mat <- data[pick.row,pick.col]
  pattern.1 <- matrix(c(0,1,1,0), nrow = 2, ncol = 2)
  pattern.2 <- matrix(c(1,0,0,1), nrow = 2, ncol = 2)
  
  if (sum(mat==pattern.1) == 4)
  { 
    x <- x +1
    data[pick.row,pick.col] <- pattern.2
    data.list[[x]] <- all.pairs(data)
  }
  if (sum(mat==pattern.2)==4)
  {
    x<-x+1
    data[pick.row,pick.col]<- pattern.1
    data.list[[x]] <- all.pairs(data)
  }
}
