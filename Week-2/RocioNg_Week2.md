Title
========================================================

This is an R Markdown document. Markdown is a simple formatting syntax for authoring web pages (click the **MD** toolbar button for help on Markdown).

When you click the **Knit HTML** button a web page will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

read the file


```r
data <- read.csv("ClutchSize.csv")
clutch <- c(data$Clutch_size)
```



```r
hist(data$Clutch_size)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 

```r
fitdistr(data$Clutch_size, "gamma")
```

```
## Error: could not find function "fitdistr"
```

```r
ks.test(x = data$Clutch_size, )  # finsih 
```

```
## Error: argument "y" is missing, with no default
```


by species

```r
boot_species <- c()
for (i in 1:1000) {
    sample <- sample(clutch, nrow(data), replace = T)
    boot_species[i] <- mean(sample)
}
```

Vizualization

```r
library("ggplot2")
qplot(boot_species)
```

```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


