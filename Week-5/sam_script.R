library(gdata)

dolphins <- read.xls("Dolphin data.xlsx")
dolphins <- as.matrix(dolphins[ , 2:ncol(dolphins)])

dolphins
image(dolphins)

hwi <- function(a, b, m) {
  # m : co-occurrence matrix (individuals in columns, groups in rows)
  # a, b : column numbers for a pair of individuals
  both.present <- rowSums(m[ , c(a, b)]) == 2
  y.a  <- sum(m[! both.present , a])# encounters with only a
  y.b  <- sum(m[! both.present , b])# encounters with only b
  x <- sum(both.present) # number of encounters with both a and b
  return(x / (x + 0.5 * (y.a + y.b)))
}

hwi(2, 3, dolphins)


swap <- function(m) {
  while (TRUE) {
    i <- sample.int(nrow(m), 2)
    j <- sample.int(ncol(m), 2)
    
    if (all(m[i, j] == c(1, 0, 0, 1)) | all(m[i, j] == c(0, 1, 1, 0))) {
      m[i, j] <- m[i, j][2:1, ]
      return(m)
    } 
  }
}

m <- dolphins
m1 <- dolphins

m1 <- swap(m1)
image(m == m1)

association.matrix <- function(m) {
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
  D <- nrow(assoc.mat)
  sum(upper.tri(assoc.mat - e.mat)^2) / D^2
}

D <- ncol(dolphins)
n.swaps <- 100
stack <- array(0, c(D, D, n.swaps))
m <- dolphins

for (i in 1:n.swaps) {
  stack[ , , i] <- association.matrix(m)
  m <- swap(m)
}

e.matrix <- apply(stack, c(1,2), mean)
image(e.matrix)

apply(stack, 3, mean)
