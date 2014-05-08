require(picante)
require(devtools)

sxs <- read.csv("Week 14/SiteXspp.csv", row.names = 1)
sites <- read.csv("Week 14/Sites.csv")

hum <- read.tree("Week 14/hum294.tre")

tipsplit <- strsplit(hum$tip.label, "\\.")
newtips <- sapply(tipsplit, function(x){paste(x[1:2], collapse =".")})

hum$tip.label <- newtips

write.tree(hum, file = "newtree.tre")

str(hum)
cohum <- cophenetic(hum)
hist(cohum)

