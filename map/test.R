test_shpfile <- readShapeSpatial("C:/Users/ycsung/Desktop/SHP_F0012/F0012大甲斷層活動斷層地質敏感區-公告範圍(TWD97).shp")
plot(test_shpfile)
test_2_shp <- readShapeSpatial("C:/Users/ycsung/Desktop/NCREE/ArcGis/map/Town67_region.shp")
plot(test_2_shp)

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
   #layers =  "WMS2009/LAYER/G67_A_50KA1PL_L",
   options = WMSTileOptions(format = "image/png", transparent = TRUE),
   attribution = "Taiwan"
   )
