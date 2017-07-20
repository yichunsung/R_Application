# test for 山腳斷層繪圖

# library packages

library(magrittr)
library(ggplot2)
library(leaflet)
library(knitr)
library(maptools) # 協助讀取shp file
library(sp)
library(rgeos) 
library(devtools)
#install_github("yichunsung/transtwd97")
library(transtwd97)
# read shp
setwd("c://R_Application/map")

SF_line_shp <- readShapeSpatial("shpData/fault data/SF-Fault/fault-line.shp")
SF_line_dataFrame <- fortify(SF_line_shp) 
plot(SF_line_shp)
SF_line_dataFrame_WGS84 <- TWD97toWGS84(inputTWD97Y = SF_line_dataFrame$lat, inputTWD97X = SF_line_dataFrame$long)

leaflet(data = YMS_EQ) %>% 
 # addProviderTiles("Esri.WorldImagery") %>% 
  #addProviderTiles("Stamen.Toner",
   #               options = providerTileOptions(opacity = 0.4))%>%
  setView(lng=121.5292, lat=25.1826, zoom = 8) %>%
  addPolygons(data= changetoPolygons,
              fillColor = "yellow", 
              weight = 2,                             
              opacity = 1,                             
              color = "grey",                             
              dashArray = "3",                             
              fillOpacity = 0.3) %>%
  addCircles(lng= 121.5292, 
             lat= 25.1826, 
             weight = 1, 
             radius = 100000)%>%
  addCircleMarkers(lng=YMS_EQ$lng, 
                   lat=YMS_EQ$lat, 
                   weight = 1, 
                   radius = ~YMS_EQ$ML, 
                   color = "red", 
                   fillColor ="red", 
                   fill=TRUE, 
                   fillOpacity = 0.8) %>%
  addCircleMarkers(lng=YMS_EQ_more120$lng, 
                   lat=YMS_EQ_more120$lat, 
                   weight = 1, 
                   radius = ~YMS_EQ_more120$ML, 
                   color = "blue", 
                   fillColor ="blue", 
                   fill=TRUE, 
                   fillOpacity = 0.8) %>%
  addPolylines(lng=SF_line_dataFrame_WGS84$Longitude, 
               lat = SF_line_dataFrame_WGS84$Latitude,
               opacity = 1,                             
               color = "black",                             
               dashArray = "3",
               popup = "山腳斷層") 
  

