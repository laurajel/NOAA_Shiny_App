library(ggplot2)
library(maps)
library(leaflet)
library(tidyverse)
library(RColorBrewer)

noaa_data = readr::read_csv("NOAA_Shiny_ALL.csv")

############### Vilsualize cell count

summary(noaa_data$cellcount)
mybins=seq(1000, 200000, by=30000)  ###### 
mypalette = colorBin( palette="RdPu", domain=noaa_data$cellcount, na.color="transparent", bins=mybins)

mytext=paste("Cellcount: ", noaa_data$cellcount, "<br/>", "Stations: ", noaa_data$description, "<br/>", "Water Temperature: ", noaa_data$water_temp, "<br/>", "Date: ", noaa_data$sample_date, sep="") %>%
  lapply(htmltools::HTML)


leaflet(noaa_data) %>% 
  addTiles()  %>% 
  setView( lat= 26, lng= -82 , zoom=4) %>%
  addProviderTiles("Esri.WorldImagery") %>%
  addCircleMarkers(~longitude, ~latitude, 
                   fillColor = ~mypalette(cellcount), fillOpacity = 0.7, color="white", radius=8, stroke=FALSE,
                   label = mytext,
                   labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
  ) %>%
  addLegend( pal=mypalette, values=~cellcount, opacity=0.9, title = "Algal Cell count", position = "bottomright" )






