Point Patterns in Seal Imagery - Ben Weinstein
========================================================


```r
require(maptools)
```

```
## Loading required package: maptools
## Loading required package: sp
## Checking rgeos availability: FALSE
##  	Note: when rgeos is not available, polygon geometry 	computations in maptools depend on gpclib,
##  	which has a restricted licence. It is disabled by default;
##  	to enable gpclib, type gpclibPermit()
```

```r
require(raster)
```

```
## Loading required package: raster
```


Read in data
----

```r
pts <- readShapePoints("~/Week 8/AVIA shapefile/AVIA seals.shp")
```

```
## Error: Error opening SHP file
```


View data
-----------


```r
plot(pts)
```

```
## Error: error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'pts' not found
```


Create distance matrix
------------------------


