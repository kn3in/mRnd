library(shiny)
source("custom_html.R")
source("cont_input.R")
source("cont_output.R")

shinyUI(
  pageWithSidebar(
    customHeaderPanel("mRnd: Power calculations for Mendelian Randomization"),
    app_input(),
    app_output()))