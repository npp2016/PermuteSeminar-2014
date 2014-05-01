setwd("~/Desktop/GitHub/PermuteSeminar-2014/Week-13")

supp <- read.csv("Svoboda_Supp.T2.csv", row.names = 1)
head(supp)
com <- t(supp)
site <- read.csv("EJR_siteinfo.csv", row.names = 1)
head(site)

ano <- anosim(com, site$Type)
ano$statistic

perms <- permatfull(com)$perm

newperm <- lapply(perms, function(x){
  rownames(x) <- rownames(com)
  colnames(x) <- colnames(com)
  x
})

pstats <- sapply(newperm, function(x){anosim(x, grouping = site$Type)$statistic})

sum(pstats > ano$statistic)
# permuted p value is less than .01 (0 of 100 permutations)