# Define UI for application 
shinyUI(fluidPage(

    # Application title
      titlePanel("Harmful Algal Blooms"),
         leafletOutput("map", width=1000, height=1000),
           

# building panel that floats
        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
            draggable = TRUE, top = 60, left = "auto", right =20, bottom = "auto",
            width = 700, height = "auto",
            
# Header on panel

            h2("Algae Explorer"),
            
            br(),
            br(),
# selectable month
           selectInput( "month", "Month", noaa_data$month),

            br(),
            hr(),
            br(),
# year slider            
            sliderInput("year", "Select Year:",
                   min = 2000, max = 2018,
                   value = 0, step = 1,
                   sep = "",
                   animate = TRUE),

            br(),
            hr(),
            br(),

# plot on panel       
            plotOutput("scatterCellcount",  height = 500)
        
      )
    )
  )



