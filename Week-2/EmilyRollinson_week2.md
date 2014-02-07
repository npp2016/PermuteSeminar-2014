Week 2 Exercises
============
Emily Rollinson and Sarah Supp. 


1) Decide on the best distribution for the clutch size data


```r
clutch <- read.csv("ClutchSize.csv")
head(clutch)
```

```
##   Family Genus_name             Species_name Clutch_size
## 1      3   Dromaius Dromaius novaehollandiae        8.98
## 2      4    Apteryx        Apteryx australis        2.00
## 3      4    Apteryx          Apteryx haastii        1.00
## 4      4    Apteryx           Apteryx owenii        1.00
## 5      6    Ortalis           Ortalis vetula        2.88
## 6      7   Alectura         Alectura lathami       14.78
##              English_name
## 1                     Emu
## 2              Brown Kiwi
## 3      Great Spotted Kiwi
## 4     Little Spotted Kiwi
## 5        Plain Chachalaca
## 6 Australian Brush-turkey
```

```r
mean <- mean(clutch$Clutch_size)
sd <- sd(clutch$Clutch_size)
mean
```

```
## [1] 3.448
```

```r
sd
```

```
## [1] 1.889
```

```r
hist(log(clutch$Clutch_size))
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 

The distribution appears log-normal.

2) Using the statistic <i>mean clutch size</i>, compare the results of bootstrapping 3 ways:  


a) sample with replacement from species regardless of higher taxonomic information; 


```r

mean(clutch$Clutch_size)
```

```
## [1] 3.448
```

```r
n = nrow(clutch)

est = NULL
for (i in 1:1000) {
    boot = sample(clutch$Clutch_size, n, replace = TRUE)
    mean = mean(boot)
    est = append(est, mean)
}

mean(est)
```

```
## [1] 3.449
```


b) Sample with replacement from the list of families, then sample the species from that list with replacement and bootstrap the species samples.


```r
f = length(unique(clutch$Family))
est2 = NULL
for (i in 1:1000) {
    fam = sample(clutch$Family, f, replace = TRUE)
    subdat = clutch[which(clutch$Family %in% fam), ]
    boot = sample(subdat$Clutch_size, n, replace = TRUE)
    mean = mean(boot)
    est2 = append(est, mean)
}

mean(est2)
```

```
## [1] 3.449
```




c) Sample families with replacement.  Within that set of samples, sample genera with replacement.  Within this second set of samples, sample species with replacement, and create a bootstrap estimate of clutch size mean from this sampled list of species.  This may not be exactly right.


```r
f = length(unique(clutch$Family))
est3 = NULL
for (i in 1:1000) {
    fam = sample(clutch$Family, f, replace = TRUE)
    subdat = clutch[which(clutch$Family %in% fam), ]
    g = length(unique(subdat$Genus_name))
    gen = sample(subdat$Genus_name, g, replace = TRUE)
    subdat2 = subdat[which(subdat$Genus_name %in% gen), ]
    boot = sample(subdat2$Clutch_size, n, replace = TRUE)
    mean = mean(boot)
    est3 = append(est3, mean)
}

mean(est3)
```

```
## [1] 3.457
```

