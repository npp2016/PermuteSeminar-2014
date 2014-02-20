library(markdown)
library(knitr)

birds<- read.csv("/Users/emilypetchler/Documents/GitHub/ClutchSize.csv")
colnames(birds)
## "Family"       "Genus_name"   "Species_name" "Clutch_size"  "English_name"
hist( birds$Clutch_size)
mean(birds$Clutch_size) ## 3.448037
max(birds$Clutch_size)  ## 18.6
min(birds$Clutch_size)  ## 1


library(MASS)
fitdistr(x=birds$Clutch_size, densfun="log-normal")
fitdistr(x=birds$Clutch_size, densfun="Poisson")
## Log Normal fits best?

library(boot)



boot(data=birds$Species_name,      , R=1000)


