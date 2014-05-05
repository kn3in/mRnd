library(shiny)
source("custom_html.R")
source("app_inputs.R")
source("app_outputs.R")
source("functions.R")

shinyUI(
  pageWithSidebar(
    customHeaderPanel("mRnd: Power calculations for Mendelian Randomization"),
    sidebarPanel(
      conditionalPanel(condition = "input.conditionedPanels==1", app_input_cont()),
      conditionalPanel(condition = "input.conditionedPanels==2", app_input_binary()),
      conditionalPanel(condition = "input.conditionedPanels==3", list())),
    
    mainPanel(
      tabsetPanel(tabPanel("Continuous outcome", value = 1, app_output_cont()),
                  tabPanel("Binary outcome",     value = 2, app_output_binary()),
                  tabPanel("Binary outcome derivations", value = 3, app_output_binary_deriv()),
                  tabPanel("Citation",           value = 3, app_about()),
                  tabPanel("About",              value = 3, app_about2()),
                  id = "conditionedPanels")
)))