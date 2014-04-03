Week 8 Summary
==============


Loosmore and Ford (2006)
========================
A common way to test for differences between an observed point pattern and a null model (often CSR) is to generate a large number of random point patterns, calculate a statistic such as Ripley's K for all patterns, and compare the observed to the distribution of values under the null mode. Often if the observed is outside the 95th percentile of this 'envelope' at some distance, then it is reported that the pattern significantly deviated from the null at that distance. However this is incorrect as, over the range of distances for which the statistic is calculated, multiple comparisons are actually being made. In the Loosmore and Ford paper, they report that for their simulated data, the type 1 error rate using this method would actually be 0.74, rather than the assumed 0.1. As the statistics calculated at each distance are not independent it is not sufficient to use a correction factor such as the Bonferroni correction.

They suggest a goodness-of-fit test to test for differences between observed and null models by reducing the patterns to a single statistic, and comparing the rank of the observed statistic to the simulations. This reduces the number of caparisons being made and provides the correct type 1 error rate. They also provide a method to calculate uncertainty in the p value estimated.


Examples of Spatial Stats Using Seal Data
==========================================

```r
library(spatstat)
```



```
## Error: there is no package called 'igraph'
```

```
## Error: there is no package called 'gridExtra'
```


Loading the data
----------------


```r
avian <- read.table("c:\\R\\AVIA_table.txt", sep = ",", col.names = c("lat", 
    "lon"))
```

```
## Warning: cannot open file 'c:\R\AVIA_table.txt': No such file or directory
```

```
## Error: cannot open the connection
```

```r
paulet <- read.table("c:\\R\\Paulet_table.txt", sep = ",", col.names = c("lat", 
    "lon"))
```

```
## Warning: cannot open file 'c:\R\Paulet_table.txt': No such file or
## directory
```

```
## Error: cannot open the connection
```


The data points are in a geographic coordinate system (lat,lon) with a unit of decimal degrees. To work with meters these points need to be in a projected coordinate system. This can be done using `spTransform` from the package `rgdal`, requiring the geographic coordinate system, and a suitable projected system. Polar Stereographic is appropriate for these latitudes.

```r
library(rgdal)
```

```
## Error: there is no package called 'rgdal'
```

```r

coordinates(avian) <- ~lon + lat
```

```
## Error: object 'avian' not found
```

```r
proj4string(avian) <- CRS("+proj=longlat +ellps=WGS84")
```

```
## Error: could not find function "CRS"
```

```r
avian <- as.data.frame(spTransform(avian, CRS("+proj=stere  +units=m +ellps=WGS84")))
```

```
## Error: could not find function "spTransform"
```

```r

coordinates(paulet) <- ~lon + lat
```

```
## Error: object 'paulet' not found
```

```r
proj4string(paulet) <- CRS("+proj=longlat +ellps=WGS84")
```

```
## Error: could not find function "CRS"
```

```r
paulet <- as.data.frame(spTransform(paulet, CRS("+proj=stere  +units=m +ellps=WGS84")))
```

```
## Error: could not find function "spTransform"
```


Creating a point pattern object with `spatstat`
------------------------------------------
`spatstat` has a function `ppp()` which takes a vector of x coordinates, a vector of y coordinates, and a window which defines the boundaries of the point process. The function returns an object of class `ppp` which can be analysed using spatial statistics in `spatstat`.
To create the window we took a convex hull of the points, either using..
- `chull {chull}`
- `convex.hull {igraph}`
- `convexhull {spatstat}`


```r
avianBoundary = convex.hull(as.matrix(avian))$rescoords
```

```
## Error: could not find function "convex.hull"
```

```r
avian.ppp = ppp(avian$lon, avian$lat, poly = list(x = rev(avianBoundary[, 1]), 
    y = rev(avianBoundary[, 2])))
```

```
## Error: object 'avianBoundary' not found
```



```
## Error: object 'avianBoundary' not found
```




```r
pauletBoundary = convex.hull(as.matrix(paulet))$rescoords
```

```
## Error: could not find function "convex.hull"
```

```r
paulet.ppp = ppp(paulet$lon, paulet$lat, poly = list(x = rev(pauletBoundary[, 
    1]), y = rev(pauletBoundary[, 2])))
```

