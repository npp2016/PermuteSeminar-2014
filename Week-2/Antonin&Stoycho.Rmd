

Antonin & Stoycho

CLUTCH SIZE - HIERARCHICAL SAMPLING

========================================================

STEP1

The distribution closely matches LOG-NORMAL
```

hist (log(x$Clutch_size))

```

STEP 1:
```


species <- rep(NA,100)
for (i in 1:100) {species [i] <- mean (sample(x$Clutch_size,100,replace=T))}
hist (species, col="grey")
cat("STEP1: Estimated mean =", mean(species),"and stdev =", sqrt(var(species)),"\n",sep=" ")


```

STEP 2:

```

metagenera <- rep (NA,100)
for (j in 1:100){
  
  genus <- sample (x$Genus_name,1)
  
  genera <- rep (NA, 100)
  
  for (k in 1:100){genera[k] <- sample (x [x$Genus_name == genus,"Species_name"], 100, replace=TRUE)}
  
  metagenera[j] <- mean (genera)
  
}

hist (metagenera, col="grey")
cat("STEP2: Estimated mean =", mean(metagenera),"and stdev =", sqrt(var(metagenera)),"\n",sep=" ")

```

STEP 3:
```

familyx <- rep(NA, 100)
for (l in 1:100){
  
  famx <- sample (x$Family,1)
  
  genx <- sample (x[x$Family == famx, "Genus_name"], 1)
  
  for (k in 1:100){familyx[k] <- sample (x [x$Genus_name == genx,"Species_name"], 100, replace=TRUE)}
  
  rm(famx, genx)
  
}
hist(familyx, col="grey")
cat("STEP3: Estimated mean =", mean(familyx),"and stdev =", sqrt(var(familyx)),"\n",sep=" ")

```

SUMMARY
```
cat("STEP1: Estimated mean =", mean(species),"and stdev =", sqrt(var(species)),"\n",sep=" ")
cat("STEP2: Estimated mean =", mean(metagenera),"and stdev =", sqrt(var(metagenera)),"\n",sep=" ")
cat("STEP3: Estimated mean =", mean(familyx),"and stdev =", sqrt(var(familyx)),"\n",sep=" ")

```
