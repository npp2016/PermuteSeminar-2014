Week 6: Markov Chain Monte Carlo, chain convergence, & more 
===========================================================
Part 1: reviewing the dolphin permutation problem with swapping
---------------------------------------------------------------
We first reviewed our code that we were to have preprared for class that involved a functioning permutation script using with the dolphin data from Manly (1995). (See the end of week 5 for details on the problem). It seemed that everyone was on the same page in terms of having a working code in terms fo being able to swap the matrices.

Having a functioning swap and permute algorithm was critical to extend for MCMC chain convergence. For this week's summary, I will show what we did using Jon Borelli's code.

Part 2: Markov Chain Monte Carlo overview and discussion
-----------------------------------------------------
Heather provided a background on MCMC searches and chain convergence using slides written by Patrick Lim from Harvard (http://www.people.fas.harvard.edu/~plam/teaching/methods/convergence/convergence_print.pdf). THe main segway in this topic was from the dolphin project, in that an MCMC is searching association matrices based on the previous matrix swap. The point is that each next search is closely related to the search before it. 

First I will summarize chain diagnostics from the lecture and then show the code and plots to diagnose convergence of an MCMC chain using our dolphin data. 

Chain Diagnostics:  
*The "convergence" of the chain occurs when the sampling reaches a stable distribution.  
*If you would like to examine convergence diagnositics the "coda" package in R is good or there is a GUI program "tracer" in which you load traceplots into and can visualize.  
*Converence can be visualized with a trace plot. If the traceplot looks very jagged and does not have a solid median ("hairy caterpillar look"), then the sampling has not converged and has gotten stuck in parameter space when sampling. The "hairy caterpillar" look can be a good thing.  
*We also disscussed burn-in. There is a general acceptance of discarding a proportion of the initial sampling of parameter space.  

*A fundamental question from this discussion: How many pair-switches do we need to feel like we sampled the space? For example: do we make 3 chains, each with length 400, and have a burn-in of 200 (keeping the last 200 of each chain) OR we have one chain of 1200 with 50% burn-in. Which is more informative?  

Part 3: Gelman-Rubin Multiple Sequence Diagnostic
-----------------------------------------------------

We then proceeded to discuss the Gelman & Rubin Diagnostic which addresses the following concepts:  
*never use multiple chains because you want to sample different parts of space  
*want to send out multiple chains so they end up in the same place  
*how much variation is within each of these chains  
*G&B quantifies within chain variances (mean of within chain variances) and then like between chain variance (just like an anova!)  

Steps (for each parameter) for GB:
1. Run m ≥ 2 chains of length 2n from overdispersed starting
values.  
2. Discard the ﬁrst n draws in each chain.  
3. Calculate the within-chain and between-chain variance.  
4. Calculate the estimated variance of the parameter as a
weighted sum of the within-chain and between-chain variance.  
5. Calculate the potential scale reduction factor.  

The GB diagnostic can be run in R. The steps involve running out multiple chains of your simulation `mcmc()`, combinining your chains into a list `mcmc.list()`, and running the GB diagnostic on the list of chains `gelman.diag() `.  

Part 4: Implementation of plotting chain convergence of dolphin data  
-----------------------------------------------------
We want to visualize the MCMC run and view if there is a convergence on an interpretable distribution.  We use Jon Borelli's code to compare short-chain and long-chain runs. We will then look at the plots and try to diagnose convergence.

```r
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```
## Warning: package 'ggplot2' was built under R version 2.15.2
```

```r
require(RCurl)
```

```
## Loading required package: RCurl
```

```
## Warning: package 'RCurl' was built under R version 2.15.2
```

```
## Loading required package: bitops
```

```r
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
url <- getURL("https://raw.githubusercontent.com/PermuteSeminar/PermuteSeminar-2014/master/Week-5/Dolphin+data.csv")
dolphins <- read.csv(text = url, row.names = 1, header = F)
colnames(dolphins) <- LETTERS[1:18]

# function for finding hwi of an association matrix
get_hwi <- function(mat) {
    hwi <- matrix(nrow = ncol(mat), ncol = ncol(mat))
    for (i in 1:ncol(mat)) {
        for (j in 1:ncol(mat)) {
            x <- sum(mat[, i] == 1 & mat[, j] == 1)
            ya <- sum(mat[, i] == 1 & mat[, j] == 0)
            yb <- sum(mat[, i] == 0 & mat[, j] == 1)
            hwi[i, j] <- x/(x + 0.5 * (ya + yb))
        }
    }
    return(hwi)
}

# this function permtes the matrix while keeping most structure intact
permutes <- function(mat, iter) {
    pattern1 <- matrix(c(0, 1, 1, 0), nrow = 2, ncol = 2)
    pattern2 <- matrix(c(1, 0, 0, 1), nrow = 2, ncol = 2)
    count <- 0
    mat.list <- list()
    hwi.list <- list()
    
    while (count < iter) {
        srow <- sample(1:nrow(mat), 2)
        scol <- sample(1:ncol(mat), 2)
        
        test <- mat[srow, scol]
        
        if (sum(test == pattern1) == 4) {
            count <- count + 1
            mat[srow, scol] <- pattern2
            mat.list[[count]] <- mat
            hwi.list[[count]] <- get_hwi(mat)
            next
        } else if (sum(test == pattern2) == 4) {
            count <- count + 1
            mat[srow, scol] <- pattern1
            mat.list[[count]] <- mat
            hwi.list[[count]] <- get_hwi(mat)
            next
        } else {
            next
        }
    }
    return(list(permuted.matrices = mat.list, hwi = hwi.list))
}

# short-chain
pdolph <- permutes(dolphins, iter = 100)
mat.ij <- t(sapply(pdolph$hwi, FUN = function(x) {
    x[which(lower.tri(x))]
}))
e.ij <- colMeans(mat.ij)


S <- c()
for (i in 1:nrow(mat.ij)) {
    top <- (mat.ij[i, ] - e.ij)^2
    bottom <- ncol(dolphins)^2
    S[i] <- sum(top/bottom)
}

# long chain
pdolph.long <- permutes(dolphins, iter = 1000)
long.mat.ij <- t(sapply(pdolph.long$hwi, FUN = function(x) {
    x[which(lower.tri(x))]
}))
e.ij <- colMeans(mat.ij)


S.2 <- c()
for (i in 1:nrow(long.mat.ij)) {
    top <- (long.mat.ij[i, ] - e.ij)^2
    bottom <- ncol(dolphins)^2
    S.2[i] <- sum(top/bottom)
}
```


Plots of the short-chain and long-chain runs.  


```r
ggplot(data.frame(S = S), aes(x = 1:100, y = S)) + geom_line()
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-21.png) 

```r
ggplot(data.frame(S.2 = S.2), aes(x = 1:1000, y = S.2)) + geom_line()
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-22.png) 


We can see in the longer chain there is convergence around a mean around 0.08. In the short-chain, we cannot identify a distribution that the sampling is converging on. It has not sampled enough space!  
