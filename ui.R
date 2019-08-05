
# Define UI for application 
shinyUI(fluidPage( theme = shinytheme("cosmo"),

# Application title
      titlePanel(strong("Red Tide in the Gulf of Mexico, 2000 to 2018")),
         leafletOutput("map", width=1000, height=1000),
           

# building panel that floats
        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
            draggable = TRUE, top = 60, left = "auto", right =20, bottom = "auto",
            width = 700, height = "auto",
            
# Header on panel

            h1(strong(" Explorer")),
            hr(),
            h4(p("Also known as 'Red Tide,' blooms of the microscopic organism Karenia brevis in the Gulf of Mexico
              have been threatening marine life and human life for many years. 
              Use this application to observe trends in these blooms.")),
            br(),
            h6(p("Use the 'Select Year' tab below to
              explore the occurence of blooms by year from 2000 to 2018.")),
            h6(p("Hover over points on the map to see more information about a particular bloom")),
            
            br(),
            hr(),
  
# year slider            
            sliderInput("year", "Select Year:", 
                   min = 2000, max = 2018,
                   value = 0, step = 1,
                   sep = "",
                   animate = TRUE),
            hr(),

# plot on panel       
            plotOutput("scatterCellcount",  height = 500),
            h5(strong("Plot : Cell count vs. Salinity")),
            h6(p("Salinity is known to be a major contribuitng factor in the
                 growth of algal blooms. This plot gives a visual representation
                 of the relationship between algal cell count and salinity. Larger
                 cell count = a larger bloom."))
            
        
      )
    )
  )



