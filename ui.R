library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("mRnd: Power calculations for Mendelian Randomisation"),
  
  sidebarPanel(
      h4("Input"),
      wellPanel(numericInput("N", "Sample size:", min = 1, value = 1000, step = 1)),
      wellPanel( sliderInput("alpha", "Type-I error rate:", min = 0, max = 1, value = 0.05)),
      wellPanel( sliderInput("byx", "True causal beta of Y on X:", min = 0, max = 1, value = 0))

      ),
  
  mainPanel(
        wellPanel(
          h4("Result")),
        wellPanel(h4("Citation:"),
        p("MJ Brion, Visscher PM. (2013)", a(href="http://", "Article Title"), "Journal ..."),
        p("Written by Konstantin Shakhbazov", a(href="https://github.com/kn3in/mRnd", "Source code at GitHub")))
)))