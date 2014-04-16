library(reshape2)
library(plyr)
library(ggplot2)

site.groups <- read.csv("site_groupings.csv")
head(site.groups)

spp.counts <- read.csv("speciescounts.csv")
head(spp.counts)

acast(spp.counts, Site ~ Species, sum, value.var="Count")

quadrat.sizes <- c(5, 10, 20, 50, 100, 800)
n.reps <- 100

# simulating data
p.native <- 0.5
p.exotic <- 0.1
p.blank <- 0.4
origins <- c("native", "exotic", "blank")
probs <- c(p.native, p.exotic, p.blank)

set.seed(1)
n.species <- sample(20:100, 1)
n.native <- round(n.species * p.native)
n.exotic <- round(n.species * p.exotic)

spp.names <- paste("sp", 1:n.species, sep='')
spp.abundances <- round(rlnorm(n.species, meanlog=log(5000), sdlog=1))

individuals <- data.frame(matrix(0, nrow=sum(spp.abundances), ncol=2))
names(individuals) <- c("species", "origin")

j <- 1
for (k in 1:n.species) {
  n <- spp.abundances[k]
  individuals$species[j:(j + n - 1)] <- spp.names[k]
  individuals$origin[j:(j + n - 1)] <- sample(origins, 1, replace=T, prob=probs)
  j <- j + n
}

n.ind <- nrow(individuals)


results <- array(0, dim=c(n.reps, length(origins), length(quadrat.sizes)))

for (i in 1:n.reps) {
  print(i)
  for (j in 1:length(quadrat.sizes)) {
    size <- quadrat.sizes[j]
    # shuffle them
    this.sample <- individuals[sample(n.ind, size), ]
    results[i, 1, j] <- sum(this.sample == "native")
    results[i, 2, j] <- sum(this.sample == "exotic")
    results[i, 3, j] <- sum(this.sample == "blank")
  }
}

dimnames(results) <- list(1:n.reps, origins, quadrat.sizes)
results.m <- melt(results)
names(results.m) <- c("rep", "origin", "quadrat.size", "count")
head(results.m)
results.c <- dcast(results.m, rep + quadrat.size ~ origin)

# hmm...not working...
ggplot(results.c, aes(x=exotic, y=native)) + geom_point(position="jitter") + geom_smooth(method=lm) +
  facet_wrap(~quadrat.size, scales="free")
