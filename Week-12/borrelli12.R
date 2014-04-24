bhab <- read.csv("bird_habitat.csv")
head(bhab)

getAICtab <- function(bhab){
  mod1 <- glm(bird.present ~ elevation, bhab, family = binomial)
  mod2 <- glm(bird.present ~ farm, bhab, family = binomial)
  mod3 <- glm(bird.present ~ northing + easting, bhab, family = binomial)
  tab <- aictab(list(mod1, mod2, mod3), modnames = c("Elevation", "Farm", "Position"))
  return(as.character(tab[1,1]))
}

vec <- c()
for(i in 1:500){
  bootROW <- sample(1:nrow(bhab), nrow(bhab), replace = T)
  vec[i] <- getAICtab(bhab[bootROW,])
}

table(vec)
