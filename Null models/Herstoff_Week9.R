setwd("Null models/")
# read in data; check.
hum <- read.csv(file="Hummingbirds.csv")
hylid <- read.csv("Hylids.csv")

## removing 'Elev_' from the hummer data.
hum_elev <- as.numeric(gsub(pattern="Elev_", replacement="", fixed=T, hum$Elevation))
hum_data<- cbind(hum_elev, hum)
hum_data$Elevation<-NULL

## removing 'Elev_' from the hylid data.
hylid_elev <- as.numeric(gsub(pattern="Elev_", replacement="", fixed=T, hylid$Elevation))
hylid_data<- cbind(hylid_elev, hylid)
hylid_data$Elevation<-NULL
hylid_data

#######=================================================================================================

found_hylid <-colSums(hylid_data[,2:50]) ## num of times each spp (1:50) is found at diff elevations
  plot(found_hylid) ## hot mess

hylid_data
rle(hylid_data$Sp1)


## Plotting some stuff...
plot(hylid_data$hylid_elev, hylid_data$Sp1)
  lines(hylid_data$hylid_elev, hylid_data$Sp1)
  lines(hylid_data$hylid_elev, hylid_data$Sp2)
  lines(hylid_data$hylid_elev, hylid_data$Sp3)
  lines(hylid_data$hylid_elev, hylid_data$Sp4)
  lines(hylid_data$hylid_elev, hylid_data$Sp5)

