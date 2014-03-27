##---Permutation Methods----#
#--using Dolphin data from Bedjer paper--#

setwd("C:/Users/rocio_000/Dropbox/Courses_Seminars/Stats_Seminar/PermuteSeminar-2014/Week-5")

#read in data
    original <- read.csv("Dolphin+data.csv", header = F)
    original[,1] <- NULL
  data <- read.csv("Dolphin+data.csv", header = F)
  data [,1] <- NULL #get rid of 1st column which is not needed
  D <- ncol(data) # the number of individuals in the study

#row<- data[1,]
#a <-1
#b <-2
#m <- data



#design function to calculate HWI

    HWI <- function (m, a, b){
      both <- rowSums(m[,c(a,b)]) == 2 #columns where both a and b have 1
      ya <-  sum(m[!both, a])   #only a is present
      yb <-  sum(m[!both, b])   #only b is present
      x <- sum(both)            #both are present
        return (x/(x + .5*(ya+yb)))
  
      }
#HWI(data, 1,2) #testing the function

#Calculate HWI for each pair (Oij) i and j dolphins and generate association matrix

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
                        expected.values <- eij.Matrix(data.matrices)  #forms a new matrix each time a new association matrix is added
                        
                        }
              
                  if (sum(mat==pattern2) == 4){ 
                        x <- x + 1
                        data[pick.row,pick.col] <- pattern2
                        data.matrices[[x]] <- Assoc.Matrix(data)
                        print("match2")
                        expected.values <- eij.Matrix(data.matrices)  #forms a new matrix each time a new association matrix is added
                        
                        } 
    }
    
    


image(z=data.matrix(data))

#Write function for calculating "S" Statistic for ONE assocaition Matrix

 Calculate.S <- function (assoc.m, e.matrix){
   values <- c()
   for (i in 1:D){
     for (j in 1:D){
       values[i] <- (assoc.m[i,j]) - (e.matrix[i,j])/(D^2)
     }
     
   }
   return (sum(values)/2)
 }
   

##loop to calculate all S values for all the collected association matrices
S.values <- c()
                    
for (i in 1:length(data.matrices)){
 
  S.values[i] <- Calculate.S(data.matrices[[i]],expected.values )
  
}

#Calculate.S(data.matrices[[10]],expected.values )

hist(S.values)
