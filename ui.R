library(shiny)
source("custom_html.R")
source("cont_input.R")
source("cont_output.R")

shinyUI(
  pageWithSidebar(
    customHeaderPanel("mRnd: Power calculations for Mendelian Randomization"),
    
    sidebarPanel(
      conditionalPanel(condition = "input.conditionedPanels==1", app_input_cont()),
      conditionalPanel(condition = "input.conditionedPanels==2", app_input_binary())),
    
    mainPanel(
      tabsetPanel(tabPanel("Continuous outcome", value = 1, app_output_cont()),
                  tabPanel("Binary outcome", value = 2, app_output_binary()),
                  id = "conditionedPanels")
)))