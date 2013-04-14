library(shiny)
source("functions.R", local=TRUE)

shinyServer(function(input, output) {
  
  resultValue <- reactive({
    
  })
  
  output$result <- renderText(
      "oi"
  )
  
})