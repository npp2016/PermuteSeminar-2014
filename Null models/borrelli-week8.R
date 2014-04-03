setwd("~/Desktop/GitHub/PermuteSeminar-2014/Null models")

humming <- read.table("Hummingbirds.txt", header = T, row.names = 1)
hylids <- read.table("Hylids.txt", header = T, row.names = 1)

elev.hu <- as.numeric(gsub("Elev_", "", rownames(humming)))
elev.hy <- as.numeric(gsub("Elev_", "", rownames(hylids)))

require(ggplot2)
ggplot(humming, aes(x = elev.hu, y = rowSums(humming[,1:50]))) + geom_path()

## Function to permute ranges
permute_range <- function(data){
  elev <- as.numeric(gsub("Elev_", "", rownames(data)))
  # Calculate range sizes for each species
  rangeSize <- colSums(data)
  # Create matrix to fill with new ranges
  new.ranges <- matrix(nrow = length(elev), ncol = length(rangeSize))
  # For loop to shift range for each species
  for(i in 1:length(rangeSize)){
    perm.mat <- matrix(0,nrow = length(elev), ncol = 1)
    upperlim <- length(elev) - rangeSize[i]
    start <- sample(c(1:upperlim), 1)
    perm.mat[start:(start+rangeSize[i]), ] <- 1 
    new.ranges[,i] <- perm.mat
  }
  return(list(ranges = new.ranges, tot.num = rowSums(new.ranges)))
}

## Testing the permute_range function
p1 <- permute_range(humming)
test <- data.frame(elev = elev.hu, p1)
ggplot(test, aes(x = elev, y = rowSums(test[,2:51]))) + geom_path()


## Function to wrap the permute function across any number of permutations
wrapper <- function(n, data){
  p.ranges <- matrix(nrow = n, ncol = nrow(data))
  for(i in 1:n){
    numSpec <- permute_range(data)$tot.num
    p.ranges[i,] <- numSpec
  }
  return(p.ranges)
}

## Hummingbird
test <- wrapper(5000, humming)
boxplot(test)
points(1:25, rowSums(humming), typ = "l", col = "blue")

#get quantiles
quant.hu <- apply(test, 2, quantile, probs = c(.025, .975))
q.dat <- melt(data.frame(t(quant.hu)))
q.dat2 <- cbind(q.dat, num=rep(1:25, 2))

## Make it pretty with ggplot2
colnames(test) <- elev.hu
mtest <- melt(test, id.vars = colnames(test))
g <- ggplot(mtest, aes(x = factor(Var2), y = value)) + geom_boxplot()
g <- g + geom_path(data = humming, aes(x = 1:25, y = rowSums(humming[,1:50])), col = "blue")
g <- g + geom_point(data = humming, aes(x = 1:25, y = rowSums(humming[,1:50])), col = "blue", size = 3)
g + geom_line(data = q.dat2, aes(x=num, y = value, col = variable))


## Hylids
test2 <- wrapper(5000, hylids)
boxplot(test2)
points(1:25, rowSums(hylids), typ = "l", col = "blue")

#get quantiles
quant.hy <- apply(test2, 2, quantile, probs = c(.025, .975))
q.dat.hy <- melt(data.frame(t(quant.hy)))
q.dat2.hy <- cbind(q.dat.hy, num=rep(1:25, 2))


## Make it pretty with ggplot2
colnames(test2) <- elev.hu
mtest2 <- melt(test2, id.vars = colnames(test2))
g <- ggplot(mtest2, aes(x = factor(Var2), y = value)) + geom_boxplot()
g <- g + geom_path(data = hylids, aes(x = 1:25, y = rowSums(hylids[,1:50])), col = "blue")
g <- g + geom_point(data = hylids, aes(x = 1:25, y = rowSums(hylids[,1:50])), col = "blue", size = 2)
g + geom_line(data = q.dat2.hy, aes(x=num, y = value, col = variable))