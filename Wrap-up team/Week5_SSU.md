Week 5: Randomization
========================================================

Randomization is a method for formulating and testing a null hypothesis of "randomness" given a particular set of data.  In this conception, our alternative hypothesis (i.e., that there *is* some effect, difference, correlation, etc.) corresponds to a certain level of organization or structure in our data.  If this is the case, then shuffling the order of our measurements (randomizing) will destroy that structure and change the value of our test statistic.  If, on the other hand, the null hypothesis is true, and ther is *not* any structure, then reshuffling the data won't produce much change in the chosen test statistic.

A randomization test simply reshuffles the data and calculates the test statistic many times, counting what proportion of test statistics are at least as extreme as the one calculated from the original data.  The shuffling may be a simple reordering, or it may attempt to preserve certain features of the original data or the process that generated it.  One example mentioned in class was phylogenetic trees: if you just shuffle the order of species, OF COURSE you're going to get a significant result, since the process that created the species (evolution) is branching and autocorrelated.  To get meaningful significance levels, you would need to come up with a randomization scheme that preserves some of these characteristics.

Design of a randomization scheme for taxonomic relationships under the assumption of Intelligent Design is left as an exercise for the reader.


Jackal jaws
-------------
To show the idea of randomization in action, the following is a re-created example of the jackal jaws from the reading.

```r
jackals <- data.frame(mandible = c(120, 107, 110, 116, 114, 111, 113, 117, 114, 
    112, 110, 111, 107, 108, 110, 105, 107, 106, 111, 111), sex = rep(c("Male", 
    "Female"), each = 10))
boxplot(mandible ~ sex, jackals, xlab = "Sex", ylab = "Mandible length (mm)")
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 

So it definitely appears like males have larger mandibles.  But how sure are we?  For a standard statistical test of the difference in means, we can just use R's `lm()` function (this is equivalent to doing a two-sample T-test, and gives us the same p-value).

```r
mod <- lm(mandible ~ sex, jackals)
summary(mod)
```

```
## 
## Call:
## lm(formula = mandible ~ sex, data = jackals)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
##   -6.4   -1.8    0.1    2.4    6.6 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  108.600      0.974  111.49   <2e-16 ***
## sexMale        4.800      1.378    3.48   0.0026 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 3.08 on 18 degrees of freedom
## Multiple R-squared: 0.403,	Adjusted R-squared: 0.37 
## F-statistic: 12.1 on 1 and 18 DF,  p-value: 0.00265
```

```r
difference.observed <- mod$coefficients[["sexMale"]]
print(difference.observed)
```

```
## [1] 4.8
```

Looking at the results from this model, we can see that the male mandibles are
an average of 4.8 mm longer than the females,' and that we can be pretty confident this difference is real, given the small p-value (0.0026).

Now, we need to compare the observed mean effect statistic to a the distribution of mean effects from randomized samples. 
<br/>
>>First, we define a function to do the randomization: it takes a vector of data values from two groups (`x`) and an integer `k`, which says how many of the items in `x` belong to each factor/category (in our case, this will always be 10, the number of males).  The fuction shuffles the vector and assigns the first `k` values to group 1, then returns the difference beween the mean of the randomized "group 1" and "group 2."


```r
randomized.difference <- function(x, k) {
    n <- length(x)
    x.random <- sample(x, n, replace = FALSE)
    return(mean(x.random[1:k]) - mean(x.random[(k + 1):n]))
}
```


We repeat this randomizing and recalcuate the test statistic (in this case the mean effect between gender) each iteration. There are 4029 shuffles because we wanted to land on a weird number (the sum of all the divisor is greater than the number, and no subset of divisors equal the number).

```r
set.seed(70)
n.shuffles <- 4029
n.males <- sum(jackals$sex == "Male")
differences <- rep(0, n.shuffles)
for (i in 1:n.shuffles) {
    differences[i] <- randomized.difference(jackals$mandible, n.males)
}
p.rand <- (sum(differences >= difference.observed) + 1)/(n.shuffles + 1)
p.rand
```

```
## [1] 0.001985
```

The p-value given by the randomization procedure (0.002) is, as we would hope, pretty close to the one from our linear model (0.0026).  As such, we can conclude that the males are significantly different from females.
<br/>
Dolphin Association Data
------------------------
A more complicated randomization problem comes up when we try to test whether the a given dolphin individual in Porpoise Bay is more likely to associate with another dolphin individual in non-random groups (aka form non-random social groups).  Bejder et al. (1998) record their dolphin observations in a presence/absence table, where each row represents an "encounter" with a group of dolphins and each column represents a dolphin individual.  Ones or zeros indicate whether a presence and absence of a dolphin individual in a group.


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
dolphins <- as.matrix(dolphins[, 2:ncol(dolphins)])
```


