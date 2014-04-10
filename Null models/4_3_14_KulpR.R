humming<-read.table("/Users/rebeccakulp/Documents/Classes/2014/Stats II/PermuteSeminar-2014/Null models/Hummingbirds.txt",head=T)
d<-as.numeric(gsub("Elev_","",humming$Elevation))
#now will need to sum up the number of species on the rows
row<-rowSums(humming[,2:51])
humming$ele=d
humming$sum=row
#want to graph the relationship to see if we observe a hump in the middle
plot(humming$sum~humming$ele)
#there seems to be a hump relationship in the middle; so now want to see if this i
#is due to the mid-domain effect

#this code will tell you what hte totals are for each category
rle(humming$Sp1)$lengths[1]
#need to sum
#will need to sum up all the zeros and ones, then you will have to substract the 
#total number of possible rows (columns) by the number that were in the block
#then you need to tell you what the possiblitities were that you can start it at
ones<-colSums(humming[,2:51])
zeros<-25-colSums(humming[,2:51])

new<-matrix(0,25,50)
#have our matrix where things will be added
new.ele<-cbind(new,d)
#now need to make our new datasets
for (i in 1:25){
  #randomly select a number from 
  c<-sample(zeros[i],1)
  #this gives the starting point
  #the starting and bottom
  #want to get it to add the ones in the right locations
  new[c:ones[i],i]==1
}

#did not get teh code-but you woudl need to create your sample and then 
#need to add up each column-woudl do that 1000 times, and then have a range of 
#species richness for each elevation
