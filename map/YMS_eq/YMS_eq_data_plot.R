setwd('C://R_Application/map/YMS_eq')
# read data csv
EQ_list <- read.csv("tp_eqList.csv")

YMSEQ <- subset(EQ_list, EQ_list$YMS_int>=1)
YMSEQ2016 <- subset(YMSEQ, as.Date(YMSEQ$time) >= as.Date("2016-08-01"))
install.packages("devtools")
library(devtools)
install_github("yichunsung/transtwd97")
library(transtwd97)

locaDYK <- distance_WGS84(origin_lat = 25.178540, 
                          origin_lng = 121.576995, 
                          obervation_lat = YMSEQ2016$lat, 
                          obervation_lng = YMSEQ2016$lng)

# library Packages
library(ggplot2)
library(plotly)
library(leaflet)
library(magrittr)

# the earthquakes which have be record in Taipei's 4 stations.
eqmap <- leaflet(data = EQ_list) %>%
  setView(lng= 121.53, lat = 25.017318, zoom = 10) %>%
  addProviderTiles("Hydda.Base") %>%
  addCircleMarkers(~lng, ~lat, 
                   popup=~as.character(ML), 
                   radius = 5, 
                   weight = 1, 
                   opacity = 0.8, 
                   fill = TRUE, 
                   fillOpacity = 0.8)
eqmap

# only YMS distance 100km



YMS_EQ <- subset(EQ_list, EQ_list$YMS_int != "NA")

YMS_EQ_map <- leaflet(data = YMS_EQ) %>%
  setView(lng=121.5292, lat=25.1826, zoom = 8) %>%
  addProviderTiles("Hydda.Base") %>%
  #addCircleMarkers(~lng, ~lat, popup=~as.character(ML), radius = 5, weight = 1, opacity = 0.8, fill = TRUE, fillOpacity = 0.8) %>%
  addCircles(lng= 121.5292, lat= 25.1826, weight = 1, radius = 100000)%>%
  addCircleMarkers(lng=EQ_list$lng, lat=EQ_list$lat, weight = 1, radius = ~EQ_list$ML, color = "red", fillColor ="red", fill=TRUE, fillOpacity = 0.8)
YMS_EQ_map

olng <- 121.5292
olat <- 25.1826
otwd97 <- WGS84toTWD97(inputLat = olat, inputLng = olng)
eqtwd97 <- WGS84toTWD97(inputLat = YMS_EQ$lat, inputLng = YMS_EQ$lng)
disEQ <- distance_TWD97(origin_TWD97_X = 303338.7, 
                        origin_TWD97_Y = 2786108,
                        observation_TWD97_X = eqtwd97$Longitude_TWD97_X, 
                        observation_TWD97_Y = eqtwd97$Latitude_TWD97_Y)

YMS_EQ <- cbind(YMS_EQ, disEQ)
YMS_EQ_more120 <- subset(YMS_EQ, YMS_EQ$disEQ>120)
YMS_EQ_120 <- subset(YMS_EQ, YMS_EQ$disEQ<=120)
# plot_ly our data for time seq

YMS_EQ_plotly <- plot_ly(data = YMS_EQ_120, x=YMS_EQ_120$time, y=YMS_EQ_120$YMS_int, type = "bar", name = "int") %>%
  #add_bars(data = YMS_EQ, x = YMS_EQ$time, y = YMS_EQ$YMS_int, type= "bar", name="int") %>%
  add_trace(data = YMS_EQ_120, x = YMS_EQ_120$time, y = YMS_EQ_120$ML, type = "scatter", mode = "markers", name = "ML")
YMS_EQ_plotly
