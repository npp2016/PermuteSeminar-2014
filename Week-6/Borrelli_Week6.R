setwd("~/Desktop/GitHub/PermuteSeminar-2014/Week-6")

require(ggplot2)
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
# ~ 4.5  minutes for iter = 5000
# ~ 8 minutes for iter = 10000

mat.ij <- t(sapply(pdolph$hwi, FUN = function(x){x[which(lower.tri(x))]}))
e.ij <- colMeans(mat.ij)

S <- c()
for(i in 1:nrow(mat.ij)){
  top <- (mat.ij[i,] - e.ij)^2
  bottom <- ncol(dolphins)^2
  S[i] <- sum(top/bottom)
}

plot(S, typ = "l")
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


#### Trace

ggplot(data.frame(S = S), aes(x = 1:1000, y = S)) + geom_line()


test.three.at.random <- sample(1:1000, 3)
S.list <- list()
for(i in 1:3){
  sample.mat <- pdolph$permuted.matrices[[test.three.at.random[i]]]
  
  p.sample <- permutes(sample.mat, 1000)
  
  test <- lapply(p.sample$permuted.matrices, get_hwi)
  mat.ij.s <- t(sapply(test, FUN = function(x){x[which(lower.tri(x))]}))
  e.ij.s <- colMeans(mat.ij.s)
  
  S.s <- c()
  for(j in 1:nrow(mat.ij.s)){
    top <- (mat.ij.s[j,] - e.ij.s)^2
    bottom <- 18^2
    S.s[j] <- sum(top/bottom)
  }
  
  S.list[[i]] <- S.s
}
require(reshape2)
threesampl <- melt(S.list)
p1 <- ggplot(threesampl, aes(x = 1:1000, y = value[L1 == 1])) + geom_line(col = "purple")
p1 <- p1 + geom_line(aes(x = 1:1000, y = value[L1 == 2]), col = "blue")
p1 <- p1 + geom_line(aes(x = 1:1000, y = value[L1 == 3]), col = "darkgreen")
p1


## Bascompte null model ---------------------------


cS <- colSums(dolphins)/nrow(dolphins)
rS <- rowSums(dolphins)/ncol(dolphins)

mat <- matrix(nrow =nrow(dolphins), ncol = ncol(dolphins))
for(i in 1:nrow(dolphins)){
  for(j in 1:ncol(dolphins)){
    mat[i,j] <- sum((rS[i]+cS[j])/2)
  }
}
dim(dolphins)

mat.list <- list()
for(q in 1:5000){
  mat2 <- matrix(nrow =nrow(dolphins), ncol = ncol(dolphins))
  for(i in 1:nrow(dolphins)){
    for(j in 1:ncol(dolphins)){
      mat2[i,j] <- rbinom(1,1,prob = mat[i,j])
    }
  }
  mat.list[[q]] <- mat2
}

hwi.list <- lapply(mat.list, get_hwi)

lower.mat <- t(sapply(hwi.list, FUN = function(x){x[which(lower.tri(x))]}))

prob.e.ij <- colMeans(lower.mat)

S.p <- c()
for(i in 1:nrow(lower.mat)){
  top <- (lower.mat[i,] - prob.e.ij)^2
  bottom <- ncol(dolphins)^2
  S.p[i] <- sum(top/bottom)
}

ggplot(data.frame(S = S.p), aes(x = 1:length(S.p), y = S)) + geom_line()

