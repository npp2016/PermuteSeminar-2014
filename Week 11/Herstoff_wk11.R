setwd("~/PermuteSeminar-2014/Week 11/")
epi <- read.csv("epipalassemblages.csv")
colnames(epi)

## Ben teaching ggplot

require(reshape2)

epI<-melt(epi) ## making the format of the data prettier; show me the data.

colnames(epI)
## "Site"     "Period"   "Region"   "variable" "value"  
head(epI)
##    Site   Period        Region variable value
##1  KDr8  Kebaran Mediterranean       T1   516
##2  HayC  Kebaran Mediterranean       T1    68
##3   EGI Nizzanan Mediterranean       T1     0

require(ggplot2)

ggplot(data=epI,aes(x=Site,y=value,color=Period,shape=Region)) + geom_point() + facet_wrap(~variable,scales="free") + theme(axis.text.x = element_text(angle = 90, hjust = 1))
