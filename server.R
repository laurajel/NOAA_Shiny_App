library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)
library(maps)
library(tidyverse)
library(RColorBrewer)


data = head(noaa_df, 100000)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$map <- renderLeaflet({
        
        mypalette = colorBin( palette="RdPu", domain=data$cellcount, na.color="transparent", bins=mybins)
        
        mytext=paste("Cellcount: ", data$cellcount, "<br/>", "Stations: ", data$description, "<br/>", "Water Temperature: ", data$water_temp, "<br/>", "Date: ", data$sample_date, sep="") %>%
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
        
        
    })

    
    outputplot
        # generate bins based on input$bins from ui.R
        x    <- noaa_df$cellcount
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })

})
