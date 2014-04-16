setwd("~/Desktop/GitHub/PermuteSeminar-2014/Week-10")

site <- read.csv("site_groupings.csv")
head(site)

spec <- read.csv("speciescounts.csv")
head(spec)

N.i <- c(5, 10, 20, 50, 100, 800)
# Create species pool
pools <- function(from =20, to = 80, native = .5, exotic = .1, blank = .4, abund = 8){
  spec.pool2 <- 0
  while(!length(spec.pool2) == spec.pool){
    spec.pool <- sample(c(from:to), 1)
    
    # Make proportions 
    natives <- round(spec.pool * native)
    exotics <- round(spec.pool * exotic)
    empties <- round(spec.pool * blank)
  
    spec.pool2 <- rep(c("native", "exotic", "blank"), c(natives, exotics, empties))
  }
  
  inds <- factor(paste(spec.pool2, c(1:natives, 1:exotics, 1:empties), sep = ""))
  # Give each species an abundance
  abundance <- rlnorm(spec.pool, abund, 1)
   
  community <- data.frame(ind = inds, abund = abundance)
  return(community)
}

df <- pools()

sample_plot <- function(df, N){
  abundance <- df$abund
  probs <- abundance / sum(abundance)
  new.community <- sample(df$ind, N, replace = T, prob = probs)
  unique.spec <- unique(new.community)
  n.native <- length(grep("native", unique.spec))
  n.exotic <- length(grep("exotic", unique.spec))
  ex.nat <- c(n.native, n.exotic)
  return(ex.nat)
}

sample_plot(df, 50)

sampler <- function(N, prop.nat = .5, prop.ex = .1){
  prop.blank <- 1 - (prop.nat + prop.ex)
  quad.mat <- matrix(nrow = length(N), ncol = 3)
  for(i in 1:length(N)){
    comm.df <- pools(native = prop.nat, exotic = prop.ex, blank = prop.blank)
    quad.mat[i,c(1,2)] <- sample_plot(comm.df, N[i])
    quad.mat[i,3] <- N[i]
  }
  return(quad.mat)
}

sampler(N = N.i)

iterate <- function(iter, prop.nat = .5, prop.ex = .1){
  richness <- list()
  for(i in 1:iter){
    results <- sampler(N.i, prop.nat = .5, prop.ex = .1)
    colnames(results) <- c("exotic", "native", "N")
    richness[[i]] <- data.frame(results)
  }
  
  spec.rich <- do.call(rbind, richness)
  spec.rich$N <- factor(spec.rich$N)
  
  return(spec.rich)
}

samp <- iterate(1000)

require(ggplot2)
p <- ggplot(samp, aes(x = native, y = exotic)) + geom_point() + facet_wrap(~N, scales = "free")
p + geom_smooth(method = "lm")


perm.Q <- sample(spec$Quadrat, length(spec$Quadrat), replace = F)
head(spec)
newdat <- data.frame(spec[,3:5], perm = factor(perm.Q))
head(newdat)
ags <- aggregate(newdat$Count, by=list(quad = newdat$perm, type = newdat$Origin), sum)
new.ag <- list()
for(i in 1:100){
  perms <- sample(spec$Quadrat, length(spec$Quadrat), replace = F)
  newdats <- data.frame(spec[,3:4], Origin = spec$Origin, perm = factor(perms, levels = 1:20))
  agger <- aggregate(newdats$Count, by=list(quad = newdats$perm, type = factor(newdats$Origin)), sum)
  new.ag[[i]]<- cbind(agger, i)
}

new.ag[[1]]
perm.df <- do.call(rbind, new.ag)
perm.df
x <- split(perm.df, perm.df$type)
head(x[[2]])
newdf <- data.frame(quad = x[[1]]$quad, inv = x[[1]]$x, nat = x[[2]]$x, iter = x[[1]]$i)
