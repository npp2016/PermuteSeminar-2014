Week #2 Summary
========================================================

From Last week:
----------------
In order read a file (such as .csv) on Rmarkdown on Github
>>Install the RCurl package and the getURL() function

example:

```r
require(RCurl)
```

```
## Loading required package: RCurl
```

```
## Warning: package 'RCurl' was built under R version 3.0.2
```

```
## Loading required package: bitops
```

```r
raw <- getURL("https://raw.github.com/PermuteSeminar/PermuteSeminar-2014/master/Week-2/ClutchSize.csv")
```

```
## Error: SSL certificate problem, verify that the CA cert is OK. Details:
## error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed
```

```r

# make sure to use the url corresponding to the raw file

clutch <- read.csv(text = raw)
```

```
## Error: invalid 'text' argument
```


<br/>

Lecture Notes
==============
Bootstrapping Time Series
-------------------------

use data without knowing the underlying proability distircution
use emperical distribution to understand distribution of statistic(mean, variance, etc)
sample with replacement from original * indicate resampled item.  
resampled population should equal number of samples

use standard deviation of replications to estimate standard error

emperical distribution  to recreate distribution

We discussed figure 8.1 and 8.3 from Efron and Tibshirani

An Estimated Probability Models may  be modelling a whole process that involve multiple distributions 
>> eg. flight patterns of birds

In Class Excercises
=====================

We used Lutenizing hormone from the the  example in Efron and Tibshirani
time series with some temporal stucture
the whole distirbution may be normal
AR1 process  (type in equation here with Latex**)

We used the first-order autoregressive sheme to model the data:
$$
z_{t} = \beta_{z_{t-1}} + \epsilon_{t}
$$

<br/>

$\beta$ is a unknown parameter (between -1 and 1) that can be estimated with the data


Excercises
-----------
Use dataset from book :

1. Estimate the  best $\beta$ (hat) value that minimizes error
2. Sample with replacement from random deviations or do a moving blocks bootstrap (with replacement chunks of the data)


Solutions
===========


Load the proper packages:

```r
require(RCurl)
require(ggplot2)
```

```
## Loading required package: ggplot2
```


Upload the Data:

```r
hormone <- read.csv("hormone_data.csv")


rawURL <- getURL("https://raw.github.com/PermuteSeminar/PermuteSeminar-2014/master/Week-4/hormone_data.csv")
```

```
## Error: SSL certificate problem, verify that the CA cert is OK. Details:
## error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed
```

```r
# hormone <- read.csv(text = rawURL)

head(hormone)
```

```
##   period level
## 1      1   2.4
## 2      2   2.4
## 3      3   2.4
## 4      4   2.2
## 5      5   2.1
## 6      6   1.5
```


Plot the Data:

```r
ggplot(hormone, aes(x = period, y = level)) + geom_line()
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


Estimating $\hat{\beta}$:
==========================

The idea was to use:
$$
RSE(b) =  \sum_{t=U}^{V} (z_{t} - b{z}_{t-1})^{2}
$$

and find the value of b that minimizes RSE 


Two methods:
-------------

Adapted From John Borelli:

Calculate $z_t$ from each set of data points:  $z_{t} = y_{t} - \hat{y}$ where $\hat{y}$ is the average of data


```r
z.t <- hormone$level - mean(hormone$level)  #creates a vector of all the differences
```



Create a function that calculates RSE for each value of b

```r
rse <- function(zt, b) {
    est.b <- c()
    for (i in 1:length(b)) {
        res <- c()
        for (j in 2:length(zt)) {
            res[j - 1] <- (zt[j] - b[i] * zt[j - 1])^2
        }
        est.b[i] <- sum(res)
    }
    bhat <- b[which.min(est.b)]
    return(bhat)
}
```


Run the function and get bhat

```r
best <- seq(-1, 5, 0.001)  #generates numbers between -1 
guess <- rse(z.t, best)  #runs the above function to find the right value of b
```


So our estimate of $\hat{\Beta}$ is **0.586**




refit data and get new beta estimates

Next week
-------------
Randomization and Permutation
>>Note: These will be used interchangeably. (Some people use permutations to imply sampling all possible permutations)
<br/>
Read Ch 15 and handouts, and paper for next week
>> Note: Get in touch with Heather about working with your own datasets!!
