setwd("~/Desktop/GitHub/PermuteSeminar-2014/Week-5")

require(ggplot2)
require(RCurl)
url <- getURL("https://raw.github.com/PermuteSeminar/
              PermuteSeminar-2014/master/Week-5/Dolphin+data.csv")
dolphins <- read.csv(text = url, row.names = 1, header = F)
colnames(dolphins) <- LETTERS[1:18]
colSums(dolphins)


get_hwi <- function(mat){
  hwi <- matrix(nrow = ncol(mat), ncol = ncol(mat))
  for(i in 1:ncol(mat)){
    for(j in 1:ncol(mat)){
      x <- sum(mat[,i] == 1 & mat[,j] == 1)
      ya <- sum(mat[,i] == 1 & mat[,j] == 0)
      yb <- sum(mat[,i] == 0 & mat[,j] == 1)
      hwi[i,j] <- x / (x + 0.5 * (ya + yb)) 
    }
  }
  return(hwi)
}

get_hwi(dolphins)

permutes <- function(mat, iter = 100){
  pattern1 <- matrix(c(0,1,1,0), nrow = 2, ncol = 2)
  pattern2 <- matrix(c(1,0,0,1), nrow = 2, ncol = 2)
  count <- 0
  mat.list <- list()
  hwi.list <- list()
  
  while(count < iter){
    srow <- sample(1:nrow(mat), 2)
    scol <- sample(1:ncol(mat), 2)
    
    test <- mat[srow, scol]
   
    if(sum(test == pattern1) == 4){
      count <- count + 1
      mat[srow, scol] <- pattern2
      mat.list[[count]] <- mat
      hwi.list[[count]] <- get_hwi(mat)
      next
    } else if(sum(test == pattern2) == 4){
      count <- count + 1
      mat[srow, scol] <- pattern1
      mat.list[[count]] <- mat
      hwi.list[[count]] <- get_hwi(mat)
      next
    } else {next}
  }
  return(list(permuted.matrices = mat.list, hwi = hwi.list))
}

system.time(
  pdolph <- permutes(dolphins, iter = 5000)
)
# ~ 4.5  minutes for iter = 5000
# ~ 8 minutes for iter = 10000

mat.ij <- t(sapply(pdolph$hwi, FUN = function(x){x[which(lower.tri(x))]}))
e.ij <- colMeans(mat.ij)

S <- c()
for(i in 1:ncol(mat.ij)){
  top <- (mat.ij[i,] - e.ij)^2
  bottom <- ncol(dolphins)^2
  S[i] <- sum(top/bottom)
}

hist(S)

true <- get_hwi(dolphins)
oij <- true[which(lower.tri(true))] 
test.stat <- sum(((oij - e.ij)^2)/(18^2))
abline(v = test.stat)

S.2 <- (S - mean(S))/sd(S) 
test.stat <- (test.stat - mean(S))/sd(S)

p.value <- sum(abs(S.2) > abs(test.stat))/length(S.2)


# This is a plot of the null distribution, standardized,
# with the test statistic (for both tails)


p <- ggplot(data.frame(s = S.2), aes(x = s)) 
p <- p + geom_histogram(aes(y = ..density..), binwidth = .25, fill = "white", col = "black")
p <- p + geom_density() 
p <- p + geom_vline(x = c(mean(S), test.stat, -test.stat),
                    col = c("darkgreen", "blue", "blue"), lwd = 2, lty = c(1,1,2))
p


# This script will iterate through a vector of possible permutation numbers and then output
# a p-value for each null distribution

# For each value of the number of permutations, 5 p-values are calculated

# Using this we can determine how the number of permutations influences the p-value
# Currently not working code

n.perm <- c(1000, 5000, 10000, 15000, 20000)
p.test <- list()
for(p in 1:2){
  p.value <- c()
  for(j in 1:5){
    permdolph <- permutes(dolphins, n.perm[p])
    matij <- t(sapply(permdolph$hwi, FUN = function(x){x[which(lower.tri(x))]}))
    eij <- colMeans(matij)
    
    S <- c()
    for(i in 1:ncol(mat.ij)){
      top <- (matij[i,] - eij)^2
      bottom <- ncol(dolphins)^2
      S[i] <- sum(top/bottom)
    }
    p.value[j] <- sum(abs(S.2) > abs(test.stat))/length(S.2)
    cat("The number", j, "run of", n.perm[p], "is done", "\n")
  }
  p.test[[p]] <- p.value
  cat(n.perm[p], "is complete.", "\n")
}

p.test


