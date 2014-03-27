library(gdata)
library(plyr)

## Function definitions ########################################################

hwi <- function(a, b, m) {
  # Calculate the half-weight index (HWI) between a pair of individuals over
  # a set of encounters.
  # 
  # Arguments:
  #   m : co-occurrence matrix (individuals in columns, groups in rows)
  #   a, b : column numbers for a pair of individuals
  # Value:
  #   The (scalar) half-weight index
  both.present <- rowSums(m[ , c(a, b)]) == 2
  y.a  <- sum(m[! both.present , a])# encounters with only a
  y.b  <- sum(m[! both.present , b])# encounters with only b
  x <- sum(both.present) # number of encounters with both a and b
  return(x / (x + 0.5 * (y.a + y.b)))
}

swap <- function(m) {
  # Searches an encounter-individual matrix randomly for a set of four cells on
  # the corners of a rectangular sub-matrix that form a diagonal 2x2 matrix on
  # their own, and swaps the diagonals.
  #
  # Arguments:
  #   m : co-occurrence matrix (individuals in columns, groups in rows)
  # Value:
  #   The same matrix as supplied, but with the four cells swapped
  while (TRUE) {
    i <- sample.int(nrow(m), 2)
    j <- sample.int(ncol(m), 2)
    
    if (all(m[i, j] == c(1, 0, 0, 1)) | all(m[i, j] == c(0, 1, 1, 0))) {
      m[i, j] <- m[i, j][2:1, ]
      return(m)
    } 
  }
}

association.matrix <- function(m) {
  # Calculates the HWI for each pair of individuals across all encounters.
  #
  # Arguments:
  #   m : co-occurrence matrix (individuals in columns, groups in rows)
  # Value:
  #   A square association matrix, with the upper triangle filled with HWIs
  #   between each pair of individuals.  The lower triangle is all zeros.
  D <- ncol(m)
  result <- matrix(0, D, D)
  for (i in 1:D) {
    for (j in i:D) {
      result[i, j] <- hwi(i, j, m)
    }
  }
  return(result)
}

S <- function(assoc.mat, e.mat) {
  # Calculate the S-statistic from an association matrix and its expected value.
  #
  # Arguments:
  #   assoc.mat : the association matrix
  #   e.mat : the matrix of expexted HWIs
  # Value:
  #   The association matrix's S-statistic
  D <- nrow(assoc.mat)
  # don't have to worry about the upper triangle, since the
  # lower one is all zeros
  sum((assoc.mat - e.mat)^2) / D^2
}

randomized.S <- function(m, n.swaps) {
  # This function doesn't run any faster than the loop below, but uses a lot 
  # less memory because it dosn't store all the intermediate association
  # matrices.  Because it calculates the mean HWI matrix (e.matrix) on the fly,
  # there needs to be a burn-in period for e.matrix to converge to its mean
  D <- ncol(m)
  e.matrix <- matrix(0, D, D)
  S.trace <- rep(0, n.swaps)
  
  for (i in 1:n.swaps) {
    o.matrix <-  association.matrix(m)
    e.matrix  <- e.matrix + o.matrix
    S.trace[i] <- S(o.matrix, e.matrix / i)
    m <- swap(m)
  }
  return(S.trace)  
}

## Script ######################################################################

dolphins <- read.xls("Dolphin data.xlsx")
dolphins <- as.matrix(dolphins[ , 2:ncol(dolphins)])

dolphins
image(dolphins)

image(dolphins == swap(dolphins))

m <- dolphins
D <- ncol(m)
n.swaps <- 1000
stack <- array(0, c(D, D, n.swaps))

for (i in 1:n.swaps) {
  stack[ , , i] <- association.matrix(m)
  m <- swap(m)
}


e.matrix <- aaply(stack, c(1, 2), mean)
S.trace <- aaply(stack, 3, S, e.mat=e.matrix)
plot(S.trace, ty="l")

acf(S.trace, 100)
acf(diff(S.trace), 40)

o.matrix.observed <- association.matrix(dolphins)
S.observed  <- S(o.matrix.observed, e.matrix)

S.observed
burn.in <- 500
sum(S.trace[burn.in:n.swaps] >= S.observed) / (n.swaps - burn.in)
