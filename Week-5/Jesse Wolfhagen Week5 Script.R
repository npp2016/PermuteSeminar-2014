data <- read.csv("Dolphin+data.csv")
names(data) <- c("Group", LETTERS[1:18])
##Take the HWI measurement
#x/(x+yab+0.5(ya+yb))
#x is # of encounters
#ya is # of dolphin A but not B
#You calculate the HWI for each dyad and the sum is given.
