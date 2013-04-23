library(shiny)
library(xtable)
source("functions.R", local=TRUE)

shinyServer(function(input, output) {
  
  resultValue <- reactive({
    results(input$N, input$alpha, input$byx, input$bOLS, input$R2xz, input$varx, input$vary, input$epower)
  })

  annotResults <- reactive({
  	 annotate(resultValue())
  })
  
  subsetForResults <- reactive({
     dt <- annotResults()
     dt <- dt[dt$Parameter %in% c("b2sls", "power"), ]
  	})

  output$result <- renderText(
      paste(print(xtable(subsetForResults()), include.rownames = FALSE, type = "html", html.table.attributes = c("class=table-condensed"), print.results = FALSE),
         tags$script("MathJax.Hub.Queue([\"Typeset\",MathJax.Hub]);"))
  )

  output$testing <- renderText(
      paste(print(xtable(resultValue()), include.rownames = FALSE, type = "html", html.table.attributes = c("class=table-condensed"), print.results = FALSE),
         tags$script("MathJax.Hub.Queue([\"Typeset\",MathJax.Hub]);"))
  )
})