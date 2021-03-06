Title
========================================================


```r
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```r
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
setwd("~/R/PermuteSeminar/PermuteSeminar-2014/Null models")
data = read.csv("Hummingbirds.csv")

# Convert Elevations to Numeric... pointless
data$Elevation <- as.numeric(gsub(pattern = "Elev_", replacement = "", x = data$Elevation))

# get widths of ranges from data
ranges = as.numeric(colSums(data[, 2:ncol(data)]))

# number of species to fit
reps = 1e+05

# create a mountain to put them on
mountain <- matrix(nrow = nrow(data), ncol = reps)
for (i in 1:reps) {
    sp.range = sample(x = ranges, size = 1)
    potential.range = nrow(data) - sp.range
    boundary = sample(1:potential.range, 1)
    mountain[boundary:(boundary + sp.range), i] = 1
    
}
richness = rowSums(mountain, na.rm = TRUE)
```


```
## Using  as id variables
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 





```r
setwd("~/R/PermuteSeminar/PermuteSeminar-2014/Null models")
data = read.csv("hylids.csv")

# Convert Elevations to Numeric... pointless
data$Elevation <- as.numeric(gsub(pattern = "Elev_", replacement = "", x = data$Elevation))
data = data[order(data$Elevation), ]

# get widths of ranges from data
ranges = as.numeric(colSums(data[, 2:ncol(data)]))

# number of species to fit
reps = 1e+05

# create a mountain to put them on
mountain <- matrix(nrow = nrow(data), ncol = reps)
for (i in 1:reps) {
    sp.range = sample(x = ranges, size = 1)
    potential.range = nrow(data) - sp.range
    boundary = sample(1:potential.range, 1)
    mountain[boundary:(boundary + sp.range), i] = 1
    
}
richness = rowSums(mountain, na.rm = TRUE)
```


```r
df = data.frame(sim = richness/sum(richness), real = (rowSums(data[2:ncol(data)])/sum(rowSums(data[2:ncol(data)]))))
df = melt(df)
```

```
## Using  as id variables
```

```r

ggplot(df, aes(x = rep(1:25, 2), y = value, color = variable)) + geom_line() + 
    labs(y = "relative Richness")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

