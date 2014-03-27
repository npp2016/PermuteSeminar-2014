#read in the data
dolphin<-read.csv("Dolphin data.csv")
dolphin[,1]<- NULL
test<-dolphin #so not to mess up the original data
groups<-colnames(dolphin)
####################################
#this is what we did during seminar#
####################################
HWI.ab<-c()
sightings<-toupper(letters[1:18])
i<-1
sighting<-dolphin[sample(1:nrow(dolphin),2), sample(1:ncol(dolphin),2)]
#patterns
sight.1<-(sighting[1,1]==0 & sighting[1,2]==1) | (sighting[1,1]==1 & sighting[1,2]==0)
sight.2<-(sighting[2,1]==1 & sighting[2,2]==0) | (sighting[2,1]==0 & sighting[2,2]==1)

#calculating HWI for the table from the dolphin paper
for (i in 1:1000){
  #select random sighting
  sight.1<-sample(sightings, size = 1)
  #select second random sighting
  sight.2<-sample(sightings, size =1)
  #calculate the variables
  x.ab<-length(groups[which(dolphin[sight.1]==1 & dolphin[sight.2]==1)])
  x.a.ab<-length(groups[which(dolphin[sight.1]==1 & dolphin[sight.2]==0)])
  y.b.ab<-length(groups[which(dolphin[sight.1]==0 & dolphin[sight.2]==1)])
  #add every new HWI.ab calculation
  HWI.ab[i]<- x.ab/(x.ab+0.5*(y.a.ab +y.b.ab))
  
}
mean(HWI.ab)
#calculating HWI for the table from the dolphin paper
if(sight.1 == TRUE & sight.2 == TRUE){
  new.sight.1<-sighting[2]
  new.sight.2<-sighting[1]
  test[sighting[1,1], sighting[1,2]]<-test[new.sight.1[1,1], new.sight.2[1,2]]
}
for (i in 1:1000){
  #select random sighting
  
  #calculate the variables
  x.ab<-length(groups[which(dolphin[sight.1]==1 & dolphin[sight.2]==1)])
  x.a.ab<-length(groups[which(dolphin[sight.1]==1 & dolphin[sight.2]==0)])
  y.b.ab<-length(groups[which(dolphin[sight.1]==0 & dolphin[sight.2]==1)])
  #add every new HWI.ab calculation
  HWI.ab[i]<- x.ab/(x.ab+0.5*(y.a.ab +y.b.ab))
}
mean(HWI.ab)
###########################
#this is what i am fixing with Stoycho from Rocio's code
###########################
pattern.1<-matrix(c(1,0,0,1), nrow=2, ncol=2)
pattern.2<-matrix(c(0,1,1,0),nrow=2, ncol=2)
#write the function to calcualte the formula
HWI.function<- function(mat,a,b) #inputs a matrix and two numbers
{
  #count the number that match (which is a matched sight)
  match.sight<-rowSums(mat[,c(a,b)])==2 #basically if it is a 1,1
  #count the sight
  x<-sum(match.sight)
  #the ones that are not the sight
  y.a<- sum(mat[!match.sight, a]) #match of a 0,1
  y.b <-  sum(mat[!match.sight, b]) #match of a 1,1
  return (x/(x + .5*(y.a+y.b)))#HWI.function
}
#run the function with the dolphin data
HWI.function(dolphin,1,2)

#now find all the functionss
sight.pairs<-function(mat)
{
  pair<- matrix(nrow=ncol(data), ncol=ncol(data))
  for(i in 1:ncol(data))
  {
    for (j in 1:ncol(data))
    {
      pair[i,j]<-HWI.function(data,i,j)
    }
  }
  return(pair)
}
sight.pairs(dolphin)
total.HWI<-sight.pairs(dolphin)
hist(total.HWI)
#now finally time for the swapping!!
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

#read in data
original <- read.csv("Dolphin+data.csv", header = F)
original[,1] <- NULL
data <- read.csv("Dolphin+data.csv", header = F)
data [,1] <- NULL #get rid of 1st column which is not needed
D <- ncol(data) # the number of individuals in the study

#Write f#Calculate HWI for each pair (Oij) i and j dolphins and generate association matrix

Assoc.Matrix <- function(m){
  Assoc <- matrix(nrow = D, ncol = D)
  for (i in 1:D){
    for (j in 1:D){
      Assoc[i,j] <- HWI(m, i, j)
    }
    
  }
  return (Assoc)
}

#######Functions for calculating e(ij) from the association matrices#####

#function for calculation the eij for ONE pair
eij <- function(list, A, B){
  oij <- c()
  for (i in 1:length(list)){
    oij[i] <- list[[i]][[A,B]]
    
  }
  return (mean(oij))
}


## generate matrix of all eij values
eij.Matrix <- function(m){
  eij.m <- matrix(nrow = D, ncol = D)
  for (i in 1:D){
    for (j in 1:D){
      eij.m[i,j] <- eij(m, i, j)
    }
    
  }
  return (eij.m)
}





######-------Script for randomizing the matrix----######

#pick 2 random columns and 2 random rows
#see if they match the pattern
# 1 0   or    0 1
# 0 1         1 0
#if matches then do a swap

data.matrices <- list() # for storing the association matrices
# matrix of expected 

x <- 0  #only goes up when there is a pattern match
expected.values <- matrix(nrow = D, ncol = D) #generation of empty matrix 
while (x < 100) { 
  
  #make selection in data
  pick.row <- sample(1:nrow(data), 2)
  pick.col <- sample(1:ncol(data), 2)
  mat <- data[pick.row,pick.col]
  #match <- sum(data[pick.row,pick.col] == c(0,1,0,1)| c(1,0,1,0))
  
  #patterns to be matched up
  pattern1 <- matrix(c(0,1,1,0), nrow = 2, ncol = 2)
  pattern2 <- matrix(c(1,0,0,1), nrow = 2, ncol = 2)
  
  #determine if selected matrix matches either pattern. Does a swap and generates association matrix
  
  if (sum(mat==pattern1) == 4){ 
    x <- x +1
    data[pick.row,pick.col] <- pattern2 #changes the data file
    #store the new data frame
    data.matrices[[x]] <- Assoc.Matrix(data)
    print ("match1")
    #expected.values <- eij.Matrix(data.matrices)  #forms a new matrix each time a new association matrix is added
    
  }
  
  if (sum(mat==pattern2) == 4){ 
    x <- x + 1
    data[pick.row,pick.col] <- pattern2
    data.matrices[[x]] <- Assoc.Matrix(data)
    print("match2")
   # expected.values <- eij.Matrix(data.matrices)  #forms a new matrix each time a new association matrix is added
    
  } 
}




image(z=data.matrix(data))

#Write function for calculating "S" Statistic for ONE assocaition Matrix

Calculate.S <- function (assoc.m, e.matrix){
#   values <- c()
#   for (i in 1:D){
#     for (j in 1:D){
#       values[i] <- (assoc.m[i,j]) - (e.matrix[i,j])/(D^2)
#     }
#     
#  }
#  return (sum(values)/2)
  (sum((assoc.mat - e.mat)^2) / D^2)/2
}


##loop to calculate all S values for all the collected association matrices
LongRun1<-c()
ShortRun2<-c()
S.values <- c()

for (i in 1:length(data.matrices)){
  
  LongRun1[i] <- Calculate.S(data.matrices[[i]],expected.values )
  
}

#Calculate.S(data.matrices[[10]],expected.values )

hist(S.values)
hist(LongRun1)
plot(LongRun1, type = "l")
