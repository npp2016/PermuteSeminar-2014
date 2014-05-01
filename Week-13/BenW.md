Week 13
========================================================

Read in data


```r
a <- read.csv("Week-13/Svoboda_Supp_T2_longform.csv", row.names = 1)
```

```
## Warning: cannot open file 'Week-13/Svoboda_Supp_T2_longform.csv': No such
## file or directory
```

```
## Error: cannot open the connection
```

```r

env <- read.csv("Week-13/Svoboda_T2_csv.csv")
```

```
## Warning: cannot open file 'Week-13/Svoboda_T2_csv.csv': No such file or
## directory
```

```
## Error: cannot open the connection
```

```r

# reformat matrix
require(reshape)
```

```
## Loading required package: reshape
## Loading required package: plyr
## 
## Attaching package: 'reshape'
## 
## The following objects are masked from 'package:plyr':
## 
##     rename, round_any
```

```r

envA <- data.frame(colsplit(env$X, c("_"), c("ecosystem", "site")), env)
```

```
## Error: object 'env' not found
```

```r

# Swamp pools for Ben

dat <- a[a$ecosystem == "Swamp", ]
```

```
## Error: object 'a' not found
```

```r

require(reshape)
```


Using the anosim function in vegan to compare rank dis.

```r

data(dune)
```

```
## Warning: data set 'dune' not found
```

```r
data(dune.env)
```

```
## Warning: data set 'dune.env' not found
```

```r
dune.dist <- vegdist(dune)
```

```
## Error: could not find function "vegdist"
```

```r
attach(dune.env)
```

```
## Error: object 'dune.env' not found
```

```r
dune.ano <- anosim(dune.dist, Management)
```

```
## Error: could not find function "anosim"
```

```r
summary(dune.ano)
```

```
## Error: object 'dune.ano' not found
```

```r
plot(dune.ano)
```

```
## Error: object 'dune.ano' not found
```


Make our data look like his data


```r
require(reshape)

dat.f <- t(cast(dat, Taxon ~ site + pool))
```

```
## Error: object 'dat' not found
```

```r
dist.all <- vegdist(dat.f)
```

```
## Error: could not find function "vegdist"
```

```r
distA <- melt(as.matrix(dist.all))
```

```
## Error: object 'dist.all' not found
```

```r

# split columns back out
reformat1 <- data.frame(distA, colsplit(distA$X1, "_", c("siteTo", "poolTo")))
```

```
## Error: object 'distA' not found
```

```r

reformat2 <- data.frame(reformat1, colsplit(distA$X2, "_", c("siteFrom", "poolFrom")))
```

```
## Error: object 'reformat1' not found
```

```r


ggplot(reformat2, aes(y = value, x = factor(poolTo), col = factor(poolTo))) + 
    geom_boxplot() + facet_grid(~siteTo)
```

```
## Error: could not find function "ggplot"
```






