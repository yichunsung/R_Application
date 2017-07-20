# test for googlesheet

setwd('C://R_Application/create database in googlesheet')
test2 <- read.csv('test2.csv')
# Packages
# we use package googlesheet to manage our googlesheets
install.packages('googlesheets')
library(googlesheets)

# 檔案共用即可使用
# connect with google account to read all googlesheets
gs_auth(new_user = TRUE) # 與帳戶建立新的受權
gs_user() # 查看user資料
gs_ls() # when you use this function, R will open your browser to the page of login .
# After you successfully log in, you can see the list of googlesheet in this account.
test_gs <- gs_title('testFile') # 選擇帳戶中的spreadsheet
UBspot <- gs_read(ss=test_gs, ws = "工作表1", skip=0) # 將test_gs的分頁工作表1讀進來成一個data frame

MnewRow <- c("Murun", "Murun", "49.642899", "100.176862")
ndata <- data.frame(name=c("Ulaanbaatar Railway Station", "Ulaanbaatar Airport"), 
                    eng = c("Ulaanbaatar Railway Station", "Ulaanbaatar Airport"),
                    lat = c(47.908592, 47.840388),
                    lng = c(106.883938, 106.769976)
                    )
gs_add_row(ss=test_gs, ws = "工作表1", input = test2) # 新增資料

# test url reading
JSurl <- "https://docs.google.com/spreadsheets/d/1jNSjtLo5PJnJh8it_SkZ1ZnDVMxo1gRZbHcMxhjbZAU/edit?usp=sharing"
GTPurl <- "https://docs.google.com/spreadsheets/d/11VFUdSCfZahqIuaO5eAvtCyyIjpnnYkG4w7KliiY_fc/edit?usp=sharing"
GTPtest <- gs_url(GTPurl)
GTPtestdf <- gs_read(ss=GTPtest, ws = "工作表1", skip=0)



# 建立新的google sheet
gs_new("CWB-data", ws_title = "Beiliao", input = Beiliao, trim = TRUE, verbose = FALSE)
gs_new("test2-test2", ws_title = "test2", input = test2, trim = TRUE, verbose = FALSE)
# 在CWB-data中建立新的worksheet
CWB_gs <- gs_title('CWB-data')
gs_ws_ls(ss = CWB_gs)
gs_ws_new(ss = test_gs, ws_title = "Zhudong", input = test2, trim = TRUE, verbose = FALSE)
gs_ws_new(ss = CWB_gs, ws_title = "Hutoupi", input = Hutoupi, trim = TRUE, verbose = FALSE)
gs_deauth() # 與帳戶中斷受權



