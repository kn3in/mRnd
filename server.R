library(shiny)
library(xtable)
source("functions.R", local=TRUE)

shinyServer(function(input, output) {
  
 inputValues <- reactive(
  data.frame(      N = ifelse(input$my_method == "power", input$N, NA),
              epower = ifelse(input$my_method == "samp_size", input$epower, NA),
               alpha = input$alpha,
                 byx = input$byx,
                bOLS = input$bOLS,
                R2xz = input$R2xz,
                varx = input$varx,
                vary = input$vary
              ))

  resultValue <- reactive({
    results(inputValues()$N, inputValues()$alpha, inputValues()$byx, inputValues()$bOLS, inputValues()$R2xz, inputValues()$varx, inputValues()$vary, inputValues()$epower)
    })


  output$result <- renderTable({
       resultValue()
       }, include.rownames = FALSE, include.colnames = FALSE)
})