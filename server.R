shinyServer(function(input, output, session) {
  
## names for the leaflet plot  
  mybins=seq(100, 1001000, by=100000)  ###### 
  mypalette = colorBin( palette="RdPu", domain=noaa_data$cellcount, na.color="transparent", bins=mybins)

# text for hover   
  mytext=paste("Cellcount: ", noaa_data$cellcount, "<br/>", "Stations: ", noaa_data$description, "<br/>", "Water Temperature: ", noaa_data$water_temp, "<br/>", "Date: ", noaa_data$sample_date, sep="") %>%
    lapply(htmltools::HTML)
  
## update when month and year change on panel  
  observe({
    date_new <- unique(noaa_data %>% 
                         filter(noaa_data$year == input$year & noaa_data$month == input$month) %>%
                         .$date_new)
    updateSelectInput(
      session, "date_new",
      choices = date_new,
      selected = date_new[1])
    
  })
  
  date_by <- reactive({
    noaa_data %>%
      filter(year == input$year & month == input$month)
  })
#leaflet (does not change)  
  
  output$map <- renderLeaflet({
    leaflet (noaa_data) %>% 
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
  # scatter plot on panel 
  output$scatterCellcount<- renderPlot(
    date_by() %>%
      ggplot( aes(x=water_temp, y=cellcount)) +
      geom_point() +
      labs(x = "Water Temp (F)", y = "Cell count (cells/L)", title = "Water Temp vs. Cell count")
  ) 
  
  
 
 
  

})    




