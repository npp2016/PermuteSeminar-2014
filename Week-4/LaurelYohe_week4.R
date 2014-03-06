#starting at 2 because of U
i<-2
#make the first point
RSE<-data$level[1]
RSE.results<-c()
new.RSE<-c()
total<-c()
b.range<-seq(0.10, 1, by = 0.01)
resids<-data$level-mean(data$level)
for (j in 1:length(b.range))
{
 b<-b.range[j] 
 new.RSE<-c()
  for(i in 2:length(resids))
  {  
    #formula for RSE
    new.RSE<-c(new.RSE,(resids[i] - b*resids[i-1])^2)
   
  } 
 RSE.results<-c(RSE.results, sum(new.RSE))
}
#beta.hat is minimum 
beta.hat<-b.range[which.min(RSE.results)]  
#first calculate all epsilons from data using the formula including the beta.hat
epsilons<-c()
for(k in 1:length(resids))
{  
  epsilons<-c(epsilons, resids[k] - beta.hat*resids[k])#empirical epsilons for pool of residuals 
  
}
#now solve for beta.star using bootstrap of beta estimates
beta.star<-c()
for (l in 1:5){
  #bootstrap the epsilons
  epsilons.star<-sample(epsilons, length(epsilons), replace=T)
  resid.star<-seq(0,times = length(resids))
  
  for(m in 2:length(resids)){
    resid.star[m] <- beta.hat*resid.star[m-1] +epsilons.star[m-1]
  }
  #now use bootstrap-created residual to re-estimate the beta-hat (basically redo the first estimate of beta hat)
}
