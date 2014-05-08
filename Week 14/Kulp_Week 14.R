library(picante)
hummingbird<-read.tree("/Users/rebeccakulp/Documents/Classes/2014/Stats II/PermuteSeminar-2014/Week 14/hum294.tre")
str(hummingbird)
#shows the structure:
#edges, nodes and tip.label; degree of relatedness
#create an expectation: subsample use the tip.names
length(hummingbird$tip.label)#could have our observed to the null distribtuion
#distance from the tip to the node: diance between a and b is the cor
d<-cophenetic(hummingbird)#measure of relateness; every two sister species shoudl be present
#pairwise matrix; relatedness of every taxa (their tips to their most common ancestor node)
table(d)
#hist the matrix will get a distribution; relatedness states can exist because
#the tree can only be that long
hist(d)#topology; right skewed; some very young birds and some very old birds
split<-strsplit(hummingbird$tip.label,split="\\.")
#can grab the tip labels and can sample from the phylogeny ()
for (i in 1:294){
  hummingbird$tip.label[i]<-paste(split[[i]][1],split[[i]][2],sep=".")
}

#for all the trues; woudl give you the number of assemblages in the phylogeny
#we randomize the matrix and then use it to make a phylogenetric (site x species table)
#dolphin data manipulate the data and then calc the statistic
#compute a test statistic to a different object. how the randomization of hte matrix affects teh 
#have an "interaction" of the randomization
#first do the nonparametric test statistic
#1)mean phylogentic diversity; what is the relatidness of one species to every otehr way
#then take an overall mean. do not need to go backway-only do one way

?mpd
column names: woudl have tree$tip.labels=
#dataset two site by species

#want to take the tip labels and take the period out;
#on the tree; ben.weinstein.2010; want to split them and then drop the year
#a period is a special character in a language-need to escape the period
#loop through need to escape by //
d<-cophenetic(hummingbird)
#look in the phylogeny, calculating (list of all the ones each row; find the positions)
#then it will link up which ones are ones and then all combination of the different groups
#give the mean phylogenetic diversity at your site
phy.new<-prune.sample(sites,hummingbird)

phy.new.d<-cophenetic(phy.new)
#need to have the new sites have less number
#randomize the data commsimulator function: will site by species: mixes up the ones and zeros
colnames()%in%tip.label
data<-as.data.frame(treedata(phy.new,t(sites),sort=TRUE,warnings=TRUE)$data)
data<-t(data)
original<-mpd(data,phy.new.d)
#Appends new test statistic of what you already have
#will want to know where the site name and all the different species
#subset a object based on the query of anotehr object-get T, F and then you want the names of them
#so get columnames
#colnames(siteexspp)[colunames()%in%treetip.lable]
#if want the site spp
#siteexpp[]
frame<-rbind(rownames(sites),original)

#site matrix will be making it new.  comsimulator (already exist)
commsimulator()
#another way to do it;deiger Free data(Free,t(#only uses row names not column names))

  #what is our distance matrix; cophenetrics!  we will want for our function
sites<-read.csv("/Users/rebeccakulp/Documents/Classes/2014/Stats II/PermuteSeminar-2014/Week 14/SiteXspp.csv",row.names=1)

#mean phylogenetic + the site: will create a new test statistic
#make a funciton that simulate the new matrix, compute the new statistic adn output a 100 times
row.names=1; the first column is my row names
library(vegan)
?commsimulator
simu<-commsimulator(sites,"r00")

d<-function(x){
  simu<-commsimulator(data,"r00")
  comp<-mpd(simu,phy.new.d)
  return(data.frame(Site=rownames(simu),comp))
}
#matrix propertise can effect your test statistic; ex species richenss
#thinner distribution is ones with low richness
simu<-commsimulator(data,"r00")
comp<-mpd(simu,phy.new.d)
d<-rbind(rownames(sites),comp)

for (i in 1:200){
  simu<-commsimulator(data,"r00")
  comp<-mpd(simu,phy.new.d)
  d<-rbind(d,comp)
}

new<-data.frame(Site=rownames(comp),simu)
require(ggplot2)
ggplot(d,aes(x=value,color=Site)) + geom_density() + facet_wrap(~Site)
#want to replot hte graph; grab the code adn then different for different sites
#get different null models get different distributions!!
