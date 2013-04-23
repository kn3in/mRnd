library(shiny)
library(knitr)
source("custom_html.R")

shinyUI(pageWithSidebar(
  customHeaderPanel("mRnd: Power calculations for Mendelian Randomization"),
  # headerPanel("mRnd: Power calculations for Mendelian Randomisation"),
  
  sidebarPanel(
      h4("Input"),
      wellPanel(numericInput("N", HTML("\\(N\\)"), min = 1, value = 1000, step = 1),
                helpText("Sample size")),

      wellPanel(sliderInput("alpha", HTML("\\(\\alpha\\)"), min = 0, max = 1, value = 0.05),
                helpText("Type-I error rate")),
      
      wellPanel(numericInput("byx", HTML("\\(\\beta_{yx}\\)"), value = 0),
                helpText("Estimate of the regression coefficient \\(\\beta_{yx}\\) for the true underlying causal association between the exposure \\((X)\\) and outcome \\((Y)\\) variables")),
      
      wellPanel(numericInput("bOLS", HTML("\\(\\beta_{OLS}\\)"), value = 0),
                helpText("The regression \\(\\beta_{OLS}\\) coefficient for the observational association between the exposure \\((X)\\) and outcome \\((Y)\\) variables")),
      
      wellPanel(sliderInput("R2xz", HTML("\\(R^2_{xz}\\)"), min = 0, max = 1, value = 0.01),
                helpText("Proportion of variance explained for the association between the snp \\((Z)\\) and the exposure variable \\((X)\\)")),
      
      wellPanel(numericInput("varx", HTML("\\(\\sigma^2(x)\\)"), value = 1)),
      
      wellPanel(numericInput("vary", HTML("\\(\\sigma^2(y)\\)"), value = 1)),
      
      wellPanel( sliderInput("epower", "Power:", min = 0, max = 1, value = 0.8))
      ),
  
  mainPanel(
        wellPanel(
          h4("Description:"),
          HTML("
Power calculations for two-stage least squares Mendelian Randomization studies using a genetic instrument \\(Z\\) (a SNP or allele score),
continuous exposure \\(X\\) (smoking i.e numbers of cigarettes per day) and
outcome variable \\(Y\\) (lung cancer).")),
        wellPanel(
          h4("Result"),
          htmlOutput("result")),
        wellPanel(
          h4("Testing"),
          htmlOutput("testing")),
        wellPanel(h4("Citation:"),
        p("Brion MJ, Shakhbazov KS, Visscher PM. (2013)", a(href="http://", "Article Title"), "Journal ..."),
        p("Written by Konstantin Shakhbazov", a(href="https://github.com/kn3in/mRnd", "Source code at GitHub")))
)))