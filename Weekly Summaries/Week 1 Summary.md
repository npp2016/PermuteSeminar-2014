Week #1 Summary
========================================================

What we did:
-------------
1. Installed GitHub and introduced how to use a GitHub repository
2. Reviewed the non-parametric bootstrap
3. Worked through several exercises to demonstrate the use of the bootstrap and cases where the bootstrap fails

Basic idea behind the bootstrap:

We will get into more details in the next few chapters of Efron and Tibshirani, but the basic idea behind the bootstrap is that we can generate a statistical distribution for an estimator by sampling with replacement from the original data. (Ideally, you could generate this same distribution by  simply re-doing your experiment [or collecting another random sample from the population of interest] many many times. Each new experiment would yield another estimate for the parameter of interest, and the distribution of these estimates would give you information about the bias and variance of the estimator.)

Throughout our discussion of bootstrap, we will adopt Efron & Tibshirani's notation. Our original data will be called $x$ and bootstrapped datasets will be denoted $x^{*}$. The parameter of interest will be called $\theta$, and its estimation using the actual empirical (original) data will be called $\hat{\theta}$. We can use each bootstrapped dataset $x^{*}$ to calculate the bootstrapped estimate $\hat{\theta^{*}}$. Generally speaking, and in a way that will become clear over the next few weeks, bootstrapping 'works' if the distribution of the bootstrapped estimator relative to the original empirical estimate converges to that of the empirical estimate relative to the true population value

$$
\hat{\theta^{*}}-\hat{\theta} \rightarrow \hat{\theta}-\theta
$$

In the Week #1 seminar, we worked through three case studies to demonstrate both bootstrap 'working' and bootstrap 'failing'.

Case Study #1: When bootstrap works
----------------------------

To demonstrate bootstrap working, we did two things:

1. We drew 100 samples from 

$$
X \sim N(\mu=1,\sigma=3)
$$

and calculated the sample mean of each. This simulates doing the experiment 100 times (something we can rarely do in practice).

2. We drew 1 sample from 

$$
X \sim N(\mu=1,\sigma=3)
$$

and then created 99 bootstrapped replicates of the original dataset (so the original plus the 99 bootstrapped samples is equivalent to the 100 samples from the true underlying population). We then calculated the sample mean of each of these samples (one original+99 bootstrapped). 

To the extent to which these two distributions are approximately the same, and become more similar as the sample size increases, is a measure of whether bootstrapping has 'worked'. 

I show some example code below (slightly edited for formatting), in part to demonstrate some of the ways in which different people write code for the very same exercise (even when, in this case, the exercise is quite straightforward). [NB: Most people drew 100 bootstrapped datasets, as opposed to 99 bootstrapped datasets to add to the original empirical dataset. In practice, I don't think it matters, but we can certainly discuss this...]

From Jon Borrelli:

Exercise 1 - Normal

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

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 



From Ben Weinstein:



```r
# Seminar 1 - Bootstrap test
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```r

# Repeat the experiment 1000 times
global_means <- replicate(1000, mean(rnorm(100, mean = 1, sd = 3)))  #HJL: Changed mean to 1
hist(global_means)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-41.png) 

```r

# make a dataframe
draws <- data.frame(d = global_means)

# 1000 bootstrap replicates of 1 experiment
j <- rnorm(100, mean = 1, sd = 3)  #HJL: Changed mean to 1
b <- replicate(1000, mean(sample(j, replace = TRUE)))

boots <- data.frame(b = b)

# compare histograms
ggplot() + geom_histogram(data = draws, aes(x = d), fill = "blue") + geom_histogram(data = boots, 
    aes(x = b), fill = "red", alpha = 0.4)
```

