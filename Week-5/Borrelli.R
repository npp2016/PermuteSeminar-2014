setwd("~/Desktop/GitHub/PermuteSeminar-2014/Week-5")

require(RCurl)
url <- getURL("https://raw.github.com/PermuteSeminar/PermuteSeminar-2014/master/Week-5/Dolphin+data.csv")
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
  pdolph <- permutes(dolphins, iter = 1000)
)

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

sum(S > test.stat)/length(S)
sum(S < test.stat)/length(S)
