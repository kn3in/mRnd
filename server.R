library(shiny)
source("functions.R", local = TRUE)

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

  resultValueBeta <- reactive({
    results_beta_based(inputValues()$N, inputValues()$alpha, inputValues()$R2xz, inputValues()$varx, inputValues()$vary, inputValues()$byx, inputValues()$epower)
    })

  output$result <- renderTable({
    resultValue()
    }, include.rownames = FALSE, include.colnames = FALSE)

  output$result_beta <- renderTable({
    resultValueBeta()
    }, include.rownames = FALSE, include.colnames = FALSE)

#--------------------------------------------------------------------
# Binary input
#--------------------------------------------------------------------

  inputValuesBinary <- reactive(
    data.frame(      N = ifelse(input$my_method2 == "power2", input$N2, NA),
                epower = ifelse(input$my_method2 == "samp_size2", input$epower2, NA),
                 alpha = input$alpha2,
                     K = input$K,
                  R2xz = input$R2xz2,
                    OR = input$OR
              ))

  resultsValueBinary <- reactive({
    results_binary(inputValuesBinary()$N, inputValuesBinary()$alpha, inputValuesBinary()$R2xz, inputValuesBinary()$K, inputValuesBinary()$OR, inputValuesBinary()$epower)
  })

  output$result_binary <- renderTable({
    resultsValueBinary()
    }, include.rownames = FALSE, include.colnames = FALSE)

})