### Measuring pairwise association

We want to know whether some dolphins are found together more freqently than we would expect based on random chance.  The first step is to come up with some statistic that tells us how often a given pair of dolphins are found together.  Bejder et al. (1998) use Cairns and Schwager's (1987) "half-weight index," or HWI:

\[
HWI = \frac{x}{x + y_{ab} + 0.5 (y_a + y_b)}
\]
where $x$ is the number of encounters including both dolphins a and b, $y_a$ and $y_b$ are the number of encounters with *only* dolphin a or b.   $y_{ab}$ is considering the number of groups that have both dolphin a and b at the same time.  But since this is not physically possible, it is 0.

I coded the HWI as a function:


```r
hwi <- function(a, b, m) {
  # m : co-occurrence matrix (individuals in columns, groups in rows)
  # a, b : column numbers for a pair of individuals
  both.present <- rowSums(m[ , c(a, b)]) == 2
  y.a  <- sum(m[! both.present , a]) # encounters with only a
  y.b  <- sum(m[! both.present , b]) # encounters with only b
  x <- sum(both.present)             # number of encounters with both a and b
  return(x / (x + 0.5 * (y.a + y.b)))
}
```

The line-by line explanation is as follows:


```r
both.present <- rowSums(m[, c(a, b)]) == 2
```


Going from the innermost parentheses outwards, this line selects two columns from the co-occurrence matrix corresponding to the two dolphins (`m[ , c(a, b)]`), and sums them by row (`rowSums`).  This returns a vector with 0, 1, or 2 in each cell.  The cells with "2" in them correspond to encounters with both dolphins a and b, so I use the logical operator `==` to make a boolean vector that can be used to subset the encounters in the next three lines.


```r
y.a <- sum(m[!both.present, a])
y.b <- sum(m[!both.present, b])
```


The indexing vector `! both.present` selects the rows in column `a` or `b` where *only* that dolphin is present, then adding up the number of ones in that subset to get $y_a$ and $y_b$.


```r
x <- sum(both.present)
```

This line just adds up the `TRUE`'s in `both.present` to get the number of shared encounters.

```r
return(x/(x + 0.5 * (y.a + y.b)))
```

This line calculates the HWI and returns it, ignoring $y_{ab}$ (which is =0).

### Measuring overall association
With HWI in hand, we can calculate an association number for each pair of dolphins.  But we also want some overall, "population" measure of association. Belder et al. (1998) suggests using Manly's (1995) $S$ statistic:
\[
S = \sum_{i=1}^D \sum_{j=1}^D \frac{(o_{ij} - e_{ij})^2}{D^2}
\]
where $o_{ij}$ is the HWI value for dolphins $i$ and $j$, and $e_{ij}$ is the expected value of $o_{ij}$ if associations are random.

We want to compare the observed value of $S$ to a bunch of random values in order to see how likely our data is under the null hypothesis of randomness.  To do this, we need to generate a lot of randomized data matrices. But there are a few problems:

1. We need to generate all the random matrices and $o_{ij}$'s *before* we can calculate the $e_{ij}$'s.

2. We don't want our random matrices to be *too* random, as we want to preserve the within and between group structure (i.e. we want to preseve the number of dolphins in a group and total number of times a given dolphin was observed).  To do this, they randomly selected two rows and two columns of the matrix, and if the four cells at their intersections have either of the following 2x2 matrix values, then the positions of the 1s are switched for the 0s in each row to produce the other matrix option:
>>if the matrix is:
```
0 1    
1 0
```
>>then after the swap, it becomes:
```
1 0
0 1
```
>>and vice versa
 
<br/>
This preserves the row and column sums, *BUT*...

3. Each swap only changes one 2x2 group inside the matrix, meaning that most of the HWIs will remain the same from one iteration to the next.  This method of using the randomized matrix to generate the next randomized matrix is called Markov Chain Monte Carlo. As a result of using this technique, the series of random $S$-values will be highly autocorrelated, and we will need to deal with that fact to make sure we have enough truly random samples.  For instance, you will need to make sure you have done enough iterations to end-up with a matrix that different than the original matrix.
<br/>
*Working Code for matrix swap*
<br/>
First develop a function to detect for the locations where a swap could occur