```
## Error: object 'pauletBoundary' not found
```



```
## Error: object 'pauletBoundary' not found
```

```
## Error: could not find function "grid.arrange"
```



However this convex hull includes a lot of space in which there are no seals, probably due to the terrain rather than a second order point interaction. In this case simulating a Poisson point process over the whole window would be inappropriate, as we know that the intensity of the process varies over the window. This leads to a problem called 'virtual clustering' where points appear to be under-dispersed in statistics such as Ripleys K, while the points may actually be distributed completely randomly within the available space. A more appropriate null would be to simulate a PPP in the region that is actually available to seals. 
>see 'Handbook of Spatial Point-Pattern Analysis in Ecology'. Wiegand, Thorsten, and Kirk A. Moloney. CRC Press, 2013. pg 121

This was dealt with by sub-setting the data into regions where the intensity appeared to be constant, either through selecting a smaller window, or by selecting a subset of the points and fitting a convex hull to those points.


```r
avianSub <- avian[which(avian$lon < -7967000), ]
```

```
## Error: object 'avian' not found
```

```r
avianSubBoundary = as.data.frame(convex.hull(as.matrix(avianSub))$rescoords)
```

```
## Error: could not find function "convex.hull"
```

```r


avianSub.ppp = ppp(avianSub$lon, avianSub$lat, poly = list(x = rev(avianSubBoundary[, 
    1]), y = rev(avianSubBoundary[, 2])))
```

```
## Error: object 'avianSubBoundary' not found
```


```r
pauletSub <- paulet[which(paulet$lat < -18230000 & paulet$lon > -7540000), ]
```

```
## Error: object 'paulet' not found
```

```r
pauletSubBoundary = as.data.frame(convex.hull(as.matrix(pauletSub))$rescoords)
```

```
## Error: could not find function "convex.hull"
```

```r


pauletSub.ppp = ppp(pauletSub$lon, pauletSub$lat, poly = list(x = rev(pauletSubBoundary[, 
    1]), y = rev(pauletSubBoundary[, 2])))
```

```
## Error: object 'pauletSubBoundary' not found
```



```
## Error: object 'pauletSubBoundary' not found
```

```
## Error: object 'avianSubBoundary' not found
```

```
## Error: could not find function "grid.arrange"
```


There are several other options for dealing with heterogeneity, such as:
- **Heterogeneous Poisson Process with Nonparametric Intensity Estimate** - Non-parametric kernel estimates of the intensity function are used in reconstructing the point process acting as a null model. Deviations from the statistics expected under the non-stationary PPP then indicate interactions between points (at distances less than the bandwidth of the kernel)

- **Heterogeneous Poisson Process with Parametric Intensity Estimate** - The heterogeneous Poisson process can also be characterized using parametrically estimated intensity functions. This requires additional environmental covariates and if misspecified can result apparent departures from CSR at larger distances. Estimating the parameters of the intensity function is the basis of habitat suitability modelling.


---



```
## Error: could not find function "grid.arrange"
```

> A demonstration of virtual clustering. In the first example a Poisson point process has been generate with intensity 300 (300 points within 1x1 area). Ripley's K for this plot closely matches the expect under CSR and is well within the limits of the envelope created by calculating Ripleys K from 99 simulated Poisson Point Processes ($\lambda=300$) within the 1x1 window. In the second example the same points are used but the window is extended beyond the limits of the PPP. When Ripleys K is caluclated there appears to be clustering at all scales, when actually there is no interaction between points in the region where the PPP operates. In the third example the points are generated from two poisson point process (blue intensity = 300, red intensity = 100). Ripleys K again show clustering at all scales, despite the points being randomly distributed.

---

---



Calculating Spatial Statistics with `spatstat`
----------------------------------------------

A range of spatial statistics are available in `spatstat`. To analyse the seal data we used second-order statistics which deal with distances between points. First-order statistics deal with the intensity of points in a point process. The statistics that were used were:

- `Kest()` - Estimates Ripley's reduced second moment function K(r) from a point pattern in a window of arbitrary shape.
- `Gest()` - Estimates the nearest neighbor distance distribution function G(r) from a point pattern in a window of arbitrary shape.

