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

p<-ggplot(data=epI,aes(x=variable,y=Site,fill=value)) + geom_tile() 
p <- p + facet_grid(Region~Period,margins=TRUE) 
p <- p + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + theme_bw()
p <- p + scale_fill_continuous(low="blue",high="red")
ggsave("out.eps",dpi=300)

require(vegan)
head(epi)

ep<-epi[,-c(1,33,34,35)]
rownames(ep)<-epi[,1]

prcomp(ep)

