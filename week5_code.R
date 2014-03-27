

###------PERMUTATION TESTS--------#

library(ggplot2)

treatment <- c(23,38,94,99,197,141,16)
control <- c(40, 10, 52, 27, 51, 104, 46, 30, 146)

x <- mean(treatment)
y <- mean (control)
diff.mean <- x-y

n <- length(treatment)
m <- length(control)
N <- n + m

all.data <- c(treatment,control)
shuffle <- sample(all.data, N, replace = F)

boot.x <- shuffle[1:n] 
boot.y <- shuffle[(n+1):N]
B <- mean(boot.x) - mean(boot.y)


B <- c()
for (i in 1:1000){
  shuffle <- sample(all.data, N, replace = F)
    boot.x <- shuffle[1:n] 
    boot.y <- shuffle[(n+1):N]
  B[i] <- mean(boot.x) - mean(boot.y)
  
}

hist(B)
qplot(B, binwidth = 10)


B <- list(sample(all.data, n, replace = F), sample(all.data, m, replace = F))
mean.B <- mean(sum(B[1])+sum(B[2]))
sum(B[1])
B[2]

B <- list()
for(i in 1:1000){
    B[[i]]<-
  
}





library("gdata")
data <- read.csv("Dolphin+data.csv")

data [,1] <- NULL
row<- data[1,]


hwi <- function (m, a, b){
  both <- rowSums(m[,c(a,b)]) == 2
  ya <-  sum(m[! both, a])
  yb <-  sum(m[!both, b])
  x <- sum(both)
  return (x/(x + .5*(ya+yb)))
  
}

hwi(data, 1,2)

dim(data)
row<- seq (1, 39, 1)
col<- seq(1,18,1)
pickrow <- sample(row, 1)
pickcol <- sample(col, 1)

a <- data[i,m]
b <- data[j,m]
c <- data[i,n]
d <- data[j,n]

