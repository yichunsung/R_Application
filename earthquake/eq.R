setwd('c:/R_Application/earthquake')
Sys.setlocale(category = "LC_ALL", locale = "cht")

CSV_earthquakesData <- read.csv("database.csv")

eqlocation <- data.frame(Date=CSV_earthquakesData$Date, 
                         lng=as.numeric(CSV_earthquakesData$Longitude), 
                         lat=as.numeric(CSV_earthquakesData$Latitude))

eqWorldmap <- leaflet(data = eqlocation)%>%
    addProviderTiles("Esri.WorldImagery") %>%
      addCircles(lng = ~eqlocation$lng, 
                 lat = ~eqlocation$lat,
                 opacity= 0,
                 weight= 10,
                 radius=30,
                 fillOpacity = 1,
                 stroke=FALSE,
                 color='red')

eqperYear <- data.frame(type=CSV_earthquakesData$Type,
                        date= as.Date(CSV_earthquakesData$Date, "%m/%d/%Y"),
                        lng=as.numeric(CSV_earthquakesData$Longitude), 
                        lat=as.numeric(CSV_earthquakesData$Latitude),
                        M=as.numeric(CSV_earthquakesData$Magnitude))
eqperYear <- cbind(eqperYear, Year = format(eqperYear$date, format="%Y") )

Every_year <-data.frame(year = format(
                          as.Date(
                            names(
                              summary(eqperYear$Year)
                            ), "%Y"), format="%Y"),
                        sum =as.numeric(summary(eqperYear$Year)))

Every_year_plotly <- plot_ly(data = Every_year,
                             x = Every_year$year,
                             y = Every_year$sum,
                             type = "bar"
                             )
Every_year_plotly

summary(eqperYear$type)

type <- names(summary(eqperYear$type))
TypeSum <- as.numeric(summary(eqperYear$type)) 

typeSumDataframe <- data.frame(type, TypeSum) # 1965 ~2016

EQ <- subset(eqperYear, eqperYear$type == "Earthquake")
NuclearExplosion <-subset(eqperYear, eqperYear$type == "Nuclear Explosion")

NEmap <- leaflet(data = NuclearExplosion) %>%
 # setView(lng=-116.4557, lat = 37.29533, zoom=5) %>%
  addProviderTiles("Esri.WorldImagery") %>%
  addCircleMarkers(lng = ~NuclearExplosion$lng,
                   lat = ~NuclearExplosion$lat,
                   color = "red",
                   opacity= 0,
                   weight= 30,
                   radius=10,
                   fillOpacity = 1)

NE_Every_year <-data.frame(year = format(
  as.Date(
    names(
      summary(NuclearExplosion$Year)
    ), "%Y"), format="%Y"),
  sum =as.numeric(summary(NuclearExplosion$Year)))

NE_perY_plotly <- plot_ly(data = NE_Every_year,
                          x = NE_Every_year$year,
                          y = NE_Every_year$sum,
                          type = "bar",
                          color = "red")


