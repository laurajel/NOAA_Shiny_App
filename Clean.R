library(tidyverse)
library(dplyr)


### importing csv
noaa_df = readr::read_csv("./habsos_20190211.csv")
names(noaa_df)

noaa_df[noaa_df == 0] <- NA


### Selcting rows of interest
noaa_df = select(noaa_df, longitude, latitude, description, cellcount, state_id, sample_date, water_temp, species, salinity, sample_depth, genus)

head(noaa_df, 5)

##### looking at characteristics 
str(noaa_df)
summary(noaa_df)


class(noaa_df$sample_date)
###################################################### DATE

####### change dates from POSIXct to a Date

noaa_df <- noaa_df %>% mutate(sample_date = as.Date(as.POSIXct(sample_date, tz = " " )))
class(noaa_df$sample_date)


###### new month/year columns
noaa_df <- noaa_df %>% 
  mutate(sample_date = as.Date(sample_date, "%Y-%m-%d")) %>%
  mutate(month=as.numeric(format(sample_date, "%m"))) %>% 
  mutate(year=as.numeric(format(sample_date, "%Y")))
names(noaa_df)


#### Converting year error 153 to 1953

noaa_df$year[noaa_df$year == 153] <- 1953
noaa_df$sample_date[noaa_df$sample_date == "0153-06-29"] <- "1953-06-29"
head(noaa_df, 5)

###### Year/month as factor
noaa_df = noaa_df %>% 
  mutate(year= as.factor(year))%>%
  mutate(month= as.factor(month))

#CHECK
levels(noaa_df$year)
levels(noaa_df$month)


unique(noaa_df$year)
unique(noaa_df$month)


####################################################### TEMPERATURE
##### converting degrees C into F function
to_f = function(x){
  rnge = range(x, na.rm = TRUE)
  return(x * (9/5) + 32)
}

## mutating C to F
noaa_df = noaa_df %>%
  mutate(water_temp = to_f(water_temp))

#CHECK
head(noaa_df, 5)
summary(noaa_df$water_temp, na.rm =TRUE)
#################################################### STATE

unique(noaa_df$state_id)

#character > Factor
noaa_df = noaa_df %>% 
  mutate(state_id = as.factor(state_id))

#CHECK

class(noaa_df$state_id)
levels(noaa_df$state_id)

summary(noaa_df$cellcount)
###############################################Cell count replace outliers with 1,000,000
x = noaa_df$cellcount
threshold <- 1000000
thresh= function(x){
  replace(x, x > threshold, NA)
}

#threshold2 <- 100000
#thresh2 = function(x){
 # replace(x, x < threshold2, NA)
#} 


noaa_df = noaa_df %>%
  mutate(cellcount = thresh(cellcount))

#noaa_df = noaa_df %>%
 # mutate(cellcount = thresh2(cellcount))

summary(noaa_df$cellcount)



############################################### SELECT only 2000 - 2019 observations
summary(noaa_df$sample_date)


noaa_df = noaa_df[noaa_df$sample_date >= "2000-01-01" & noaa_df$sample_date <= "2019-01-01",]


############################################### Write csv
noaa_df = na.omit(noaa_df)

write.csv(noaa_df, file = "NOAA_Shiny_ALL.csv", row.names = TRUE)




