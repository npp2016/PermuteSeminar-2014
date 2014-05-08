require(picante)
require(devtools)

sxs <- read.csv("SiteXspp.csv", row.names = 1)
sites <- read.csv("Week 14/Sites.csv")

hum <- read.tree("Week 14/hum294.tre")

tipsplit <- strsplit(hum$tip.label, "\\.")
newtips <- sapply(tipsplit, function(x){paste(x[1:2], collapse =".")})

hum$tip.label <- newtips

#write.tree(hum, file = "newtree.tre")

nsxs <- sxs[,colnames(sxs) %in% hum$tip.label]

cohum <- cophenetic(hum)

meanphy <- mpd(nsxs, cohum)

meantest <- data.frame(sites = rownames(nsxs), phydist = meanphy)

require(nullmatR)
nullsxs <- make_null(nsxs, iter = 200, method = "rcp")
nulls <- lapply(nullsxs, function(x){colnames(x) <- colnames(nsxs); rownames(x) <- rownames(nsxs); x})

newmpd <- matrix(nrow = 229, ncol = 200)
for(i in 1:200){
  newmpd[,i] <- mpd(nulls[[i]], cohum)  
}

imp <- apply(newmpd, 1, function(x){
  for(i in 1:length(x)){
    if(is.na(x[i])){x[i] <- sample(x,1)}
  }
  x
})

sdev <- apply(t(imp), 1, sd)
means <- apply(t(imp), 1, mean)


hist((meanphy - means)/sdev)

new <- matrix(nrow = 229, ncol = 100)
for(i in 1:100){
  c <- commsimulator(nsxs, method = "r00")
  new[,i] <- mpd(c, cohum)
}

imp <- apply(new, 1, function(x){
  for(i in 1:length(x)){
    if(is.na(x[i])){x[i] <- sample(x,1)}
  }
  x
})

data <- cbind(meantest, t(imp))
