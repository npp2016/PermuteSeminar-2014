elev=" + elevation"
rock=" + rock"
farm=" + farm"
plant1="+ plant1"
plant2="+ plant2"
plant3="+ plant3"
easting="+ easting"
northing="+ northing"
variables=c(easting,northing,elev,rock,farm,plant1,plant2,plant3)
mods=list()
for(i in 1:8){
  a=combn(variables,m=i,simplify=FALSE)
  mods=c(mods,a)
}


bootstrap=data
reps=1000
AICs=matrix(nrow=length(mods),ncol=reps)
for(i in 1:reps){
for(j in 1:length(mods)){
  AICs[j,i]=eval(parse(text=paste("glm(bird.present~",paste(mods[[j]],collapse=""),",family=binomial(logit),data=bootstrap)$aic")))
  bootstrap=data[sample(x=1:nrow(data),size=nrow(data)),]
  }
}
table((apply(X=AICs,2,which.min)))


