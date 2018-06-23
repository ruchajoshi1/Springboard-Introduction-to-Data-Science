library(leaflet)
library(tidyverse)

m <- leaflet() %>%
      addTiles() %>% # add default OpenStreetMap map tiles
      addMarkers(lng = 174.768, lat = -36.852, popup = "The birthplace of R")

m #print object m

# Set value for the minZoom and maxZoom settings.
#leaflet(options = leafletOptions(minZoom = 0, maxZoom = 18))

# add some circles to a map
df = data.frame(Lat = 1:10, Long = rnorm(10))
leaflet(df) %>% addCircles()

leaflet(df) %>% addCircles(lng = ~Long, lat = ~Lat)

leaflet() %>% addCircles(data = df)

leaflet() %>% addCircles(data = df, lat = ~ Lat, lng = ~ Long)

library(maps)
mapStates = map("state", fill = TRUE, plot = FALSE)
leaflet(data = mapStates) %>% addTiles() %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)

mapStates1 = map("state", fill = TRUE, plot = FALSE)

leaflet(data = mapStates1) %>% addTiles() %>%
addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)
