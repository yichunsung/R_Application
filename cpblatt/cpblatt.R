setwd('c:/R_Application/cpblatt')
Sys.setlocale(category = "LC_ALL", locale = "cht")

year <- c(1:27)
url_1 <- 'http://zxc22.idv.tw/cpbl'
url_2 <- '/allgame.asp?PgSz=999'
url_cpbl <- paste(paste(url_1, year, sep = ""), url_2, sep = "")

getCPBLdata <- function(input_url){
  
urlx <- input_url
# urlx <- 'http://zxc22.idv.tw/cpbl5/allgame.asp?flag=&PgSz=999&PageNO=1&submit1=%AD%AB%B7s%BE%E3%B2z'


xp_date <- "//tr/td[2]"
xp_att <- "//tr/td[8]"
xp_field <- "//tr/td[3]"
xp_TeamV <- "//tr/td[4]"
xp_TeamH <- "//tr/td[5]"
# get Att Data
dataurl <-read_html(urlx)
att <- dataurl %>%
  html_nodes(., xpath = xp_att)%>%
  html_text


# get Date Data
#dataurl <-read_html(urlx)
Date <- dataurl %>%
  html_nodes(., xpath = xp_date)%>%
  html_text

  date <- c()
  for (i in 1:length(Date)){
    if(is.na(Date[2*i-1])){
      break
    }else{
      date <- c(date, Date[2*i-1])
    }
  }
# get field data
#dataurl <-read_html(urlx)
field <- dataurl %>%
  html_nodes(., xpath = xp_field)%>%
  html_text 

fieldd <- c()
for (i in 1:length(field)){
  if(is.na(field[2*i-1])){
    break
  }else{
    fieldd <- c(fieldd, field[2*i-1])
  }
}
# get Team Data
#dataurl <-read_html(urlx)
Home_Team <- dataurl %>%
  html_nodes(., xpath = xp_TeamH)%>%
  html_text 
Visit_Team <- dataurl %>%
  html_nodes(., xpath = xp_TeamV)%>%
  html_text 
visit_Team <- c()
for (i in 1:length(Visit_Team)){
  if(is.na(Visit_Team[2*i-1])){
    break
  }else{
    visit_Team <- c(visit_Team, Visit_Team[2*i-1])
  }
}

name <- c(date[[1]], att[[1]], fieldd[[1]], Home_Team[[1]], visit_Team[[1]])
cpbl_data <- data.frame(time = as.Date(date[-1], "%Y/%m/%d"), 
                        att = as.numeric(att[-1]), 
                        field = fieldd[-1], 
                        Home_team = Home_Team[-1], 
                        Visit_team = visit_Team[-1]
                        )
return(cpbl_data)
}

 CPBL_t <- data.frame()
 for(i in 18:17){
  cpbl_i <- getCPBLdata(url_cpbl[i])
  CPBL_t <- rbind(CPBL_t, cpbl_i)
 }
 
 write.csv(CPBL_t, "c://R_Application/cpblatt/cpbl18_17.csv")


cpbl_i <- getCPBLdata(url_cpbl[27])
 
cpbl_27 <-read.csv('cpbl27.csv')

cpbl_27_date <-subset(cpbl_27, !is.na(cpbl_27$人數))
cpbl_27 <- data.frame(time = as.Date(cpbl_27_date$日期, "%Y/%m/%d"), att = cpbl_27_date$人數, field = cpbl_27_date$地點, Home_team = cpbl_27_date$主隊, Visit_team = cpbl_27_date$客隊)
cpbl26 <- read.csv('cpbl26_19.csv')
cpbl18 <-read.csv('cpbl18_17.csv')
cpbl16 <- read.csv('cpbl16_14.csv')
cpbl13 <- read.csv('cpbl1_13.csv')

CPBL <- rbind(rbind(rbind(rbind(cpbl_27, cpbl26), cpbl18), cpbl16), cpbl13)


write.csv(CPBL, "c://R_Application/cpblatt/CPBL.csv")
