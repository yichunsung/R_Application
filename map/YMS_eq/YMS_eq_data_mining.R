setwd('c://testDOC')
Sys.setlocale(category = "LC_ALL", locale = )
# read .csv file
fileList <- list.files(path = "C://testDOC/data/", pattern="*.csv")
for (i in 1:length(fileList)){
  assign(fileList[i], 
         read.csv(paste("C://testDOC/data/", fileList[i], sep=''))
  )}

# ChihNan = "指南宮站"; Taipei = "台北站"; Xinyi = "信義站"; YMS = "陽明山站";

YMSList <- c(nrow(YMS_INT_1.csv), nrow(YMS_INT_2.csv), nrow(YMS_INT_3.csv), nrow(YMS_INT_4.csv))
TaipeiList <- c(nrow(Taipei_INT_1.csv), nrow(Taipei_INT_2.csv), nrow(Taipei_INT_3.csv), nrow(Taipei_INT_4.csv), nrow(Taipei_INT_5.csv))
XinyiList <- c(nrow(Xinyi_INT_1.csv), nrow(`Xinyi _INT_2.csv`), nrow(`Xinyi _INT_3.csv`), nrow(Xinyi_INT_4.csv))
ChihNanList <- c(nrow(ChihNan_INT_1.csv), nrow(ChihNan_INT_2.csv), nrow(ChihNan_INT_3.csv), nrow(ChihNan_INT_4.csv))

Yinty<-c()
for(i in 1:4){
INT <- rep(i, times =as.numeric(YMSList[[i]]))
Yinty <- c(Yinty, INT)
}
Tinty <- c()
for(i in 1:5){
  INT <- rep(i, times =as.numeric(TaipeiList[[i]]))
  Tinty <- c(Tinty, INT)
}
Xinty <- c()
for(i in 1:4){
  INT <- rep(i, times =as.numeric(XinyiList[[i]]))
  Xinty <- c(Xinty, INT)
}
Cinty <- c()
for(i in 1:4){
  INT <- rep(i, times =as.numeric(ChihNanList[[i]]))
  Cinty <- c(Cinty, INT)
}

YMS_EQ_list <- rbind(YMS_INT_1.csv, YMS_INT_2.csv, YMS_INT_3.csv, YMS_INT_4.csv)
YMS_EQ_list <- cbind(YMS_EQ_list, Yinty)

Taipei_EQ_list <- rbind(Taipei_INT_1.csv, Taipei_INT_2.csv, Taipei_INT_3.csv, Taipei_INT_4.csv, Taipei_INT_5.csv)
Taipei_EQ_list <- cbind(Taipei_EQ_list, Tinty)

Xinyi_EQ_List <- rbind(Xinyi_INT_1.csv, `Xinyi _INT_2.csv`, `Xinyi _INT_3.csv`, Xinyi_INT_4.csv)
Xinyi_EQ_List <- cbind(Xinyi_EQ_List, Xinty)

ChihNan_EQ_list <- rbind(ChihNan_INT_1.csv, ChihNan_INT_2.csv, ChihNan_INT_3.csv, ChihNan_INT_4.csv)
ChihNan_EQ_list <- cbind(ChihNan_EQ_list, Cinty)
# two data.frame inner join
EQ_list <- merge(YMS_EQ_list, Taipei_EQ_list, by.x='地震時間', by.y = '地震時間')

# 多data.frame full join
EQ_list <- Reduce(function(x, y) merge(x, y, all=TRUE), list(YMS_EQ_list, Taipei_EQ_list, Xinyi_EQ_List, ChihNan_EQ_list))

names(EQ_list) <- c("id", "time", "lng", "lat", "depth", "ML", "epicenter", "YMS_int", "Taipei_int", "Xinyi_int", "ChihNan_int")

Time <- as.Date(EQ_list$time, "%Y/%m/%d")
tTime <- substr(EQ_list$time, 14, 22) # cut string
pasteTime <- paste(Time, tTime, sep = " ") # paste new string
Times <- as.POSIXct(pasteTime, "%Y-%m-%d %H:%M:%S", tz = "GMT") # as.POSIXct

# new data frame for EQ list

new_EQ_list <- data.frame(id = EQ_list$id, 
                          time = Times, 
                          lng = EQ_list$lng, 
                          lat = EQ_list$lat, 
                          depth = EQ_list$depth, 
                          ML = EQ_list$ML, 
                          epicenter = EQ_list$epicenter, 
                          YMS_int = EQ_list$YMS_int, 
                          Taipei_int = EQ_list$Taipei_int, 
                          Xinyi_int = EQ_list$Xinyi_int, 
                          ChihNan_int = EQ_list$ChihNan_int)

write.csv(new_EQ_list, "C://testDOC/tp_eqList.csv")





