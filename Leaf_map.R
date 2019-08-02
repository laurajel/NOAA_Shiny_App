library(ggplot2)
library(maps)
library(leaflet)
library(tidyverse)
library(RColorBrewer)

############### Vilsualize cell count
head(noaa_df)
summary(noaa_df$cellcount)

data = head(noaa_df, 100000)
data = na.omit(data)
summary(data$cellcount)
mybins=seq(1000, 200000, by=30000)  ###### 
mypalette = colorBin( palette="RdPu", domain=data$cellcount, na.color="transparent", bins=mybins)

mytext=paste("Cellcount: ", data$cellcount, "<br/>", "Stations: ", data$description, "<br/>", "Year: ", data$sample_date, sep="") %>%
  lapply(htmltools::HTML)


leaflet(data) %>% 
  addTiles()  %>% 
  setView( lat= 26, lng= -82 , zoom=4) %>%
  addProviderTiles("Esri.WorldImagery") %>%
  addCircleMarkers(~longitude, ~latitude, 
                   fillColor = ~mypalette(cellcount), fillOpacity = 0.7, color="white", radius=8, stroke=FALSE,
                   label = mytext,
                   labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
  ) %>%
  addLegend( pal=mypalette, values=~cellcount, opacity=0.9, title = "Algal Cell count", position = "bottomright" )


