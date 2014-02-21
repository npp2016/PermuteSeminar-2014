Week 4 - Time Structured Data
========================================================

Goal 1:
====
Find beta hat eq 820 (p94), fit the time series to find beta that minimizes the total error. Validate answer in 8.22

That will give you beta hat, the best value, we still din't know the standard error

Goal 2:
====
Sample with replacement from the random deviations. Then resample using moving blocks in the autocorrelations and new time series.


Read in data


```r
dat <- read.csv("Week-4/hormone_data.csv")
```

```
## Warning: cannot open file 'Week-4/hormone_data.csv': No such file or
## directory
```

```
## Error: cannot open the connection
```


Step 1, following 8.19 - the residuals for each y values

```r
dat$z <- dat$level - mean(dat$level)
```

```
## Error: object 'dat' not found
```


Create a sequence of beta values from -1 to 1


```r
# potential betas
pB <- seq(-1, 1, 0.001)
```


Define a function that computes equation 8.20


```r

foo <- function(b, x) {
    (dat$z[x] - b * dat$z[x - 1])^2
}


bvals <- sapply(pB, function(f) {
    
    # Get the estimates for the entire time series
    vals <- sapply(2:max(dat$period), foo, b = f)
    
    # append first value to the vector
    final <- c(dat$z[1], vals)
})
```

```
## Error: object 'dat' not found
```

```r

colnames(bvals) <- pB
```

```
## Error: object 'bvals' not found
```

```r

# Sum the matrix rows
rowS <- data.frame(B = pB, RSE = apply(bvals, 2, sum))
```

```
## Error: object 'bvals' not found
```

```r

hist(rowS$RSE)
```

```
## Error: object 'rowS' not found
```

```r

# which beta value minimizes the value
B <- rowS[which.min(rowS$RSE), ]$B
```

```
## Error: object 'rowS' not found
```


Given the betahat, find the episilon 

```r
epi <- function(x) {
    dat$level[x] - (B * dat$level[x - 1])
}

# append 0 to the front.
epiVals <- c(0, sapply(2:nrow(dat), epi))
```

```
## Error: object 'dat' not found
```


Recalculate the values from resampled data


```r
# sample from that time series
resampledE <- sample(epiVals, replace = TRUE)
```

```
## Error: object 'epiVals' not found
```


Find new Z values

```r

out <- vector()

# set the code
out[1] <- 0

for (x in 2:nrow(dat)) {
    out[x] <- dat$z[x] - B * dat$z[x - 1] + epiVals[x] + out[x - 1]
}
```

```
## Error: object 'dat' not found
```


Find beta



