##---Permutation Methods----#
#--using Dolphin data from Bedjer paper--#

setwd("C:/Users/rocio_000/Dropbox/Courses_Seminars/Stats_Seminar/PermuteSeminar-2014/Week-5")

#read in data
    original <- read.csv("Dolphin+data.csv", header = F)
    original[,1] <- NULL
  data <- read.csv("Dolphin+data.csv", header = F)
  data [,1] <- NULL #get rid of 1st column which is not needed

row<- data[1,]
a <-1
b <-2
m <- data
D <- ncol(data) # the number of individuals in the study


#design function to calculate HWI

    HWI <- function (m, a, b){
      both <- rowSums(m[,c(a,b)]) == 2 #columns where both a and b have 1
      ya <-  sum(m[!both, a])   #only a is present
      yb <-  sum(m[!both, b])   #only b is present
      x <- sum(both)            #both are present
        return (x/(x + .5*(ya+yb)))
  
      }
HWI(data, 1,2) #testing the function

#Calculate HWI for each pair (Oij) i and j dolphins and generate association matrix

  Assoc.Matrix <- function(m){
                  Assoc <- matrix(nrow = D, ncol = D)
                    for (i in 1:D){
                      for (j in 1:D){
                        Assoc[i,j] <- HWI(data, i, j)
                          }
                     
                    }
    return (Assoc)
                            }







######-------Script for randomizing the matrix----######

  #pick 2 random columns and 2 random rows
    #see if they match the pattern
    # 1 0   or    0 1
    # 0 1         1 0
    #if matches then do a swap

  data.matrices <- list() # for storing the association matrices
  x <- 0  #only goes up when there is a pattern match
    while (x < 10) { 
                  #make selection in data
                  pick.row <- sample(1:nrow(data), 2)
                  pick.col <- sample(1:ncol(data), 2)
                  mat <- data[pick.row,pick.col]
                  #match <- sum(data[pick.row,pick.col] == c(0,1,0,1)| c(1,0,1,0))
                  
                  #patterns to be matched up
                  pattern1 <- matrix(c(0,1,1,0), nrow = 2, ncol = 2)
                  pattern2 <- matrix(c(1,0,0,1), nrow = 2, ncol = 2)
                  
                  #determine if selected matrix matches either pattern
                  
                  if (sum(mat==pattern1) == 4){ 
                        x <- x +1
                        data[pick.row,pick.col] <- pattern2 #changes the data file
                        #store the new data frame
                        data.matrices[[x]] <- Assoc.Matrix(data)
                        print ("match1")
                        }
              
                  if (sum(mat==pattern2) == 4){ 
                        x <- x + 1
                        data[pick.row,pick.col] <- pattern2
                        data.matrices[[x]] <- Assoc.Matrix(data)
                        print("match2")
                        } 
    }
    
    


image(z=data.matrix(data))
#Write function for calculating "S" Statistic








dim(data)
row<- seq (1, 39, 1)
col<- seq(1,18,1)
pickrow <- sample(row, 1)
pickcol <- sample(col, 1)

a <- data[i,m]
b <- data[j,m]
c <- data[i,n]
d <- data[j,n]