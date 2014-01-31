Borrelli Week 1 Notes
========================================================  


```r
opts_chunk$set(comment = NA)
```


Exercise 1 - Normal
--------------------------------------------------------  

Drawing 1000 samples of 100 randomly drawn values from a normal

```r
samples <- matrix(nrow = 1000, ncol = 100)
for (i in 1:1000) {
    samples[i, ] <- rnorm(100, 1, 3)
}

meansSAMPLE <- rowMeans(samples)
```

  
Bootstrapping 

```r
norm1 <- rnorm(100, 1, 3)
boot <- matrix(nrow = 1000, ncol = 100)
for (i in 1:1000) {
    boot[i, ] <- sample(norm1, 100, replace = T)
}

meansBOOT <- rowMeans(boot)
```


Plot the histograms

```r
hist(meansBOOT, border = "red", main = NA, lwd = 3)
abline(v = mean(meansBOOT), col = "red", lwd = 2)
hist(meansSAMPLE, border = "blue", add = T, main = NA, lwd = 3)
abline(v = mean(meansSAMPLE), col = "blue", lwd = 2)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

  

Exercise 2 - Uniform
--------------------------------------------------------    
Drawing 1000 samples of 100 randomly drawn values from a uniform

```r
samples2 <- matrix(nrow = 1000, ncol = 1000)
for (i in 1:1000) {
    samples2[i, ] <- runif(1000, 0, 5)
}

maxSAMPLE <- apply(samples2, 1, max)
```

  
Bootstrapping 

```r
unifsampl <- runif(1000, 0, 5)
boot2 <- matrix(nrow = 1000, ncol = 1000)
for (i in 1:1000) {
    boot2[i, ] <- sample(unifsampl, 1000, replace = T)
}

maxBOOT <- apply(boot2, 1, max)
```


Plot the histograms

```r
hist(maxSAMPLE, border = "blue", main = NA, lwd = 3)
hist(maxBOOT, border = "red", add = T, lwd = 3)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 

  
Probability of getting the largest value in original in the bootstrapped sample
$$
\LARGE{
1 - (1 - \frac{1}{n})^n
}
$$
  
so bootstrap is not very good with __extreme__ values  

  
Exercise 3 - Cauchy  
--------------------------------------------------------  
  

```r
hist(rcauchy(1000, 1, 2))
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 


Drawing 1000 samples of 100 randomly drawn values from a cauchy

```r
samples3 <- matrix(nrow = 1000, ncol = 1000)
for (i in 1:1000) {
    samples3[i, ] <- rcauchy(1000, 1, 2)
}

varSAMPLE <- apply(samples3, 1, var)
```

  
Bootstrapping 

```r
cauchysampl <- rcauchy(1000, 1, 2)
boot3 <- matrix(nrow = 1000, ncol = 1000)
for (i in 1:1000) {
    boot3[i, ] <- sample(cauchysampl, 1000, replace = T)
}

varBOOT <- apply(boot3, 1, var)
```


Plot the histograms

```r
hist(varSAMPLE, border = "blue", main = NA, lwd = 3, freq = F)
hist(varBOOT, border = "red", lwd = 3, add = T, freq = F)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 