```r
swap <- function(m) {
    # Searches an encounter-individual matrix randomly for a set of four cells
    # on the corners of a rectangular sub-matrix that form a diagonal 2x2
    # matrix on their own, and swaps the diagonals.
    # 
    # Arguments: m : co-occurrence matrix (individuals in columns, groups in
    # rows) Value: The same matrix as supplied, but with the four cells
    # swapped
    while (TRUE) {
        i <- sample.int(nrow(m), 2)
        j <- sample.int(ncol(m), 2)
        
        if (all(m[i, j] == c(1, 0, 0, 1)) | all(m[i, j] == c(0, 1, 1, 0))) {
            m[i, j] <- m[i, j][2:1, ]
            return(m)
        }
    }
}

association.matrix <- function(m) {
    # Calculates the HWI for each pair of individuals across all encounters.
    # 
    # Arguments: m : co-occurrence matrix (individuals in columns, groups in
    # rows) Value: A square association matrix, with the upper triangle filled
    # with HWIs between each pair of individuals.  The lower triangle is all
    # zeros.
    D <- ncol(m)
    result <- matrix(0, D, D)
    for (i in 1:D) {
        for (j in i:D) {
            result[i, j] <- hwi(i, j, m)
        }
    }
    return(result)
}

S <- function(assoc.mat, e.mat) {
    # Calculate the S-statistic from an association matrix and its expected
    # value.
    # 
    # Arguments: assoc.mat : the association matrix e.mat : the matrix of
    # expexted HWIs Value: The association matrix's S-statistic
    D <- nrow(assoc.mat)
    # don't have to worry about the upper triangle, since the lower one is all
    # zeros
    sum((assoc.mat - e.mat)^2)/D^2
}

randomized.S <- function(m, n.swaps) {
    # This function doesn't run any faster than the loop below, but uses a lot
    # less memory because it dosn't store all the intermediate association
    # matrices.  Because it calculates the mean HWI matrix (e.matrix) on the
    # fly, there needs to be a burn-in period for e.matrix to converge to its
    # mean
    D <- ncol(m)
    e.matrix <- matrix(0, D, D)
    S.trace <- rep(0, n.swaps)
    
    for (i in 1:n.swaps) {
        o.matrix <- association.matrix(m)
        e.matrix <- e.matrix + o.matrix
        S.trace[i] <- S(o.matrix, e.matrix/i)
        m <- swap(m)
    }
    return(S.trace)
}
```

Use the functions to perform the permutation of the S statistic

```r
library(gdata)
```

```
## gdata: read.xls support for 'XLS' (Excel 97-2004) files ENABLED.
## 
## gdata: read.xls support for 'XLSX' (Excel 2007+) files ENABLED.
## 
## Attaching package: 'gdata'
## 
## The following object(s) are masked from 'package:stats':
## 
##     nobs
## 
## The following object(s) are masked from 'package:utils':
## 
##     object.size
```

```r
library(plyr)
image(dolphins)
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-121.png) 

```r

image(dolphins == swap(dolphins))  #shows the code works
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-122.png) 

```r

m <- dolphins
D <- ncol(m)
n.swaps <- 1000
stack <- array(0, c(D, D, n.swaps))

for (i in 1:n.swaps) {
    stack[, , i] <- association.matrix(m)
    m <- swap(m)
}

e.matrix <- aaply(stack, c(1, 2), mean)
S.trace <- aaply(stack, 3, S, e.mat = e.matrix)
plot(S.trace, ty = "l")
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-123.png) 

```r

acf(S.trace, 100)
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-124.png) 

```r
acf(diff(S.trace), 40)
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-125.png) 

```r

o.matrix.observed <- association.matrix(dolphins)
S.observed <- S(o.matrix.observed, e.matrix)

S.observed
```

```
## [1] 0.005534
```

```r
burn.in <- 500
sum(S.trace[burn.in:n.swaps] >= S.observed)/(n.swaps - burn.in)
```

```
## [1] 0.856
```

<br/>
Readings:
---------

Bejder, L., D. Fletcher, and S. BrÄger. 1998. A method for testing association patterns of social animals. Animal behaviour 56:719–725.
<br/>
Manly, B. F. 1995. A note on the analysis of species co-occurrences. Ecology:1109–1115.

