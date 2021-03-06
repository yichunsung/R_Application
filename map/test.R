test_shpfile <- readShapeSpatial("C:/Users/ycsung/Desktop/SHP_F0012/F0012大甲斷層活動斷層地質敏感區-公告範圍(TWD97).shp")
plot(test_shpfile)
test_2_shp <- readShapeSpatial("C:/Users/ycsung/Desktop/NCREE/ArcGis/map/Town67_region.shp")
plot(test_2_shp)



# convert data frame to Geojson

stjson <- geojson_json(TaiwanTown_map_WGS84_renew, lat = 'lat', lon = 'long')

geojson_json()

leaflet(data = TaiwanTown_map_WGS84_renew) %>% addTiles() %>% setView(lng=120.6207, lat=24.33367, zoom = 10) %>%
  addTopoJSON(stjson, weight = 1, color = "#444444", fill = FALSE)
# data structure
head(slot(test_2_shp,"data"))
head(test_2_shp@polygons)


fault_shp <- readShapeSpatial("C:/Users/ycsung/Desktop/NCREE/ArcGis/map/全台活動斷層33條_990519修正/全台活動斷層.shp")
plot(fault_shp)

TaiwanTown_map_dataFrame <- fortify(test_2_shp, region = "CNAME") # 將SpatialPolygonsDataFrame 轉成Data.Frame (package 來源: ggplot2)
fault_map_dataFrame <- fortify(fault_shp, region = "COUNTRY") # 將SpatialPolygonsDataFrame 轉成Data.Frame (package 來源: ggplot2)


basemap <- get_map(location= "Taiwan", zoom = 7)
ggmap(basemap)
ggplot(fault_shp)+ geom_map(data = TaiwanTown_map_dataFrame, aes(map_id = id), map = TaiwanTown_map_dataFrame) + expand_limits(x = TaiwanTown_map_dataFrame$long, y = TaiwanTown_map_dataFrame$lat)

ggplot(fault_shp)+ geom_map(data = fault_map_dataFrame, aes(map_id = id), map = fault_map_dataFrame) + expand_limits(x = fault_map_dataFrame$long, y = fault_map_dataFrame$lat)

ggplot(Fault_DJ_shp)+ geom_map(data = Fault_DJ_dataFrame, aes(map_id = id), map = Fault_DJ_dataFrame) + expand_limits(x = Fault_DJ_dataFrame$long, y = Fault_DJ_dataFrame$lat)


plotly_fault <-  plot_ly(data = TaiwanTown_map_dataFrame, x = TaiwanTown_map_dataFrame$long, y = TaiwanTown_map_dataFrame$lat, type = "scatter", mode = "markers") %>%
     add_lines(data = fault_map_dataFrame, x = fault_map_dataFrame$long, y = fault_map_dataFrame$lat, type = "scatter", mode = "markers")
plotly_fault

install.packages('gdalUtils')
library(gdalUtils)
library(rgdal)

dsn <- "WMS:http://gis.moeacgs.gov.tw/geo4oracle/mapagent/mapagent.fcgi?Request=GetMap&SERVICE=WMS&VERSION=1.1.1&BGCOLOR=0xFFFFFF&TRANSPARENT=TRUE&SRS=EPSG:4326&FORMAT=image/png&LAYERS=,WMS2009/LAYER/G67_A_50KA1PL_L&BBOX=121.551988,25.017193,121.578647,25.042173"

ogrinfo(dsn, so=TRUE)

map <- leaflet()

leaflet() %>% addTiles() %>% setView(lng=121.539366, lat=25.017326, zoom = 10) %>%
   addWMSTiles("http://gis.moeacgs.gov.tw/geo4oracle/mapagent/mapagent.fcgi",
   layers =  "WMS2009/LAYER/250K/G67_TW_LIZA1A1PLL_L_1974_ALLSCALE",
   options = WMSTileOptions(format = "image/png", transparent = TRUE),
   attribution = "Taiwan"
   )

packages_to_use <- c("devtools", "roxygen2")
install.packages(packages_to_use)
lapply(packages_to_use, library, character.only = TRUE)

install.packages("devtools")
devtools::install_github("yichunsung/transtwd97")
library(transtwd97)

setwd('c:\\')
install('devtools')


leaflet() %>% addTiles() %>% setView(lng=120.6207, lat=24.33367, zoom = 10) %>%
  addPolygons(lng=Fault_DJ_WGS84$Longitude, lat = Fault_DJ_WGS84$Latitude)

