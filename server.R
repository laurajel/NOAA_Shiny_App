shinyServer(function(input, output, session) {
  
## names for the leaflet plot  
  mybins=seq(100000, 1001000, by=100000)  ###### 
  mypalette = colorBin( palette="RdPu", domain=noaa_data$cellcount, na.color="transparent", bins=mybins)

# text for hover pop-up on leaflet points 
  mytext=paste("Cellcount: ", noaa_data$cellcount, "<br/>", "Stations: ", noaa_data$description, "<br/>","Salinity: ", noaa_data$salinity, "<br/>", "Water Temperature: ", noaa_data$water_temp, "<br/>", "Date: ", noaa_data$sample_date, sep="") %>%
    lapply(htmltools::HTML)
  
## update when year change on panel  
  observe({
    
    date_year <- unique(noaa_data %>% 
                        filter(noaa_data$year == input$year) %>% 
                        .$date_year)
   
  })
  
  date_change <- reactive({
    noaa_data %>%
      filter(year == input$year)
  })
  
  
  
#leaflet plot of algal bloom and their locations  
  
  output$map <- renderLeaflet({
    date_change() %>% # reactive expression
    leaflet () %>% 
      addTiles()  %>% 
      setView( lat= 25.3043, lng= -90.0659 , zoom=6) %>%
      addProviderTiles("Esri.WorldImagery") %>%
      addCircleMarkers(~longitude, ~latitude, 
                       fillColor = ~mypalette(cellcount), fillOpacity = 0.7, color="white", radius=8, stroke=FALSE,
                       label = mytext,
                       labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
      ) %>%
      addLegend( pal=mypalette, values=~cellcount, opacity=0.9, title = "Algal Cell count", position = "bottomright" )
    
    
      
  })
  # scatter plot on panel 
  
  output$scatterCellcount<- renderPlot(
  
    date_change( ) %>% # reactive expression
      ggplot( aes(x=cellcount, y=salinity)) +
      geom_point()
      
   )
})    








