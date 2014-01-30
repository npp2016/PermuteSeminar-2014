Borrelli Week 1 Notes
========================================================



```r
samples <- matrix(nrow = 1000, ncol = 100)
for (i in 1:1000) {
    samples[i, ] <- rnorm(100, 1, 3)
}

meansSAMPLE <- rowMeans(samples)

boot <- matrix(nrow = 1000, ncol = 100)
for (i in 1:1000) {
    boot[i, ] <- sample(norm1, 100, replace = T)
}
```

```
## Error: object 'norm1' not found
```

```r

meansBOOT <- rowMeans(boot)

hist(meansBOOT)
```

```
## Error: invalid number of 'breaks'
```

```r
hist(meansSAMPLE, add = T)
```

```
## Error: plot.new has not been called yet
```

