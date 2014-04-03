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

#######=============== Hummingbirds ======================================================================

# Start with hummingbirds
## add sp richness across all elevations for all hummers
hum_data[26,] <- colSums(hum_data)
hum_data
  hum_data[26,] # check output




#######=============== Hylids ===========================================================================

# Start with hummingbirds
## add sp richness across all elevations for all hummers
hylid_data[26,] <- colSums(hylid_data)
hylid_data
  hylid_data[26,] # check output





#######============   Ignore!! =============================================================================
found_hylid <-colSums(hylid_data[,2:50]) ## num of times each spp (1:50) is found at diff elevations
  plot(found_hylid) ## hot mess

# playing with rle
rle(hylid_data$Sp1)


## Plotting some stuff...
plot(hylid_data$hylid_elev, hylid_data$Sp1)
  lines(hylid_data$hylid_elev, hylid_data$Sp1)
  lines(hylid_data$hylid_elev, hylid_data$Sp2)
  lines(hylid_data$hylid_elev, hylid_data$Sp3)
  lines(hylid_data$hylid_elev, hylid_data$Sp4)
  lines(hylid_data$hylid_elev, hylid_data$Sp5)

