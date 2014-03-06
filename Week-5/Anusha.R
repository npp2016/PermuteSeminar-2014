## I looked at Jon B's code for help writing this one. Thanks Jon!
require(RCurl)

#Read in file
dolphin <- read.csv("Dolphin+data.csv")
dolphin <- dolphin[,2:19]


# Rename the cols to match dolphin paper
names(dolphin) <- c("Groups", LETTERS[1:17])

# hwi = x/{x+yab+0.5(ya+yb)}


func.hwi <- function(dat) {
  hwi <- matrix(nrow= ncol(dat), ncol = ncol(dat))
  for(i in 1:ncol(dat)) {
    for(j in 1:ncol(dat)) {
      x <- sum(dat[,i]==1 & dat[,j]==1)
      ya <- sum(dat[,i]==1 & dat[,j]==0)
      yb <- sum(dat[,i]==0 & dat[,j]==1)
      hwi[i,j] <-  x/(x + 0.5*(ya + yb))
    }
  }
  return(hwi)
}

func.hwi(dolphin)

# Number of iterations = n
n <- 10000
permu <- function(dat, n) {
  
  grp1 <- matrix(c(0,1,1,0), nrow=2, ncol=2)
  grp2 <- matrix(c(1,0,0,1), nrow=2, ncol=2)
  count <- 0
  dat.list <- list()
  hwi.list <- list()
  
  while(count < n) {
    s.row <- sample(1:nrow(dat), 2)
    s.col <- sample(1:ncol(dat), 2)
    
    test <- dat[s.row, s.col]
    
    if(sum(test == grp1) == 4){
      count <- count + 1
      dat[s.row, s.col] <- grp2
      dat.list[[count]] <- dat
      hwi.list[[count]] <- func.hwi(dat)
      next
    } else if(sum(test == grp2) == 4){
      count <- count + 1
      dat[s.row, s.col] <- grp1
      dat.list[[count]] <- dat
      hwi.list[[count]] <- func.hwi(dat)
      next
    } else {next}
  }
  return(list(permuted.matrices = dat.list, hwi = hwi.list))
}

per.dolph <- permu(dolphin, n=1000)
sum(per.dolph[[8]] != per.dolph[[7]])

dat.ij <- t(sapply(per.dolph$hwi, FUN = function(x){x[which(lower.tri(x))]}))
e.ij <- colMeans(dat.ij)

S <- c()
for(i in 1:ncol(dat.ij)){
  top <- (dat.ij[i,] - e.ij)^2
  bottom <- ncol(dolphin)^2
  S[i] <- sum(top/bottom)
}

hist(S)

true <- func.hwi(dolphin)
oij <- true[which(lower.tri(true))] 
test.stat <- sum(((oij - e.ij)^2)/(18^2))
abline(v = test.stat)

sum(S > test.stat)/length(S)
sum(S < test.stat)/length(S)

plot(x= 1:length(S), y=S, type = "l")


####### Start of old code #########

output <- list()
flag <- F

# Make a new swapped matrix, which starts as the original
swapped <- dolphin

# Get sample 2x2 numbers for cols and rows to check
cols <- sample(2:19, 2)
rows <- sample(1:38, 2)

## For loop to check
if (dolphin[rows[1],cols[1]]==1 & dolphin[rows[1],cols[2]]==0 & 
      dolphin[rows[2],cols[1]]==0 & dolphin[rows[2],cols[2]]==1) {
  swapped[rows[1],cols[1]]==0
  swapped[rows[1],cols[2]]==1
  swapped[rows[2],cols[1]]==1
  swapped[rows[2],cols[2]]==0
}


