library(shiny)
source("functions.R", local=TRUE)

shinyServer(function(input, output) {
  
  resultValue <- reactive({
    results(input$N, input$alpha, input$byx, input$bOLS, input$R2xz, input$varx, input$vary, input$epower)
  })
  
  output$result <- renderTable(
      resultValue()
  )
  
})