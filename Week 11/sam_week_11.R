library(reshape2)
library(plyr)
library(ggplot2)

sites <- read.csv("epipalassemblages.csv")
artifacts <- melt(sites, id.var=c("Site", "Total", "Period", "Region"))
names(artifacts)[5:6] <- c("Artifact", "Count")
artifacts$Proportion <- artifacts$Count / artifacts$Total
head(artifacts)

ggplot(artifacts, aes(x=Artifact, y=Count)) + geom_bar(stat='identity') +
  facet_grid(Period ~ Region)

ggplot(artifacts, aes(x=Artifact, y=Site, fill=Count)) + geom_tile()

ggplot(subset(artifacts, Count > 0), aes(x=Artifact, y=Site, fill=log10(Count))) +
  geom_tile() + facet_grid(Region ~ Period, scales='free_y', space='free_y') +
  theme_bw()

ggplot(subset(artifacts, Count > 0), aes(x=Artifact, y=Site, fill=Proportion)) +
  geom_tile() + facet_grid(Region ~ Period, scales='free_y', space='free_y') +
  theme_bw()

counts <- sites[ , 2:32]
rownames(counts) <- sites$Site
proportions <- counts
for (i in 1:nrow(proportions)) {
  proportions[i, ] <- proportions[i, ] / sites$Total[i]
}

pc.counts <- prcomp(counts)
biplot(pc.counts)
plot(pc.counts)
summary(pc.counts)

pc.proportions <- prcomp(counts)
biplot(pc.proportions)
plot(pc.proportions)
summary(pc.proportions)
