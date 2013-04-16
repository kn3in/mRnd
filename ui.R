library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("mRnd: Power calculations for Mendelian Randomisation"),
  
  sidebarPanel(
      h4("Input"),
      wellPanel(numericInput("N", "Sample size:", min = 1, value = 1000, step = 1)),
      wellPanel( sliderInput("alpha", "Type-I error rate:", min = 0, max = 1, value = 0.05)),
      wellPanel(numericInput("byx", "True causal beta of Y on X:", value = 0)),
      wellPanel(numericInput("bOLS", "Expected beta from observation study:", value = 0)),
      wellPanel( sliderInput("R2xz", "Variance in X explained by genetic predictor:", min = 0, max = 1, value = 0.01)),
      wellPanel(numericInput("varx", "variance of X:", value = 1)),
      wellPanel(numericInput("vary", "variance of Y:", value = 1)),
      wellPanel( sliderInput("epower", "Power:", min = 0, max = 1, value = 0.8))
      ),
  
  mainPanel(
        wellPanel(
          h4("Result"),
          tableOutput("result")),
        wellPanel(h4("Citation:"),
        p("MJ Brion, Visscher PM. (2013)", a(href="http://", "Article Title"), "Journal ..."),
        p("Written by Konstantin Shakhbazov", a(href="https://github.com/kn3in/mRnd", "Source code at GitHub")))
)))