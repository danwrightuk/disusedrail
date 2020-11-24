library(dplyr)
library(tidyverse)
library(sf)
library(tmap)
library(stplanr)
rail = read.csv("C:/Users/Danie/Desktop/disusedrail/disusedrail.csv", header = TRUE, dec = ",")

wiltshire <-
  pct::pct_regions %>% filter(region_name == "wiltshire")

stations <- rail %>% 
  st_as_sf(coords = c('lng', 'lat'))
colnames(stations)[which(names(stations) == "ï..Station.Name")] <- "Name"
colnames(stations)[which(names(stations) == "Last.service.year")] <- "Year of last service (freight or passenger)"
stations$Last.service.year <- as.Date(stations$Last.service.year, format="%Y")

tmap_mode("view")
tm_shape(wiltshire) + tm_borders()+
  tm_basemap(leaflet::providers$Thunderforest.Transport) +
tm_shape(stations) +
  tm_dots(size=0.1,
          palette="viridis",
          col = "Year of last service (freight or passenger)",
          n=4,
          breaks=c(1857,1950,1960,1965,1970),
          labels=c("1857 to 1949","1950 to 1959", "1960 to 1964", "1964 to 1970"))


