library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)
library(maps)
library(tidyverse)
library(RColorBrewer)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    navbarPage("Harmful Algal Blooms", id="nav",
      tabPanel("Interactive map",
        div(class="outer")
        )),
                            
# leaflet map
        leafletOutput("map", width= 100, height= 100),
                            

# building panel
        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
            draggable = TRUE, top = 60, left = "auto", right =20, bottom = "auto",
            width = 330, height = "auto",
# Header on panel

            h2("Algae Bloom Explorer"),
            
            br(),
            br(),

# Date Range on panel                    
            dateRangeInput("date", strong("Date Range"), start = "2000-01-03", end = "2019-02-07",
                    min = "2000-01-03", max = "2019-02-07"),
            br(),
            br(),

# Date animation            
            sliderInput("animation", "Date Animation:",
                        min = 2000, max = 2019,
                        value = 1, step = 10,
                        animate =
                            animationOptions(interval = 300, loop = TRUE)),
                     
            plotOutput("scatterCellcount", height = 250)
            
            ), 
                     

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            mapOutput("leafmap")
        )
    )
)