These statistics are calculated from all points and are expected to represent the typical point, however we can get an estimate of the variability between points, and use this to construct confidence intervals for our statistic.
- `varblock` - estimates the variance of any summary statistic (such as the K-function) by spatial subdivision of a single point pattern data-set.

These functions can be used to calculate the required statistic for an observed point pattern, however we often want to test if the stats generated from the observed are different from those expected from a null point process, such as CSR.
The `envelope()` function in the `spatstat` package can be used to create a set of simulated point processes within a window,and calculate any spatial statistic for both the simulated processes and the observed process. These can then be plotted to examine departures from the null point process, but remember the issue of multiple comparisons!
- `envelope()`  - Computes simulation envelopes of a summary function.

`spatstat` also has a function to perform the GoF test discussed in the Loosemore and Ford (2006) paper.
- `dclf.test()`  - Perform the Diggle (1986) / Cressie (1991) / Loosmore and Ford (2006) test or the Maximum Absolute Deviation test for a spatial point pattern.

---

**Avian Island - Southern Elephant Seals**

```r
env.K = envelope(verbose = F, avianSub.ppp, fun = Kest, nsim = 199)
```

```
## Error: object 'avianSub.ppp' not found
```

```r
env.G = envelope(verbose = F, avianSub.ppp, fun = Gest, nsim = 199)
```

```
## Error: object 'avianSub.ppp' not found
```


```
## Error: object 'avianSubBoundary' not found
```

```
## Error: object 'env.K' not found
```

```
## Error: object 'df1' not found
```

```
## Error: object 'env.G' not found
```

```
## Error: object 'df2' not found
```

```
## Error: could not find function "grid.arrange"
```



---

**Paulet - Antarctic Fur Seals**

```r
env.K = envelope(verbose = F, pauletSub.ppp, fun = Kest, nsim = 199)
```

```
## Error: object 'pauletSub.ppp' not found
```

```r
env.G = envelope(verbose = F, pauletSub.ppp, fun = Gest, nsim = 199)
```

```
## Error: object 'pauletSub.ppp' not found
```



```
## Error: object 'pauletSubBoundary' not found
```

```
## Error: object 'env.K' not found
```

```
## Error: object 'env.G' not found
```

```
## Error: could not find function "grid.arrange"
```


---

Both point patterns seem to show over-dispersion at short ranges, with no nearest neighbor distances less than ~4m. This would be expected if there were repulsion between the points. There appears to be clustering at larger spatial scales, which is likely due to the inhomogenous point process rather than interaction between the points.



Distributions of k nearest neighbor distances
--------------------------------------------
As we are actually interested in the differences between the two point patterns rather than between those point patterns and CSR, a comparison of the distributions of neighbor distances was suggested.

>Code from Sams script


```r
nearest.distances <- data.frame(Island = c(rep("Avian", avian.ppp$n), rep("Paulet", 
    paulet.ppp$n)), first = c(nndist(avian.ppp), nndist(paulet.ppp)), second = c(nndist(avian.ppp, 
    k = 2), nndist(paulet.ppp, k = 2)), third = c(nndist(avian.ppp, k = 3), 
    nndist(paulet.ppp, k = 3)))
```

```
## Error: object 'avian.ppp' not found
```

```r

ggplot(nearest.distances, aes(x = first)) + geom_histogram() + facet_grid(Island ~ 
    .)
```

```
## Error: object 'nearest.distances' not found
```

```r
p1 = ggplot(nearest.distances, aes(x = first, y = second, color = Island)) + 
    geom_density2d() + labs(y = "Second NN Distance", x = "First NN Distance")
```

```
## Error: object 'nearest.distances' not found
```

```r
p2 = ggplot(nearest.distances, aes(x = first, y = third, color = Island)) + 
    geom_density2d() + labs(y = "Third NN Distance", x = "First NN Distance")
```

```
## Error: object 'nearest.distances' not found
```

```r
p3 = ggplot(nearest.distances, aes(x = second, y = third, color = Island)) + 
    geom_density2d() + labs(y = "Second NN Distance", x = "Third NN Distance")
```

```
## Error: object 'nearest.distances' not found
```

```r
grid.arrange(p1, p2, p3, ncol = 3)
```

```
## Error: could not find function "grid.arrange"
```

