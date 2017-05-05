setwd('c:/R_Application/cpblatt')
Sys.setlocale(category = "LC_ALL", locale = "cht")

CPBL <- read.csv('data/CPBL.csv')
field_CPBL <- read.csv("data/field.csv")
CPBL <-CPBL[-1]
all_cpbl <- plot_ly(data = CPBL,
                    x = CPBL$time,
                    y = CPBL$att,
                    type = "scatter",
                    mode = "markers")
all_cpbl

# Every Year

year <- format(as.Date(CPBL$time), "%Y")
month <- format(as.Date(CPBL$time), "%m")
CPBL <- cbind(CPBL, year, month)


yearseq <- as.vector(as.factor(1990:2016))
averageATT <- c()
for(i in 1:length(yearseq)){
  yavg <- subset(CPBL, CPBL$year==yearseq[i])
  meanatt_year <- mean(yavg$att)
  averageATT <- c(averageATT, meanatt_year)
}

ATTaverage <- data.frame(year = yearseq, attAVG = averageATT)

attave_plot <- plot_ly(data = ATTaverage,
                       x = ATTaverage$year,
                       y = ATTaverage$attAVG,
                       type = "bar")
attave_plot

monthseq <-c('04', '05', '06', '07', '08', '09', '10')

everyMonthavg <- data.frame(monthseq)
for(i in 1:length(yearseq)){
  yavg <- subset(CPBL, CPBL$year==yearseq[i])
  monthavg <- c()
  for(i in 1:length(monthseq)){
    monavg <- subset(yavg, yavg$month==monthseq[i])
    meanatt_month <- mean(monavg$att)
    monthavg<-c(monthavg, meanatt_month)
  }
  everyMonthavg <- cbind(everyMonthavg, monthavg)
}
names(everyMonthavg)[2:ncol(everyMonthavg)] <- yearseq


# everyMonthavg = 每年4~10月的觀眾數月平均


attave_plotM <- plot_ly(data = everyMonthavg,
                        x = everyMonthavg$monthseq,
                        y = everyMonthavg[[28]],
                        type = "scatter",
                        mode = "lines",
                        name =names(everyMonthavg[28])) 
  
#attave_plotM

for(i in 27:2){
  attave_plotM <-  add_lines(attave_plotM,
                            x = everyMonthavg$monthseq,
                            y = everyMonthavg[[i]],
                            type = "scatter",
                            mode = "lines",
                            name =names(everyMonthavg[i]))
}
attave_plotM


fieldName <- names(summary(CPBL$field))

meanforEveryField <- c()
for (i in 1:length(fieldName)){
  fieldSelect <- subset(CPBL, CPBL$field ==fieldName[i])
  meanforonefield <- mean(fieldSelect$att)
  meanforEveryField <- c(meanforEveryField, meanforonefield)
}

averageATTfor_Field <- data.frame(fieldName, meanforEveryField)

plotforAVGfield <- plot_ly(data = averageATTfor_Field,
                           x = averageATTfor_Field$fieldName,
                           y = averageATTfor_Field$meanforEveryField,
                           type = "bar")
plotforAVGfield

fieldname <- as.vector(field_CPBL$field)
percentATT <- c()
for(i in 1:length(fieldname)){
  percentForField <- subset(averageATTfor_Field, averageATTfor_Field$fieldName == fieldname[[i]])
  fieldatt <- subset(field_CPBL, field_CPBL$field ==fieldname[[i]])
  attRatio <- (percentForField$meanforEveryField / fieldatt$座位數)*100
  percentATT <-c(percentATT, attRatio)
}

ATTPerecntperfield <- data.frame(fieldname, percentATT)


