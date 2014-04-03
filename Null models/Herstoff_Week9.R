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


