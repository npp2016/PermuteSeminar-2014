Mid-domain Effect
========================================================



```r
elev <- read.csv("Null models/Hummingbirds.csv")
```

```
## Warning: cannot open file 'Null models/Hummingbirds.csv': No such file or
## directory
```

```
## Error: cannot open the connection
```

```r

elev$Elevation <- as.numeric(gsub("Elev_", "", elev$Elevation))
```

```
## Error: object 'elev' not found
```



```r
plot(elev$Elevation)
```

```
## Error: object 'elev' not found
```


Elevation richness

```r
elvR <- data.frame(elev$Elevation, apply(elev[, -1], 1, sum))
```

```
## Error: object 'elev' not found
```

```r
plot(elvR)
```

```
## Error: object 'elvR' not found
```


Find elevation range for each species


```r
require(vegan)
```

```
## Loading required package: vegan
## Loading required package: permute
## Loading required package: lattice
## This is vegan 2.0-9
```

```r

siteXspp <- elev[, -1]
```

```
## Error: object 'elev' not found
```

```r

plot(siteXspp[, 3])
```

```
## Error: object 'siteXspp' not found
```


Create a function to shift species left of right, given their range size


```r

siteXspp[, x]
```

```
## Error: object 'siteXspp' not found
```

```r
slots <- rle(a)
```

```
## Error: object 'a' not found
```

```r

# choose available holes
rang <- seq(-slots$length[[1]], slots$length[[3]], 1)
```

```
## Error: object 'slots' not found
```

```r

# choose random shift
shift <- sample(rang, 1)
```

```
## Error: object 'rang' not found
```

```r

slots$length[[1]] <- slots$length[[1]] + shift
```

```
## Error: object 'slots' not found
```

```r

slots$length[[3]] <- slots$length[[3]] + shift
```

```
## Error: object 'slots' not found
```

```r

inverse.rle(slots)
```

```
## Error: object 'slots' not found
```

