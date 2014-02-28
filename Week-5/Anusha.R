#Read in file
dolphin <- read.csv("Dolphin+data.csv")

# Rename the cols to match dolphin paper
names(dolphin) <- c("Groups", LETTERS[1:18])

# hwi = x/{x+yab+0.5(ya+yb)}


hwi <- function(i,j) {
  x <- sum(dolphin[,i]==1 & dolphin[,j]==1)
  ya <- sum(dolphin[,i]==1 & dolphin[,j]==0)
  yb <- sum(dolphin[,i]==0 & dolphin[,j]==1)
  x/(x + 0.5*(ya + yb))
}

output <- list()
flag <- F

# Make a new swapped matrix, which starts as the original
swapped <- dolphin

# Get sample 2x2 numbers for cols and rows to check
cols <- sample(2:19, 2)
rows <- sample(1:38, 2)

## For loop to check
if (dolphin[rows[1],cols[1]]==1 & dolphin[rows[1],cols[2]]==0 & 
      dolphin[rows[2],cols[1]]==0 & dolphin[rows[2],cols[2]]==1) {
  swapped[rows[1],cols[1]]==0
  swapped[rows[1],cols[2]]==1
  swapped[rows[2],cols[1]]==1
  swapped[rows[2],cols[2]]==0
}


