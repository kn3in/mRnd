library(shiny)
library(knitr)
source("custom_html.R")

shinyUI(pageWithSidebar(
  customHeaderPanel("mRnd: Power calculations for Mendelian Randomisation"),
  
  sidebarPanel(
      h4("Input"),
      wellPanel(numericInput("N", HTML("\\(N\\)"), min = 1, value = 1000, step = 1),
        HTML(knit2html(text = "Sample size"))),

      wellPanel(numericInput("alpha", HTML(knit2html(text = "$\\alpha$")), min = 0, max = 1, value = 0.05),
        HTML(knit2html(text = "Type-I error rate"))),
      
      wellPanel(numericInput("byx", HTML(knit2html(text = "True causal $\\beta_{yx}$")), value = 0),
        HTML(knit2html(text = "Estimate of the regression coefficient $\\beta_{yx}$ for the true underlying causal association between the exposure $(X)$ and outcome $(Y)$ variables"))),
      
      wellPanel(numericInput("bOLS", HTML(knit2html(text = "Expected $\\beta_{yx}$ from observation study")), value = 0),
        HTML(knit2html(text = "The regression $\\beta_{yx}$ coefficient for the observational association between the exposure $(X)$ and outcome $(Y)$ variables"))),
      
      wellPanel(numericInput("R2xz", HTML(knit2html(text = "$R^2_{xz}$")), min = 0, max = 1, value = 0.01),
        HTML(knit2html(text = "Proportion of variance explained for the association between the snp $(Z)$ and the exposure variable $(X)$"))),
      
      wellPanel(numericInput("varx", HTML(knit2html(text = "$Var(X)$")), value = 1)),
      
      wellPanel(numericInput("vary", HTML(knit2html(text = "$Var(Y)$")), value = 1)),
      
      wellPanel( sliderInput("epower", "Power:", min = 0, max = 1, value = 0.8))
      ),
  
  mainPanel(
        wellPanel(
          h4("Description:"),
          HTML(knit2html(text = "
Power calculations for two-stage least squares Mendelian Randomization studies using a genetic instrument $Z$ (a SNP or allele score),
continuous exposure $X$ (smoking i.e numbers of cigarettes per day) and
outcome variable $Y$ (lung cancer)."))),
        wellPanel(
          h4("Result"),
          htmlOutput("result")),
        wellPanel(h4("Citation:"),
        p("MJ Brion, Visscher PM. (2013)", a(href="http://", "Article Title"), "Journal ..."),
        p("Written by Konstantin Shakhbazov", a(href="https://github.com/kn3in/mRnd", "Source code at GitHub")))
)))