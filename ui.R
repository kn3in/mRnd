library(shiny)
source("custom_html.R")
source("cont_input.R")
source("cont_output.R")

shinyUI(
  pageWithSidebar(
    customHeaderPanel("mRnd: Power calculations for Mendelian Randomization"),
    do.call(sidebarPanel, app_input()),
    do.call(mainPanel , app_output()))
)