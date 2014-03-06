setwd("~/Desktop/GitHub/PermuteSeminar-2014/Week-5")

require(RCurl)
url <- getURL("https://raw.github.com/PermuteSeminar/PermuteSeminar-2014/master/Week-5/Dolphin+data.csv")
dolphins <- read.csv(text = url, row.names = 1, header = F)
colnames(dolphins) <- LETTERS[1:18]
head(dolphins)
