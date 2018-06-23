#
library("tidyverse")
library("leaflet")
library("maps")

#read all file

#voyagefile <- "F:\\Git\\capstone project\\dataSets\\V_Dim_Voyage.csv"
#voypnlfile <- "F:\\Git\\capstone project\\dataSets\\V_Fact_VoyPNL.csv"
portfile <- "F:\\Git\\capstone project\\dataSets\\V_Dim_Ports.csv"

ports.data <- read.csv(portfile)

glimpse(ports.data)

#voyage.data <- read.csv(voyagefile)

#colnames(voyage.data)

#voypnl.data <- read.csv(voypnlfile)

#colnames(voypnl.data)

# create a subset
ports.lng.lat <- subset(ports.data, select = c("Latitude","Longitude"))

#mapping points on the map
leaflet() %>% addCircles(data = ports.lng.lat)

map1 = map("world", fill = TRUE, plot = FALSE)

# add layers
leaflet(data = map1) %>% addTiles() %>% addCircles(data = ports.lng.lat) %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)  

#third party tiles
# %>% addProviderTiles(providers$Esri.NatGeoWorldMap)

leaflet() %>% addTiles() %>% addCircles(data = ports.lng.lat) %>%
  addProviderTiles(providers$Esri.NatGeoWorldMap)

# Add icons and markers
#oceanIcons <- iconList(
#  ship = makeIcon("ferry-18.png", "ferry-18@2x.png", 18, 18)
#)

#leaflet(ports.lng.lat) %>% addTiles() %>%
  # Select from oceanIcons based on df$type
#  addMarkers(icon = ~oceanIcons)

#add marker cluster

leaflet(ports.lng.lat) %>% addTiles() %>% addMarkers(
  clusterOptions = markerClusterOptions()
)

#add pop up and labels
library(htmltools)

leaflet(ports.data) %>% addTiles() %>%
  addMarkers(~Longitude, ~Latitude, popup = ~htmlEscape(PortName))

#