```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-42.png) 



If you run this several times, you'll notice that the two histograms are not always right on top of one another. As you make the sample sizes (not the number of bootstraps, but the size of the original dataset) bigger, there is closer (and more robust) correspondence between the two histograms. However, even when the bootstrap distribution is off (in the sense of shifted from the original), its variance is usually pretty close. This is good news, since we are often interested in using the standard deviation of the bootstrapped estimates to estimated an estimates standard error. This is a good illustration of the fact that bootstrap gets better as sample sizes get better (and special caution should be applied when bootstrapping small datasets).

Case Study #2: When bootstrap fails because of the sample statistic
----------------------------

One of the times when bootstrap is known to fail is when you are interested in the extremes of a distribution. To demonstrate this we worked through a classic example is which the bootstrap fails:

$$
X \sim Unif(0,5)
$$

with $\theta = max(X)$ (a.k.a. $X_{(n)}$).

From Jon Borrelli:

Exercise 2 - Uniform


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

From Ben Weinstein:


```r
# Seminar 1 - Bootstrap test
require(ggplot2)

# Repeat the experiment 1000 times
global_means <- replicate(1000, max(runif(1000, 0, 5)))
hist(global_means)
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-81.png) 

```r

# make a dataframe
draws <- data.frame(d = global_means)

# 1000 bootstrap replicates of 1 experiment
j <- runif(1000, 0, 5)
b <- replicate(1000, max(sample(j, replace = TRUE)))

boots <- data.frame(b = b)

# compare histograms

ggplot() + geom_histogram(data = draws, aes(x = d), fill = "blue") + geom_histogram(data = boots, 
    aes(x = b), fill = "red", alpha = 0.4)
```

```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

```
## Warning: position_stack requires constant width: output may be incorrect
## Warning: position_stack requires constant width: output may be incorrect
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-82.png) 

```r

ggplot() + geom_density(data = draws, aes(x = d), fill = "blue") + geom_density(data = boots, 
    aes(x = b), fill = "red", alpha = 0.4)
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-83.png) 


Case Study #3: When bootstrap fails because the distribution has ill defined moments
----------------------------

One of the other times when bootstrap is known to fail is when you have a distribution will is poorly behaved, which is to say that it has moments that are ill defined. We demonstrated this with a classic porrly-behaved distribution, the Cauchy distribution (which has an undefined mean and variance)[The parameters are fairly arbitrary here]:

$$
X \sim Cauchy(1,2) 
$$

with $\theta = var(X)$.

I've included Jon and Ben's code below, but because the Cauchy is so pathalogical, the histograms aren't much use. Its better to just play around with the code to get a sense for what's going on.

From Jon Borrelli:


```r
hist(rcauchy(1000, 1, 2))
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


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

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 


From Ben Weinstein:


```r
# Probability that the max value is the final dataset If we have 1000
# values, there is one max value

require(ggplot2)

# Repeat the experiment 1000 times
global_means <- replicate(1000, var(rcauchy(1000, 1, 2)))
hist(global_means)
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-131.png) 

```r


# make a dataframe
draws <- data.frame(d = global_means)

# 1000 bootstrap replicates of 1 experiment
j <- cauchy(1000, 1, 2)
```

```
## Error: could not find function "cauchy"
```

```r
b <- replicate(1000, var(sample(j, replace = TRUE)))

boots <- data.frame(b = b)

# compare histograms

ggplot() + geom_histogram(data = draws, aes(x = d), fill = "blue") + geom_histogram(data = boots, 
    aes(x = b), fill = "red", alpha = 0.4)
```

```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-132.png) 

```r

ggplot() + geom_density(data = draws, aes(x = d), fill = "blue") + geom_density(data = boots, 
    aes(x = b), fill = "red", alpha = 0.4)
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-133.png) 



References:
-----------------

For more information about Week #1's topics, a few helpful references are:

Athreya, K.B. 1987. Bootstrap of the mean in the infinite variance case. The Annals of Statistics 15(2): 724-731.

Bickel, P.J., and D. A. Freedman. 1981. Some asymptotic theory for the bootstrap. The Annals of Statistics 9(6): 1196-1217.
