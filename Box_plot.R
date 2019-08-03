library(ggplot2)
library(plotly)
library(gapminder)



p = noaa_data %>%
    plot_ly(x = ~cellcount, y = ~water_temp, type="scatter", 
          text = paste("Temperature: ", noaa_data$water_temp, "Cell count: ", noaa_data$cellcount, "Date: ", noaa_data$sample_date, sep = " "),
          mode = "markers", color = ~water_temp, size = ~cellcount)

p

