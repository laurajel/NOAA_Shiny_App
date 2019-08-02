library(ggplot2)
library(plotly)
library(gapminder)



p=plot_ly(noaa_df, x = ~water_temp, y = ~cellcount, type="scatter", 
          text = paste("Temperature: ", noaa_df$water_temp, "Cell count: ", noaa_df$cellcount, "Date: ", noaa_df$sample_date, sep = " "),
          mode = "markers", color = ~water_temp, size = ~cellcount)
p

