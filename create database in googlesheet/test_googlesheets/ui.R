library(shiny)
library(googlesheets)
library(plotly)

shinyUI(fluidPage(
  titlePanel("Quick demo"),
  
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("dates", label = h3("date"), start = "2017-01-01", end = "2017-01-01", format = "yyyy-mm-dd"),
      selectInput("title", label = h3("station"), 
                  choices = c("title1", "title2", "title3"), selected = "title1"),
      submitButton("Submit"),
      br()
     
    ),
    
    mainPanel(
      tabsetPanel(
        
        tabPanel("result",
                 
                 dataTableOutput("the_data")
                 
        ),
        
          tabPanel("Plot", 
                   
                   plotlyOutput("plotlyData"))
        
      )
    )
  )
  
  
))