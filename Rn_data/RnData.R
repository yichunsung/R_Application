setwd('c:/R_Application/Rn_data')
Sys.setlocale(category = "LC_ALL", locale = "cht")
# Read Data from CSV file
rawData <- read.csv("data/rndata.csv")

# Select Rn Data
RnTimeToCONC <- data.frame(
  time = as.POSIXct(rawData$time, "%Y/%m/%d %H:%M", tz = "GMT"),
  Rn = as.numeric(rawData$Radon)
)
# Select Rainfall Data
rainfall <- data.frame(
  time = as.POSIXct(subset(rawData, rawData$c0U600hourly.rf >= 0)[[20]], 
                    "%Y/%m/%d %H:%M", 
                    tz = "GMT"),
  rf = as.numeric(subset(rawData, rawData$c0U600hourly.rf >= 0)[[21]])
)

# draw simple figure compare with Rn data and Rainfall data
Rn_plot <- plot_ly(data = RnTimeToCONC,
                   x = RnTimeToCONC$time,
                   y = RnTimeToCONC$Rn,
                   type = "scatter",
                   mode = "lines")

RF_plot <- plot_ly(data = rainfall,
                   x = rainfall$time,
                   y = rainfall$rf,
                   type = "bar",
                   color = "red")
Rn_compare_RF_plot <- subplot(Rn_plot, RF_plot, nrows = 2, shareX = TRUE)

# get every hour Rn average  
format_RnTTime <- format(RnTimeToCONC$time, format = "%Y-%m-%d %H")

RnTimeToCONC <- cbind(RnTimeToCONC, FormatTime = format_RnTTime)

dateCat <- names(summary(RnTimeToCONC$FormatTime, maxsum=length(RnTimeToCONC$FormatTime)))


Rn_mean <- c()
for(i in 1:length(dateCat)){
 subDate <- subset(RnTimeToCONC, RnTimeToCONC$FormatTime == dateCat[[i]])
 Rn_mean <- c(Rn_mean, mean(subDate$Rn))
}

averagePerHour <- data.frame(time=as.POSIXct(dateCat, "%Y-%m-%d %H", tz="GMT"), Rn_mean)

# Merge with Rn and Rainfall data

newRainfalltoRn <- merge(averagePerHour, rainfall, by='time')

norfRn <- subset(newRainfalltoRn, newRainfalltoRn$rf >= 0) # Select rf >20 mm

# Plot Rn data compare Rainfall data

RFtoRn_plot <- plot_ly(data = norfRn, 
                       #x = ~norfRn$rf,
                       y = ~norfRn$Rn_mean,
                       type = "scatter",
                       mode = "markers")
RFtoRn_plot

# Merge with Temperture data
Temp <- data.frame(
    time = as.POSIXct(subset(rawData, as.numeric(as.vector(rawData$air.Temp.)) >= 0)[[20]], 
                                             "%Y/%m/%d %H:%M", 
                                             tz = "GMT"),
   tem = 10*as.numeric(as.vector((subset(rawData, as.numeric(as.vector(rawData$air.Temp.)) >= 0)[[23]])))
 )

newTemptoRn <- merge(averagePerHour, Temp, by='time')
deleteErorrTem <- subset(newTemptoRn, newTemptoRn$tem <= 40) 
# plot
TemptoRn_plot <- plot_ly(data = deleteErorrTem, 
                       x = ~deleteErorrTem$tem,
                       y = ~deleteErorrTem$Rn_mean,
                       type = "scatter",
                       mode = "markers")
TemptoRn_plot


