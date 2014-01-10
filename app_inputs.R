app_input_cont <- function() {
 list(
    h4("Input"),
    wellPanel(
      h6("Calculate:"),
      radioButtons("my_method", "",
                     list("Power" = "power",
                          "Sample size" = "samp_size")),
      h6("Provide:"), 
    conditionalPanel(condition = 'input.my_method == "power"',
                     numericInput("N", "Sample size", min = 1, value = 1000, step = 1)),
    conditionalPanel(condition = 'input.my_method == "samp_size"',
                     numericInput("epower", "Power", min = 0, max = 1, value = 0.8))),

    wellPanel(numericInput("alpha", HTML("\\(\\alpha\\)"), min = 0, max = 1, value = 0.05),
              helpText("Type-I error rate")),
    
    wellPanel(numericInput("byx", HTML("\\(\\beta_{yx}\\)"), value = 0),
              helpText("The regression coefficient \\(\\beta_{yx}\\) for the true underlying causal association between the exposure \\((X)\\) and outcome \\((Y)\\) variables")),
    
    wellPanel(numericInput("bOLS", HTML("\\(\\beta_{OLS}\\)"), value = 0),
              helpText("The regression coefficient \\(\\beta_{OLS}\\) for the observational association between the exposure \\((X)\\) and outcome \\((Y)\\) variables")),
    
    wellPanel(numericInput("R2xz", HTML("\\(R^2_{xz}\\)"), min = 0, max = 1, value = 0.01),
              helpText("Proportion of variance explained for the association between the snp \\((Z)\\) and the exposure variable \\((X)\\)")),
    
    wellPanel(numericInput("varx", HTML("\\(\\sigma^2(x)\\)"), value = 1),
              helpText("Variance of the exposure variable \\((X)\\)")),
    
    wellPanel(numericInput("vary", HTML("\\(\\sigma^2(y)\\)"), value = 1),
              helpText("Variance of the outcome variable \\((Y)\\)")))
}

app_input_binary <- function() {
 list()
}