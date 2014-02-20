

### CLUTCH SIZE - HIERARCHICAL SAMPLING

### Antonin & Stoycho

hist (log(x$Clutch_size)) ### the distribution closely matches LOG-NORMAL


species <- rep(NA,100)
for (i in 1:100) {species [i] <- mean (sample(x$Clutch_size,100,replace=T))}
cat("STEP1: Estimated mean =", mean(species),"and stdev =", sqrt(var(species)),"\n",sep=" ")


metagenera <- rep (NA,100)
for (j in 1:100){
  
  genus <- sample (x$Genus_name,1)
  
  genera <- rep (NA, 100)
  
  for (k in 1:100){genera[k] <- sample (x [x$Genus_name == genus,"Species_name"], 100, replace=TRUE)}
  
  metagenera[j] <- mean (genera)
  
}

cat("STEP2: Estimated mean =", mean(metagenera),"and stdev =", sqrt(var(metagenera)),"\n",sep=" ")


familyx <- rep(NA, 100)
for (l in 1:100){
  
  famx <- sample (x$Family,1)
  
  genx <- sample (x[x$Family == famx, "Genus_name"], 1)
  
  for (k in 1:100){familyx[k] <- sample (x [x$Genus_name == genx,"Species_name"], 100, replace=TRUE)}
  
  rm(famx, genx)
  
}
cat("STEP3: Estimated mean =", mean(familyx),"and stdev =", sqrt(var(familyx)),"\n",sep=" ")


cat("STEP1: Estimated mean =", mean(species),"and stdev =", sqrt(var(species)),"\n",sep=" ")
cat("STEP2: Estimated mean =", mean(metagenera),"and stdev =", sqrt(var(metagenera)),"\n",sep=" ")
cat("STEP3: Estimated mean =", mean(familyx),"and stdev =", sqrt(var(familyx)),"\n",sep=" ")
