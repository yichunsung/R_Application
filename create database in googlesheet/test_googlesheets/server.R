library(shiny)
library(googlesheets)
library(plotly)

GTPurl <- "https://docs.google.com/spreadsheets/d/11VFUdSCfZahqIuaO5eAvtCyyIjpnnYkG4w7KliiY_fc/edit?usp=sharing"
GTPtest <- gs_url(GTPurl)


shinyServer(function(input, output) {
  GTPtestdf <- gs_read(ss=GTPtest, ws = "工作表1", skip=0)
  GTPtestdf$date <- as.Date(GTPtestdf$date)
  output$the_data <- renderDataTable({
    
    GTPtestdf
  })
  output$plotlyData <- renderPlotly({
    
    GTPdataplotly <- plot_ly(
      data = GTPtestdf, 
      x = GTPtestdf$date, 
      y = GTPtestdf$TA_Day,
      type = "scatter", 
      mode = "liners+markers"
    )
    GTPdataplotly
  })
})
